import os
import gspread
import psycopg2
from google.oauth2.service_account import Credentials
from dotenv import load_dotenv
from sentence_transformers import SentenceTransformer, util

modelo = SentenceTransformer('paraphrase-MiniLM-L6-v2')

# Cargar variables de entorno
load_dotenv(dotenv_path='../../core/config/.env')

# Conectar a PostgreSQL
conn = psycopg2.connect(
    dbname=os.getenv('DB_NAME'),
    user=os.getenv('DB_USER'),
    password=os.getenv('DB_PASSWORD'),
    host=os.getenv('DB_HOST'),
    port=os.getenv('DB_PORT')
)
cursor = conn.cursor()

cursor.execute("SELECT nombre_comuna FROM pnl.comunas;")
comunas_oficiales = [row[0] for row in cursor.fetchall()]

# Convertir comunas oficiales en embeddings
comunas_embeddings = modelo.encode(comunas_oficiales, convert_to_tensor=True)


def normalizar_comuna(comuna_ingresada):
    comuna_embedding = modelo.encode(comuna_ingresada, convert_to_tensor=True)
    puntuaciones = util.pytorch_cos_sim(comuna_embedding, comunas_embeddings)
    mejor_idx = puntuaciones.argmax().item()
    return comunas_oficiales[mejor_idx]


# Credenciales de Google Sheets
SERVICE_ACCOUNT_FILE = os.getenv('SERVICE_ACCOUNT_FILE')
SPREADSHEET_ID = "1pLVrEbU8W8wTV2cw6x1c8ZfQUTKPNj7pve5R8xqdoc0"
WORKSHEET_NAME = "Respuestas de formulario 1"

# Conectar con Google Sheets
creds = Credentials.from_service_account_file(SERVICE_ACCOUNT_FILE, scopes=["https://www.googleapis.com/auth/spreadsheets"])
client = gspread.authorize(creds)
worksheet = client.open_by_key(SPREADSHEET_ID).worksheet(WORKSHEET_NAME)
data = worksheet.get_all_values()

# Extraer encabezados y registros
headers = data[0]
rows = data[1:]

# Formatear datos según la estructura de la tabla
formatted_rows = []
for row in rows:
    timestamp_respuesta = row[0]
    correo_electronico = row[1]
    telefono = row[2]
    comuna = normalizar_comuna(row[3])
    calle = row[4]
    numeracion = row[5]
    militancia_previa = row[6]
    candidatura_previa = row[7]
    cargo_candidatura_previa = row[8]
    profesion = row[9]
    estado_civil = row[10]
    motivacion = row[11]
    roles = row[12]
    rut = row[13]

    formatted_rows.append((
        timestamp_respuesta, correo_electronico, telefono, comuna, calle, numeracion,
        militancia_previa, candidatura_previa, cargo_candidatura_previa, profesion,
        estado_civil, motivacion, roles, rut
    ))


# Query de inserción con `ON CONFLICT` para evitar duplicados en `RUT`
insert_query = """
    INSERT INTO staging.var_formulario_bienvenida (
        timestamp_respuesta, correo_electronico, telefono, comuna, calle, numeración,
        militancia_previa, candidatura_previa, cargo_candidatura_previa, profesion,
        estado_civil, motivacion, roles, rut
    )
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    ON CONFLICT (rut) DO UPDATE SET comuna = EXCLUDED.comuna;
"""

# Insertar datos en la base de datos
cursor.executemany(insert_query, formatted_rows)

# Confirmar cambios
conn.commit()
cursor.close()
conn.close()

print("Datos insertados correctamente en staging.var_formulario_bienvenida.")
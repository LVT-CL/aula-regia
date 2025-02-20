import os
import sendgrid
from sendgrid.helpers.mail import Mail, Attachment, FileContent, FileName, FileType, Disposition
import pandas as pd
import psycopg2
from psycopg2.extras import DictCursor
from dotenv import load_dotenv
import base64

# Cargar variables de entorno
load_dotenv(dotenv_path='../../core/config/.env')

# Configuración de conexión a PostgreSQL
DB_CONFIG = {
    "dbname": os.getenv("DB_NAME"),
    "user": os.getenv("DB_USER"),
    "password": os.getenv("DB_PASSWORD"),
    "host": os.getenv("DB_HOST"),
    "port": os.getenv("DB_PORT"),
}

# Configuración de SendGrid
SENDGRID_API_KEY = os.getenv("SENDGRID_API_KEY")

# Directorio donde se guardarán los archivos
OUTPUT_DIR = "../mailing/tmp/militantes_por_comuna/"
os.makedirs(OUTPUT_DIR, exist_ok=True)

# Consulta SQL base
QUERY = """
SELECT * FROM pnl.militantes_zona WHERE numero_distrito = 10;
"""

# Conectar a PostgreSQL y ejecutar la consulta
conn = psycopg2.connect(**DB_CONFIG)
cursor = conn.cursor(cursor_factory=DictCursor)
cursor.execute(QUERY)
rows = cursor.fetchall()

# Convertir resultados en un DataFrame de Pandas
df = pd.DataFrame(rows, columns=[desc[0] for desc in cursor.description])

# Cerrar conexión
cursor.close()
conn.close()

# Obtener valores únicos de comuna
comunas_unicas = df["nombre_comuna"].unique()
generated_files = []

# Generar un archivo XLSX por cada comuna
for comuna in comunas_unicas:
    df_comuna = df[df["nombre_comuna"] == comuna]

    # Definir el nombre del archivo
    file_name = f"{OUTPUT_DIR}militantes_{comuna.replace(' ', '_')}.xlsx"

    # Guardar el DataFrame en un archivo Excel
    df_comuna.to_excel(file_name, index=False)

    generated_files.append(file_name)
    print(f"✅ Archivo generado: {file_name}")

print("🚀 Todos los archivos XLSX han sido generados con éxito.")

# Enviar los archivos por correo con SendGrid
def send_email(files):
    sg = sendgrid.SendGridAPIClient(api_key=SENDGRID_API_KEY)
    message = Mail(
        from_email='metropolitana@nacionallibertario.cl',
        to_emails='lucianovalenzuelat@gmail.com',
        subject="Archivos de militantes por comuna",
        plain_text_content="Adjunto encontrarás los archivos XLSX generados por comuna."
    )

    # Adjuntar archivos
    for file_path in files:
        with open(file_path, "rb") as attachment:
            encoded_file = base64.b64encode(attachment.read()).decode()
            file_name = os.path.basename(file_path)

            attachment = Attachment(
                file_content=FileContent(encoded_file),
                file_type=FileType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"),
                file_name=FileName(file_name),
                disposition=Disposition("attachment")
            )
            message.attachment = attachment

    # Enviar correo
    try:
        response = sg.send(message)
        print(f"📧 Correo enviado alucianovalenzuelat@gmail.com. Status Code: {response.status_code}")
    except Exception as e:
        print(f"❌ Error enviando el correo: {e}")

# Ejecutar el envío de correo
send_email(generated_files)
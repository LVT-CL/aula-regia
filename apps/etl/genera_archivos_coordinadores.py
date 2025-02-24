import os
import pandas as pd
import psycopg2
from psycopg2.extras import DictCursor
from dotenv import load_dotenv
from apps.mailing.envio_mails import enviar_correo_planilla_coordinador_comunal

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
SENDGRID_TEMPLATE_ID = "d-62462d5113664027a3d565973d0942e1"

# Directorio donde se guardarán los archivos
OUTPUT_DIR = "../mailing/tmp/militantes_por_comuna/"
os.makedirs(OUTPUT_DIR, exist_ok=True)


def generacion_envio_comunal(numero_distrito):
    """
    Genera archivos de militantes por comuna para un distrito específico y los envía por correo a los coordinadores correspondientes.

    :param numero_distrito: Número del distrito electoral a procesar.
    """
    # Consulta SQL base para obtener militantes por comuna
    QUERY_MILITANTES = f"""
    SELECT * FROM pnl.militantes_zona WHERE numero_distrito = {numero_distrito};
    """

    QUERY_FECHA = f"""
    SELECT MAX(fecha_afiliacion) AS fecha_datos FROM pnl.militantes_zona WHERE numero_distrito = {numero_distrito};
    """

    # Consulta SQL para obtener los coordinadores por comuna
    QUERY_COORDINADORES = """
    SELECT c.nombre AS nombre_coordinador, c.email, cc.nombre_comuna
    FROM pnl.coordinadores c
    JOIN pnl.coordinador_comuna cc ON c.id = cc.coordinador_id;
    """

    # Conectar a PostgreSQL y ejecutar consultas
    conn = psycopg2.connect(**DB_CONFIG)
    cursor = conn.cursor(cursor_factory=DictCursor)

    # Obtener datos de militantes
    cursor.execute(QUERY_MILITANTES)
    rows = cursor.fetchall()
    df = pd.DataFrame(rows, columns=[desc[0] for desc in cursor.description])

    # Obtener datos de coordinadores
    cursor.execute(QUERY_COORDINADORES)
    coordinadores_data = cursor.fetchall()

    # Obtener la fecha de los datos
    cursor.execute(QUERY_FECHA)
    fecha_datos = cursor.fetchone()["fecha_datos"]
    fecha_datos_string = fecha_datos.strftime("%d/%m/%Y")

    # Cerrar conexión
    cursor.close()
    conn.close()

    # Convertir datos de coordinadores en un diccionario
    coordinadores = {row["nombre_comuna"]: {"nombre": row["nombre_coordinador"], "email": row["email"]} for row in
                     coordinadores_data}

    for comuna in df["nombre_comuna"].unique():

        # Filtrar el DataFrame por comuna
        df_comuna = df[df["nombre_comuna"] == comuna]

        # Definir el nombre del archivo
        file_name = f"{OUTPUT_DIR}militantes_{comuna.replace(' ', '_')}.xlsx"

        # Guardar el DataFrame en un archivo Excel
        df_comuna.to_excel(file_name, index=False)

        print(f"✅ Archivo generado: {file_name}")

        # Verificar si hay un coordinador asignado a la comuna
        if comuna in coordinadores:
            nombre_coordinador = coordinadores[comuna]["nombre"]
            destinatario = coordinadores[comuna]["email"]

            print(f"📧 Enviando correo a {nombre_coordinador} ({destinatario})")

            # Enviar correo al coordinador con el archivo adjunto
            enviar_correo_planilla_coordinador_comunal(
                destinatario=destinatario,
                nombre_coordinador=nombre_coordinador,
                comuna=comuna,
                fecha_datos=fecha_datos_string,
                nombre_archivo=file_name
            )

    print("🚀 Todos los correos han sido enviados con éxito.")




# Llamada a la función con el distrito deseado (ejemplo: 10)
if __name__ == "__main__":
    distrito = 10  # Puedes cambiar este número según el distrito que quieras procesar
    enviar_militantes_por_distrito(distrito)
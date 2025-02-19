import os
import pandas as pd
from dotenv import load_dotenv
from sendgrid import SendGridAPIClient
from sendgrid.helpers.mail import Mail
from sqlalchemy import create_engine, text

# Cargar variables de entorno
load_dotenv(dotenv_path='../../core/config/.env')
API_KEY = os.getenv('GEO_API_KEY')
user = os.getenv('DB_USER')
password = os.getenv('DB_PASSWORD')
schema = os.getenv('DB_STAGING_SCHEMA', 'staging')
host = os.getenv('DB_HOST', 'localhost')
port = os.getenv('DB_PORT', '5432')
dbname = os.getenv('DB_NAME', 'aula-regia')

def enviar_correo_bienvenida(destinatario, saludo, nombre, nombre_coordinador, telefono_coordinador, rut, ):
    # Reemplaza con tu API Key de SendGrid
    SENDGRID_API_KEY = os.environ.get('SENDGRID_API_KEY')

    # Crea el objeto Mail
    mensaje = Mail(
        from_email='metropolitana@nacionallibertario.cl',  # Cambia por tu correo remitente
        to_emails=destinatario
    )

    # Asigna el ID de la plantilla dinámica
    mensaje.template_id = 'd-2fd8e22faa3e4bbab07af554ba6367b1'

    # Establece los datos dinámicos de la plantilla
    mensaje.dynamic_template_data = {
        'saludo': saludo,
        'nombre': nombre,
        'nombre_coordinador': nombre_coordinador,
        'telefono_coordinador': telefono_coordinador,
        'url_formulario': f'https://docs.google.com/forms/d/e/1FAIpQLSe0vF2vCJTEnbeq1UfZyd-mTQZGXnsJYlF1lLjSTK7Cn8L-Aw/viewform?usp=pp_url&entry.102156767={rut}'
    }

    try:
        sg = SendGridAPIClient(SENDGRID_API_KEY)
        respuesta = sg.send(mensaje)
        print(f'Correo enviado: {respuesta.status_code}')
    except Exception as e:
        print(f'Error al enviar el correo: {e}')

def envio_bienvenida_nuevos_militantes():
    try:
        # Configuración de la base de datos
        connection_string = f'postgresql+psycopg2://{user}:{password}@{host}:{port}/{dbname}?options=-c%20search_path%3D{schema}'
        engine = create_engine(connection_string)
        print("Cadena de conexión creada")

        # Consulta SQL
        query = """            
            SELECT
                rut,
                nombre,
                correo_electronico AS email,
                saludo,
                nombre_coordinador,
                telefono_coordinador
            FROM
                pnl.mail_bienvenida
        """

        # Cargar los datos en un DataFrame
        df = pd.read_sql(query, engine)
        print(f"DataFrame cargado con {len(df)} registros")

        # Enviar correo de bienvenida a cada militante
        for index, row in df.iterrows():
            enviar_correo_bienvenida(row['email'], row['saludo'], row['nombre'], row['nombre_coordinador'], row['telefono_coordinador'], row['rut'])

            # Registrar el envío del correo en la tabla de logs
            with engine.begin() as connection:
                    connection.execute(text("""
                        INSERT INTO pnl.log_envio_correos (rut, template_id, tipo_correo, nombre_campaña, fecha_envio, timestamp_envio)
                        VALUES (:rut, :template_id, :tipo_correo, :nombre_campaña, CURRENT_DATE, CURRENT_TIMESTAMP)
                    """), {'rut': row['rut'], 'template_id': 'd-2fd8e22faa3e4bbab07af554ba6367b1', 'tipo_correo': 'Transaccional', 'nombre_campaña': 'bienvenida'})
                    print(f"Correo enviado a {row['email']}")
        print("Correos enviados")

    except Exception as e:
        print(f"Error: {e}")

envio_bienvenida_nuevos_militantes()
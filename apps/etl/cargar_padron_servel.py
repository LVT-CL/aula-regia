import pandas as pd
import uuid
from datetime import datetime
from sqlalchemy import create_engine
import os
from dotenv import load_dotenv
import apps.etl.utilitarios as util

def load_var_padron_servel(ruta_archivo, nombre_hoja):
    try:
        # Configuración de la base de datos
        user = os.getenv('DB_USER')
        password = os.getenv('DB_PASSWORD')
        schema = os.getenv('DB_STAGING_SCHEMA', 'staging')
        host = os.getenv('DB_HOST', 'db')
        port = os.getenv('DB_PORT', '5432')
        dbname = os.getenv('DB_NAME', 'aula-regia')

        # Crear la cadena de conexión
        connection_string = f'postgresql+psycopg2://{user}:{password}@{host}:{port}/{dbname}?options=-c%20search_path%3D{schema}'
        engine = create_engine(connection_string)
        print("Cadena de conexión creada")

        # Cargar el archivo Excel
        df = pd.read_excel(ruta_archivo, sheet_name=nombre_hoja, header=0)
        print(f"DataFrame cargado con {len(df)} registros")

        # Generar un ID único para el archivo y fecha de proceso
        id_archivo = str(uuid.uuid4())
        fecha_proceso = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        print(f"ID de archivo generado: {id_archivo}")
        print(f"Fecha de proceso generada: {fecha_proceso}")

        # Agregar columnas ID_ARCHIVO y FECHA_PROCESO
        df['ID_ARCHIVO'] = id_archivo
        df['FECHA_PROCESO'] = fecha_proceso

        # Insertar registros en la base de datos de manera masiva
        with engine.begin() as connection:
            df.to_sql('var_padron_servel', connection, schema=schema, if_exists='append', index=False)
            print("Registros insertados en la base de datos")

        return id_archivo

    except Exception as e:
        print(f"Error: {e}")

def load_tmp_padron_servel(id_archivo):
    try:
        # Configuración de la base de datos
        user = os.getenv('DB_USER')
        password = os.getenv('DB_PASSWORD')
        schema = os.getenv('DB_STAGING_SCHEMA', 'staging')
        host = os.getenv('DB_HOST', 'db')
        port = os.getenv('DB_PORT', '5432')
        dbname = os.getenv('DB_NAME', 'aula-regia')

        # Crear la cadena de conexión
        connection_string = f'postgresql+psycopg2://{user}:{password}@{host}:{port}/{dbname}?options=-c%20search_path%3D{schema}'
        engine = create_engine(connection_string)
        print("Cadena de conexión creada")

        # Ejecutar Script de creación de particiones
        print("Creando partición...")
        util.ejecutar_sql_desde_archivo('/apps/etl/sql/create_partition_tmp_padron_servel.sql',
                                        {'ID_ARCHIVO': id_archivo},
                                        engine)
        print("Partición creada")

        print("Insertando registros en tabla tmp_padron_servel...")
        util.ejecutar_sql_desde_archivo('/apps/etl/sql/insert_tmp_padron_servel.sql',
                                        {'ID_ARCHIVO': id_archivo},
                                        engine)
        print("Registros insertados en tabla tmp_padron_servel")


    except Exception as e:
        print(f"Error: {e}")

id_archivo = load_var_padron_servel("/app/docs/servel/REGION METROPOLITANA 18 02 25.xlsx", 'Hoja1')

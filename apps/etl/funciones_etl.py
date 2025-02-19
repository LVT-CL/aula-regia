import pandas as pd
import requests
from dotenv import load_dotenv

def cargar_hoja_excel_a_dataframe(ruta_archivo, nombre_hoja):
    """
    Carga una hoja de un archivo Excel en formato xls a un DataFrame de pandas.

    :param ruta_archivo: Ruta del archivo Excel en el disco.
    :param nombre_hoja: Nombre de la hoja a cargar.
    :return: DataFrame con los datos de la hoja seleccionada.
    """
    try:
        df = pd.read_excel(ruta_archivo, sheet_name=nombre_hoja, header=0)
        return df
    except Exception as e:
        print(f"Error al cargar la hoja de Excel: {e}")
        return None

def limpiar_columna(df, nombre_columna):
    """
    Limpia una columna del DataFrame de caracteres especiales y espacios innecesarios.

    :param df: DataFrame de pandas.
    :param nombre_columna: Nombre de la columna a limpiar.
    :return: DataFrame con la columna limpiada.
    """
    df[nombre_columna] = df[nombre_columna].str.replace(r'[^\w\s]', '', regex=True).str.strip()
    return df

def procesa_nombres(df, nombre_columna='Nombre'):
    """
    Procesa los nombres de una columna de un DataFrame, limpiando caracteres especiales y espacios innecesarios,
    y capitalizando cada palabra.

    :param df: DataFrame de pandas.
    :param nombre_columna: Nombre de la columna a procesar. Por defecto es 'Nombre'.
    :return: DataFrame con los nombres procesados.
    """
    df = limpiar_columna(df, nombre_columna)
    df[nombre_columna] = df[nombre_columna].str.title()
    return df

def limpia_telefonos(df, nombre_columna='Teléfono', largo_numero=8):
    """
    Limpia y formatea una columna de teléfonos en un DataFrame al formato WhatsApp.

    :param df: DataFrame de pandas.
    :param nombre_columna: Nombre de la columna que contiene los números de teléfono.
    :param largo_numero: Largo del número de teléfono sin el código de país. Por defecto es 8 para Chile.
    :return: DataFrame con la columna de teléfonos formateada.
    """
    df[nombre_columna] = df[nombre_columna].astype(str).str.replace(r'[^\d]', '', regex=True).str[-largo_numero:]
    df[nombre_columna] = '+569' + df[nombre_columna]
    return df

def limpia_correos(df, nombre_columna='Correo'):
    """
    Limpia y formatea una columna de correos electrónicos en un DataFrame.

    :param df: DataFrame de pandas.
    :param nombre_columna: Nombre de la columna que contiene los correos electrónicos.
    :return: DataFrame con la columna de correos electrónicos formateada.
    """
    df[nombre_columna] = df[nombre_columna].str.lower().str.strip()
    df = df[df[nombre_columna].str.contains(r'^[\w\.-]+@[\w\.-]+\.\w+$')]
    return df


def verifica_valores(df, nombre_columna, valores_validos):
    """
    Verifica si los valores de una columna en un DataFrame son válidos.

    :param df: DataFrame de pandas.
    :param nombre_columna: Nombre de la columna a verificar.
    :param valores_validos: Lista de valores válidos.
    :return: DataFrame con los valores válidos.
    """
    df = df[df[nombre_columna].isin(valores_validos)]
    return df

def recupera_valores_niveles_administrativos(engine, pais, nivel):
    """
    Recupera los valores de un nivel administrativo de un país desde la base de datos.

    :param pais: Código ISO del país.
    :param nivel: Nivel administrativo a recuperar.
    :return: Lista con los valores del nivel administrativo.
    """
    import pandas as pd

    query = f"""
            WITH pais_id AS (
                SELECT id
                FROM paises
                WHERE codigo_iso = '{pais}'
            ),
            estructura_nivel_id AS (
                SELECT id
                FROM estructura_niveles
                WHERE nombre = '{nivel}'
                AND pais_id = (SELECT id FROM pais_id)
            )
            SELECT
                nombre
            FROM
                niveles_administrativos
            WHERE
                estructura_nivel_id = (SELECT id FROM estructura_nivel_id);
            """
    valores = pd.read_sql(query, engine)['nombre'].tolist()
    return valores

def obtener_geolocalizacion_google(direccion, api_key ):
    url = "https://maps.googleapis.com/maps/api/geocode/json"
    params = {
        "address": direccion,
        "key": api_key
    }

    response = requests.get(url, params=params)

    if response.status_code == 200:
        data = response.json()
        if data["status"] == "OK":
            resultado = data["results"][0]
            return {
                "latitud": resultado["geometry"]["location"]["lat"],
                "longitud": resultado["geometry"]["location"]["lng"],
                "direccion_formateada": resultado["formatted_address"]
            }
        else:
            print("Error en la respuesta:", data["status"])
    else:
        print("Error en la solicitud:", response.status_code)

    return None


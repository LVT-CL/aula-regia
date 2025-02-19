import sys
import os

# Add the root directory of your project to the PYTHONPATH
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from apps.etl.funciones_etl import cargar_hoja_excel_a_dataframe


def test_cargar_hoja_excel_a_dataframe():
    ruta_archivo = "E:\\DataLake\\planillas_pnl\\Padrón Distrito 10.xlsx"
    nombre_hoja = 'Hoja1'

    # Verifica que el archivo de ejemplo existe
    if not os.path.exists(ruta_archivo):
        print(f"El archivo {ruta_archivo} no existe.")
        return

    # Llama a la función y obtiene el DataFrame
    df = cargar_hoja_excel_a_dataframe(ruta_archivo, nombre_hoja)

    # Verifica que el DataFrame no sea None
    if df is not None:
        print("La hoja de Excel se cargó correctamente.")
        print(df.head())  # Muestra las primeras filas del DataFrame
    else:
        print("Hubo un error al cargar la hoja de Excel.")



# Ejecuta la prueba
test_cargar_hoja_excel_a_dataframe()
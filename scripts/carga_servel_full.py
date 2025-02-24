import apps.etl.cargar_padron_servel as cps
from dotenv import load_dotenv
import os

RUTA_ARCHIVO = "/app/docs/servel/REGION METROPOLITANA 18 02 25.xlsx"
NOMBRE_HOJA = 'Hoja1'

# Ejecuta la carga del archivo a tabla staging.var_padron_servel
ID_ARCHIVO = cps.load_var_padron_servel(RUTA_ARCHIVO, NOMBRE_HOJA)

# Carga la tabla staging.tmp_padron_servel)
cps.load_tmp_padron_servel(ID_ARCHIVO)
import requests
import psycopg2
from psycopg2.extras import DictCursor
import time
import os
from dotenv import load_dotenv

# Cargar variables de entorno
load_dotenv(dotenv_path='../../core/config/.env')
API_KEY = os.getenv('GEO_API_KEY')
user = os.getenv('DB_USER')
password = os.getenv('DB_PASSWORD')
schema = os.getenv('DB_STAGING_SCHEMA', 'staging')
host = os.getenv('DB_HOST', 'localhost')
port = os.getenv('DB_PORT', '5432')
dbname = os.getenv('DB_NAME', 'aula-regia')

# Configuración de la API de Google

# Configuración de la base de datos PostgreSQL
DB_CONFIG = {
    "dbname": dbname,
    "user": user,
    "password": password,
    "host": host,
    "port": 5432
}

# Función para obtener geolocalización desde Google Maps API
def obtener_geolocalizacion_google(direccion, comuna, pais):
    """Consulta la API de Google Maps y devuelve latitud, longitud y dirección formateada."""
    url = "https://maps.googleapis.com/maps/api/geocode/json"
    direccion_completa = f"{direccion}, {comuna}, {pais}"
    params = {
        "address": direccion_completa,
        "key": API_KEY
    }

    response = requests.get(url, params=params)
    data = response.json()

    if response.status_code == 200 and data["status"] == "OK":
        resultados = data["results"]
        mejor_resultado = None

        for resultado in resultados:
            lat = resultado["geometry"]["location"]["lat"]
            lon = resultado["geometry"]["location"]["lng"]
            direccion_formateada = resultado["formatted_address"]
            location_type = resultado["geometry"].get("location_type", "")

            # Si encontramos una ubicación exacta (ROOFTOP), la tomamos de inmediato
            if location_type == "ROOFTOP":
                mejor_resultado = (lat, lon, direccion_formateada, location_type)
                break

                # Si la comuna está en la dirección formateada, la preferimos
            if comuna.lower() in direccion_formateada.lower():
                mejor_resultado = (lat, lon, direccion_formateada, location_type)

        # Si no hay coincidencias perfectas, tomamos la primera como fallback
        if not mejor_resultado and resultados:
            mejor_resultado = (
                resultados[0]["geometry"]["location"]["lat"],
                resultados[0]["geometry"]["location"]["lng"],
                resultados[0]["formatted_address"],
                resultados[0]["geometry"].get("location_type", "")
            )

        return mejor_resultado if mejor_resultado else (None, None, None, None)

    print(f"⚠ No se pudo geolocalizar: {direccion_completa}")
    return None, None, None, None


# Función para actualizar la base de datos con los datos obtenidos
def actualizar_geolocalizacion():
    """Obtiene direcciones sin coordenadas y las geolocaliza usando la API de Google."""
    conn = psycopg2.connect(**DB_CONFIG)

    with conn.cursor(cursor_factory=DictCursor) as cur:
        # 1. Seleccionar direcciones sin geolocalización
        cur.execute("""
            SELECT id, domicilio_electoral, nombre_comuna, nombre_pais
            FROM pnl.geolocalizacion
            WHERE latitud IS NULL OR longitud IS NULL
            LIMIT 5000;  -- Procesamos en lotes para evitar saturación
        """)
        direcciones_pendientes = cur.fetchall()

        for row in direcciones_pendientes:
            id_direccion = row["id"]
            direccion = row["domicilio_electoral"]
            comuna = row["nombre_comuna"]
            pais = row["nombre_pais"]

            # 2. Obtener coordenadas desde la API
            latitud, longitud, direccion_formateada, location_type = obtener_geolocalizacion_google(direccion, comuna,
                                                                                                    pais)

            if latitud and longitud:
                # 3. Actualizar la tabla con la nueva geolocalización
                cur.execute("""
                    UPDATE pnl.geolocalizacion
                    SET latitud = %s, longitud = %s, direccion_formateada = %s, 
                        location_type = %s, ultima_actualizacion = NOW()
                    WHERE id = %s;
                """, (latitud, longitud, direccion_formateada, location_type, id_direccion))

                print(f"✅ Dirección actualizada: {direccion} -> ({latitud}, {longitud})")
            else:
                print(f"❌ No se encontró una ubicación precisa para: {direccion}")

            # 4. Pausar para evitar límite de consultas de la API
            time.sleep(0.1)  # Google limita a 1 consulta por segundo en planes gratuitos

        # Confirmar cambios en la BD
        conn.commit()

    conn.close()


# Ejecutar la actualización
actualizar_geolocalizacion()

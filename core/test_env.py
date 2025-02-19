from dotenv import load_dotenv
import os

# Cargar el archivo .env
load_dotenv(os.path.join(os.path.dirname(__file__), "config", ".env"))

# Leer las variables
database_url = os.getenv("DATABASE_URL")
secret_key = os.getenv("SECRET_KEY")
debug = os.getenv("DEBUG")

# Imprimir las variables
print("DATABASE_URL:", database_url)
print("SECRET_KEY:", secret_key)
print("DEBUG:", debug)
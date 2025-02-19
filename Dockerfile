# Usa una imagen base de Python
FROM python:3.13

# Define el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia los archivos de dependencias
COPY requirements/core_requirements.txt ./requirements.txt

# Instala las dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Copia todo el código del proyecto al contenedor
COPY . .

# Mantiene el contenedor activo sin ejecutar nada
CMD ["tail", "-f", "/dev/null"]
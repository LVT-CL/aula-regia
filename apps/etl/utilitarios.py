def ejecutar_sql_desde_archivo(archivo_sql, parametros, conexion):
    """
    Lee un archivo SQL, reemplaza los parámetros con los valores dados y lo ejecuta en la base de datos.

    :param archivo_sql: Ruta al archivo .sql
    :param parametros: Diccionario con los valores a reemplazar en la consulta SQL
    :param conexion: Objeto de conexión a la base de datos PostgreSQL
    """
    try:
        # Leer el archivo SQL
        with open(archivo_sql, 'r', encoding='utf-8') as file:
            sql_script = file.read()

        # Reemplazar los placeholders en el script
        for clave, valor in parametros.items():
            placeholder = f'{{{{ {clave} }}}}'  # Formato: {{ nombre_parametro }}
            sql_script = sql_script.replace(placeholder, str(valor))

        # Ejecutar el script SQL
        with conexion.cursor() as cursor:
            cursor.execute(sql_script)
            conexion.commit()
        print("Consulta ejecutada exitosamente.")

    except Exception as e:
        print(f"Error al ejecutar la consulta: {e}")
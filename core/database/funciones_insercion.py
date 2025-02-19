from sqlalchemy import text

def insertar_persona(connection, row):
    """
    Inserta una persona en la base de datos si no existe.

    :param connection: Conexión a la base de datos.
    :param row: Fila del DataFrame con los datos de la persona.
    """
    insert_query = text("""
        INSERT INTO personas (nombres, apellido_paterno, apellido_materno, rut, sexo)
        SELECT :nombres, :apellido_paterno, :apellido_materno, :rut, :sexo
        WHERE NOT EXISTS (
            SELECT 1 FROM personas WHERE rut = :rut
        RETURNING id
        );
    """)
    # Bind parameters to the query
    result = connection.execute(insert_query, {
        'nombres': row['Nombres'],
        'apellido_paterno': row['Apellido Paterno'],
        'apellido_materno': row['Apellido Materno'],
        'rut': row['Rut'],
        'sexo': row['Sexo']
    })
    connection.commit()
    return result.scalar()

def insertar_telefono(connection, row, id_persona):
    """
    Inserta un teléfono en la base de datos si no existe.

    :param connection: Conexión a la base de datos.
    :param row: Fila del DataFrame con los datos del teléfono.
    :param id_persona: ID de la persona a la que pertenece el teléfono.
    """
    insert_query = text("""
        INSERT INTO telefonos (numero, id_persona)
        SELECT :numero, :id_persona
        WHERE NOT EXISTS (
            SELECT 1 FROM telefonos WHERE numero = :numero AND id_persona = :id_persona
        RETURNING id
        );
    """)
    # Bind parameters to the query
    connection.execute(insert_query, {
        'numero': row['Teléfono'],
        'id_persona': id_persona
    })
    connection.commit()
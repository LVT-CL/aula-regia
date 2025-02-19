import sys
import os

# Add the root directory of your project to the PYTHONPATH
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

import unittest
import pandas as pd
from apps.etl.funciones_etl import limpiar_columna, procesa_nombres

class TestEtlFunctions(unittest.TestCase):

    def setUp(self):
        # Configuración inicial para las pruebas
        self.df = pd.DataFrame({
            'Nombre': ['Juan', 'María', 'José'],
            'Apellido': ['Pérez', 'García', 'Martínez']
        })

    def test_limpiar_columna(self):
        # Prueba para la función limpiar_columna
        df_limpio = limpiar_columna(self.df.copy(), 'Nombre')
        self.assertFalse(df_limpio['Nombre'].str.contains(r'[^\w\s]').any())
        self.assertFalse(df_limpio['Nombre'].str.contains(r'^\s|\s$').any())

    def test_procesa_nombres(self):
        # Prueba para la función procesa_nombres
        df_procesado = procesa_nombres(self.df.copy())
        print(df_procesado)  # Mensaje de depuración
        self.assertIn('Nombre', df_procesado.columns)
        self.assertIn('Apellido', df_procesado.columns)
        self.assertEqual(df_procesado.loc[0, 'Nombre'], 'Juan')
        self.assertEqual(df_procesado.loc[1, 'Nombre'], 'María')
        self.assertEqual(df_procesado.loc[2, 'Nombre'], 'José')
        self.assertEqual(df_procesado.loc[0, 'Apellido'], 'Pérez')
        self.assertEqual(df_procesado.loc[1, 'Apellido'], 'García')
        self.assertEqual(df_procesado.loc[2, 'Apellido'], 'Martínez')

if __name__ == '__main__':
    unittest.main()
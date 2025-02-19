import sys
import os

# Add the root directory of your project to the PYTHONPATH
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

import unittest
import pandas as pd
from apps.etl.funciones_etl import limpia_telefonos

class TestLimpiaTelefonos(unittest.TestCase):

    def setUp(self):
        # Configuración inicial para las pruebas
        self.df = pd.DataFrame({
            'Teléfono': ['+56 9 1234 5678', '912345678', '(+56) 9 8765 4321', '987654321']
        })

    def test_limpia_telefonos(self):
        # Prueba para la función limpia_telefonos
        df_limpio = limpia_telefonos(self.df.copy())
        self.assertEqual(df_limpio.loc[0, 'Teléfono'], '+56912345678')
        self.assertEqual(df_limpio.loc[1, 'Teléfono'], '+56912345678')
        self.assertEqual(df_limpio.loc[2, 'Teléfono'], '+56987654321')
        self.assertEqual(df_limpio.loc[3, 'Teléfono'], '+56987654321')

if __name__ == '__main__':
    unittest.main()
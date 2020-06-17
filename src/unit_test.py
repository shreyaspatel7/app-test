import unittest
from app import hello_world, ready

class TestStringMethods(unittest.TestCase):

    def test_upper(self):
        self.assertEqual(hello_world(), 'Hello World')

    def test_isupper(self):
        self.assertEqual(ready(),'It works!')

if __name__ == '__main__':
    unittest.main()
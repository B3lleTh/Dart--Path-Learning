//desarrolla un programa en dart que use listas de tipo numerico (enteros), esta lista debe ser tratado como una stack, y crear sus funciones push y pop, la lista debe ser de 5 elementos


void main() {
  Stack pila = Stack();

  pila.push(10);
  pila.push(20);
  pila.push(30);
  pila.push(40);
  pila.push(50);

  pila.push(60); // Intento de overflow

  print("Elemento eliminado: ${pila.pop()}");
  print("Elemento eliminado: ${pila.pop()}");

  pila.mostrar();
}

class Stack {
  static const int maxSize = 5;
  List<int> _lista = [];

  // Función push
  void push(int valor) {
    if (_lista.length < maxSize) {
      _lista.add(valor);
      print("Push: $valor agregado");
    } else {
      print("Error: Stack llena (Overflow)");
    }
  }

  // Función pop
  int? pop() {
    if (_lista.isNotEmpty) {
      int valor = _lista.removeLast();
      return valor;
    } else {
      print("Error: Stack vacía (Underflow)");
      return null;
    }
  }

  // Mostrar contenido de la pila
  void mostrar() {
    print("Contenido actual de la pila: $_lista");
  }
}

import 'dart:io';

int sums(int limit) { //Funcion Sin Recursividad
  int value = 0;

  for (int i = limit; i > 0; i--) {
    value += i;
  }
  return value;
}

int recursive(int limit) { //Funcion Con Recursividad
  if (limit <= 1) {
    return limit;
  }
  return limit + recursive(limit - 1);
}

void main() {
  print("============== Tarea : Sumatorias Consecuentes =============");
  stdout.write("Ingresa un Numero Entre el 1 - 1000: ");
  String initialValue = stdin.readLineSync() ?? "";

  int? parseInitialValue = int.tryParse(initialValue);

  if (parseInitialValue != null && parseInitialValue >= 1 && parseInitialValue <= 1000) {
    int result = sums(parseInitialValue); //Sin Recursividad

    int resultado = recursive(parseInitialValue); //Con Recursividad

    print("\nEl resultado Con Recursividad es : $resultado");
    print("\nEl Resultado Sin Recursividad es: $result");
  } else {
    print("============== Invalid Input =========");
  }
}

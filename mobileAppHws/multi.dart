import 'dart:io';

int multi(int table) {
  
  int value = 0;

  for(int i = table; i > 0; i--){

    value += i;

  }

  return value;

}

void main() {
  print(
    "================= Programa de Practica Calcular y mostrar Multiplicaciones Con Recursividad ============",
  );

  stdout.write("Ingresa un Numero para Calcular su Multiplicacion Consecutiva: ");
  String unParseValue = stdin.readLineSync()!;

  int? parseValue = int.tryParse(unParseValue);

  int result = multi(parseValue!);

  print("El resultado de la multiplicacion es: $result");
}

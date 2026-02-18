import 'dart:io';

int factorial(int limit){

  if(limit <= 0){
    return 1;
  }

  return limit * factorial(limit - 1);

}



void main(){
  print("=========== PROGRAMA DE PRACTICA RECURSIVIDAD Y FUNCIONES =========");

  stdout.write("Ingresa el Factorial a Calcular: ");
  String initialValue = stdin.readLineSync() ?? "";

  int? parseInitialValue = int.tryParse(initialValue);

  int result = factorial(parseInitialValue!);


  print("El valor es: $result");
}
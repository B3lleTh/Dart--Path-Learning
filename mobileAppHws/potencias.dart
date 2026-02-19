import 'dart:io';

int expo(int bases, exponent){

  if(exponent <= 0){
    return 1;
  }
  return bases * expo(bases,exponent - 1);

}



void main(){
  print("=========== PROGRAMA DE PRACTICA POTENCIAS =========");

  stdout.write("Ingresa tu Base: ");
  String initialBase = stdin.readLineSync() ?? "";

   stdout.write("Ingresa tu Exponente: ");
  String initialExponent = stdin.readLineSync() ?? "";


  int? parseInitialBase = int.tryParse(initialBase);

  int? parseInitialExponent = int.tryParse(initialExponent);



  int result = expo(parseInitialBase!, parseInitialExponent!);


  print("El valor Final es: $result");
}
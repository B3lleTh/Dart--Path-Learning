import 'dart:io'; //Biblioteca Necesaria para Input y Output de Data
main(){
  print("--- 08 HI Program ---");
  stdout.write("Type Your Name: ");
  
  String? entrada = stdin.readLineSync();  //Standard Input - Output
  
  print('Hi $entrada, Nice to Know You!'); //Imprimir Un mensaje con el Resultado de La Variable Ingresada 
}
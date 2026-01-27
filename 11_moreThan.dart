import 'dart:io';

main(){

  print("--- 11 Program ---");
  stdout.write("Type a Number: ");
  String? n1 = stdin.readLineSync();  

  stdout.write("Type a Number: ");
  String? n2 = stdin.readLineSync();  

  double num1 = double.parse(n1 ?? '0');

  double num2 = double.parse(n2 ?? '0');

  if(num1 != num2){

    if(num1 > num2){
      print('$num1 Es Mayor');
    }else{
    print('$num1 Es Mayor');
    }
  }else{
    print("They're Equal Bastard" );
  }


}
import 'dart:io';

void main(){

  print('------------- 09 PROGRAM ---------------');

  stdout.write('Type a Number: ');

  String? number1 = stdin.readLineSync();

 stdout.write('Type the Second Number: ');

  String? number2 = stdin.readLineSync();


  double n1 = double.parse(number1 ?? 'Null Cant Do Shit');

  double n2 = double.parse(number2 ?? 'Null Cant Do Shit');

  double total = n1 + n2;

print('The Total of the Operation is $total');

}
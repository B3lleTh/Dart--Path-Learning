import 'dart:io'; 
main(){
  print("--- 10 Program ---");
  stdout.write("Type Your Name: ");
  String? name = stdin.readLineSync();  

  stdout.write("Type Your Name: ");
  String? middleName = stdin.readLineSync();  

  stdout.write("Type Your Name: ");
  String? lastName = stdin.readLineSync();  
  
  print('Hi $name $middleName $lastName Nice to Know You!'); 
}

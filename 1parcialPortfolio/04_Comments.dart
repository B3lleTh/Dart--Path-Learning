/**
 * This file demonstrates different types of comments in Dart programming language 
 * [dateCreation]: 2024-06-15
 * [author]: ChatGPT-4
 * 
 * 
 * 
 */

main() {
  // This is a single-line comment

  /*
   This is a multi-line comment.
   It can span multiple lines.
  */

  /// This is a documentation comment.
  /// It is used to document code elements like classes and functions.

  print("Comments in Dart!");

  // This is a temporal variable I want to define
  int a = 10; // A value equals to ten


  final personas = [
    // This is the first person
    'Juan', // [0]
    // This is the second person
    'Pedro', // [1]
    // This is the third person
    'Maria' // [2]
    
    ];
}



/// This function greets a person
/// Receives a [number] and a name as [parameters]
saludar (int numero, String nombre){
  // This line prints the greeting message
  print('Hola $nombre, tu número es $numero');
}

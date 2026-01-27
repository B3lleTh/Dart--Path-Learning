/**
 * Dart Math Operators
 * One operator is a symbol that tells the compiler to perform specific mathematical or logical manipulations.
 * For more details, visit: https://dart.dev/language/operators
 */

main (){
  int ab = 5;
  int a = 10 + 5; // Addition
  print(a); // Output: 15
  int b = 10 - 5; // Subtraction
  print(b); // Output: 5
  int c = 10 * 5; // Multiplication
  print(c); // Output: 50
  double d = 10 / 4; // Division
  print(d); // Output: 2.5
  d = 10 % 3; // Modulus
  print(d); // Output: 1.0
  int e = 10 ~/ 3; // Integer Division
  print(e); // Output: 3
  a = -a; // Negation
  print(a); // Output: -15
  c++; // Increment (or C = C + 1)
  print(c); // Output: 51
  b--; // Decrement (or D = D - 1)
  print(b); // Output: 4
  c += 2; // c = c + 2
  print(c); // Output: 53
  a -= 2; // a = a - 2
  print(a); // Output: -17
  a += ab; // a = a + ab
  print(a); // Output: 5
}
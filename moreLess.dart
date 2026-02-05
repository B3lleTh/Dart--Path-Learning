import 'dart:io';

void main() {
  print('--- HomeWork Mobile Development | Nested If Version ---');

  stdout.write('number 1: ');
  int a = int.parse(stdin.readLineSync()!);
  stdout.write('number 2: ');
  int b = int.parse(stdin.readLineSync()!);
  stdout.write('number 3: ');
  int c = int.parse(stdin.readLineSync()!);
  stdout.write('number 4: ');
  int d = int.parse(stdin.readLineSync()!);

  int first, second, third, forth;

  // IF ANIDADO 
  if (a >= b && a >= c && a >= d) {
    first = a;

    // Ahora buscamos el segundo entre b, c, d
    if (b >= c && b >= d) {
      second = b;
      if (c >= d) {
        third = c;
        forth = d;
      } else {
        third = d;
        forth = c;
      }
    } else if (c >= b && c >= d) {
      second = c;
      if (b >= d) {
        third = b;
        forth = d;
      } else {
        third = d;
        forth = b;
      }
    } else {
      second = d;
      if (b >= c) {
        third = b;
        forth = c;
      } else {
        third = c;
        forth = b;
      }
    }
  } else if (b >= a && b >= c && b >= d) {
    first = b;


    // Buscamos el segundo entre a, c, d
    if (a >= c && a >= d) {
      second = a;
      if (c >= d) {
        third = c;
        forth = d;
      } else {
        third = d;
        forth = c;
      }
    } else if (c >= a && c >= d) {
      second = c;
      if (a >= d) {
        third = a;
        forth = d;
      } else {
        third = d;
        forth = a;
      }
    } else {
      second = d;
      if (a >= c) {
        third = a;
        forth = c;
      } else {
        third = c;
        forth = a;
      }
    }
  } else if (c >= a && c >= b && c >= d) {
    first = c;


    // Buscamos el segundo entre a, b, d
    if (a >= b && a >= d) {
      second = a;
      if (b >= d) {
        third = b;
        forth = d;
      } else {
        third = d;
        forth = b;
      }
    } else if (b >= a && b >= d) {
      second = b;
      if (a >= d) {
        third = a;
        forth = d;
      } else {
        third = d;
        forth = a;
      }
    } else {
      second = d;
      if (a >= b) {
        third = a;
        forth = b;
      } else {
        third = b;
        forth = a;
      }
    }
  } else {
    first = d;
    
    // Buscamos el segundo entre a, b, c
    if (a >= b && a >= c) {
      second = a;
      if (b >= c) {
        third = b;
        forth = c;
      } else {
        third = c;
        forth = b;
      }
    } else if (b >= a && b >= c) {
      second = b;
      if (a >= c) {
        third = a;
        forth = c;
      } else {
        third = c;
        forth = a;
      }
    } else {
      second = c;
      if (a >= b) {
        third = a;
        forth = b;
      } else {
        third = b;
        forth = a;
      }
    }
  }

  // Validación e Impresión
  if (a == b && b == c && c == d) {
    print('\nAll equal... u Dumb?');
  } else {
    print('\n--- RESULTS ---');
    print('1º Biggest One: $first');
    print('2º The Fisrt Loser: $second');
    print('3º Reached Podium: $third');
    print('4º Little One: $forth');
    print('------------------------------');
    print("I'm Extra Tired, Please Send Help");
  }
}

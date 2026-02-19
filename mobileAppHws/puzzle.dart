import 'dart:io';
import 'dart:async';

const String JUGADOR = ' ● ';
const String RASTRO = ' · ';
const String META = ' @ ';
const String VACIO = '   ';

class Celda {
  bool n, s, e, o;
  int estado; // 0: libre, 2: rastro, 3: meta, 9: jugador
  Celda({this.n = false, this.s = false, this.e = false, this.o = false, this.estado = 0});
}

void main() async {
  // Derecha (Este): 2
  // Arriba (Norte): 1
  // Abajo (Sur): 4
  //Izquierda (Oeste): 8

  List<List<int>> configuracion = [
    [2, 0, 0, 0, 0, 0, 0, 0, 0, 3], // Fila A
    [1, 5, 5, 5, 5, 5, 5, 5, 5, 1], // Fila B
    [2, 5, 2, 0, 0, 0, 3, 5, 5, 1], // Fila C
    [1, 5, 1, 5, 5, 5, 1, 5, 5, 1], // Fila D
    [1, 5, 1, 5, 5, 5, 1, 5, 5, 1], // Fila E
    [0, 0, 4, 0, 0, 0, 4, 0, 0, 9], // Fila F (El 9 es la META)
  ];

  List<List<Celda>> laberinto = convertirMapa(configuracion);

  print('=========== Laberinto Cargado ============');
  await Future.delayed(Duration(seconds: 1));

  // Iniciamos en A1 (0,0)
  await resolver(0, 0, laberinto);
}

// Esta función traduce tus números simples a paredes reales
List<List<Celda>> convertirMapa(List<List<int>> config) {
  return List.generate(6, (f) {
    return List.generate(10, (c) {
      int tipo = config[f][c];
      Celda celda = Celda();
      
      if (tipo == 0) { celda.e = true; celda.o = true; } // Horizontal
      if (tipo == 1) { celda.n = true; celda.s = true; } // Vertical
      if (tipo == 2) { celda.s = true; celda.e = true; } // Esquina L (abajo-der)
      if (tipo == 3) { celda.s = true; celda.o = true; } // Esquina J (abajo-izq)
      if (tipo == 4) { celda.n = true; celda.s = true; celda.e = true; celda.o = true; } // Cruce
      if (tipo == 9) { celda.estado = 3; celda.n = true; celda.o = true; } // Meta
      
      return celda;
    });
  });
}

// Lógica de resolución (Universal)
Future<bool> resolver(int f, int c, List<List<Celda>> mapa) async {
  if (f < 0 || f >= 6 || c < 0 || c >= 10) return false;
  Celda actual = mapa[f][c];

  if (actual.estado == 3) { dibujar(mapa); return true; }
  if (actual.estado != 0) return false;

  actual.estado = 9; 
  dibujar(mapa);
  await Future.delayed(Duration(milliseconds: 200));
  actual.estado = 2;

  // El algoritmo revisa si hay puerta abierta antes de moverse
  if (actual.e && await resolver(f, c + 1, mapa)) return true; // Derecha
  if (actual.s && await resolver(f + 1, c, mapa)) return true; // Abajo
  if (actual.o && await resolver(f, c - 1, mapa)) return true; // Izquierda
  if (actual.n && await resolver(f - 1, c, mapa)) return true; // Arriba

  return false;
}

void dibujar(List<List<Celda>> mapa) {
  stdout.write('\x1B[2J\x1B[0;0H');
  stdout.write('    ');
  for (int i = 1; i <= 10; i++) stdout.write(' $i '.padRight(4));
  print('\n    ' + '----' * 10);

  for (int f = 0; f < mapa.length; f++) {
    stdout.write('    ');
    for (int c = 0; c < mapa[f].length; c++) 
      stdout.write(mapa[f][c].n ? '+   ' : '+---');
    print('+');

    String letra = String.fromCharCode(65 + f);
    stdout.write('$letra   ');
    for (int c = 0; c < mapa[f].length; c++) {
      Celda celda = mapa[f][c];
      stdout.write(celda.o ? ' ' : '|');
      if (celda.estado == 9) stdout.write(JUGADOR);
      else if (celda.estado == 2) stdout.write(RASTRO);
      else if (celda.estado == 3) stdout.write(META);
      else stdout.write(VACIO);
    }
    print('|');
  }
  stdout.write('    ');
  for (int c = 0; c < 10; c++) stdout.write('+---');
  print('+');
}
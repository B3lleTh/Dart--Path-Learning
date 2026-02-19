import 'dart:io';
import 'dart:async';

// Visuals 
const String PARED = '█';    // Obstacle
const String LIBRE = ' ';    // Available Space
const String JUGADOR = '●';  // The "Snake"
const String RASTRO = '·';   // Breadcrumbs (Backtracking)
const String META = '@';    // Goals (F10)

void main() async {
  // 0: Empty Space, 1: Wall, 3: Goal
  List<List<int>> laberinto = [
    [1, 1, 1, 0, 0, 0, 0, 0, 1, 0], // Fila A
    [0, 0, 0, 0, 1, 0, 1, 0, 0, 1], // Fila B
    [0, 1, 0, 1, 0, 0, 0, 0, 1, 1], // Fila C
    [0, 1, 0, 0, 0, 1, 0, 0, 0, 1], // Fila D
    [1, 0, 0, 1, 0, 0, 1, 0, 0, 0], // Fila E
    [1, 0, 1, 1, 1, 1, 0, 1, 0, 1], // Fila F  = Goal in F10
  ];

  print('=========== Begining Puzzle ============');
  await Future.delayed(Duration(seconds: 1));

  // Iniciamos la búsqueda desde A1 (índices 0,0)
  bool encontrado = await resolver(0, 0, laberinto);

  if (encontrado) {
    print('\nFinish You Did it !!! encontró la salida en F10.');
  } else {
    print('\nERROR: No hay un camino posible hacia la salida.');
  }
}

/// Recursivity Backtracking Func
Future<bool> resolver(int f, int c, List<List<int>> mapa) async {
  // 1. Validar si estamos fuera de los límites (A-F, 1-10)
  if (f < 0 || f >= 6 || c < 0 || c >= 10) return false;

  // 2. ¿Es la meta? (Valor 3)
  if (mapa[f][c] == 3) {
    dibujar(mapa); // Mostrar estado final
    return true;
  }

  // 3. ¿Es una pared (1) o ya lo visitamos (2)?
  if (mapa[f][c] != 0) return false;

  // 4. MARCAR PASO ACTUAL
  mapa[f][c] = 9; // 9 es el código temporal para el "Jugador"
  dibujar(mapa);
  // Control de velocidad: 200ms por paso
  await Future.delayed(Duration(milliseconds: 200)); 
  
  mapa[f][c] = 2; // Marcamos como visitado definitivamente

  // 5. EXPLORACIÓN EN LAS 4 DIRECCIONES
  // Intentamos: Derecha, Abajo, Izquierda, Arriba
  if (await resolver(f, c + 1, mapa)) return true; // Derecha
  if (await resolver(f + 1, c, mapa)) return true; // Abajo
  if (await resolver(f, c - 1, mapa)) return true; // Izquierda
  if (await resolver(f - 1, c, mapa)) return true; // Arriba

  // 6. BACKTRACKING (Si ninguna dirección funcionó)
  // Opcional: podrías poner mapa[f][c] = 0 si quieres que "borre" sus errores
  return false;
}

/// Función que dibuja el mapa con coordenadas A-F y 1-10
void dibujar(List<List<int>> mapa) {
  // Código especial para limpiar la consola y regresar el cursor arriba
  stdout.write('\x1B[2J\x1B[0;0H');

  // Imprimir encabezado de números (1-10)
  stdout.write('    ');
  for (int i = 1; i <= 10; i++) {
    stdout.write('$i '.padRight(3));
  }
  print('\n' + '   ' + '---' * 10);

  // Imprimir filas con letras (A-F)
  for (int f = 0; f < mapa.length; f++) {
    String letra = String.fromCharCode(65 + f); // 65 es 'A'
    stdout.write('$letra |');

    for (int c = 0; c < mapa[f].length; c++) {
      int celda = mapa[f][c];
      String simbolo;

      switch (celda) {
        case 1: simbolo = PARED; break;
        case 2: simbolo = RASTRO; break;
        case 3: simbolo = META; break;
        case 9: simbolo = JUGADOR; break;
        default: simbolo = LIBRE;
      }
      stdout.write(' $simbolo ');
    }
    print('|');
  }
  print('   ' + '---' * 10);
  print('Explorando coordenadas... (● = Buscador, · = Camino analizado)');
}
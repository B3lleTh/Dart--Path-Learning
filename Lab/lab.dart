// ===========================================================
//  LABERINTO 12x12 EN DART
//  Backtracking DFS con visualización paso a paso en consola
// ===========================================================

import 'dart:io';

// ────────────────────────────────────────────────────────────
//  CLASE: Celda
//  Cada casilla del laberinto tiene 4 paredes individuales.
//  true  = pared cerrada (no se puede pasar)
//  false = pared abierta (hay pasillo)
// ────────────────────────────────────────────────────────────
class Celda {
  bool arriba = true;
  bool abajo = true;
  bool izquierda = true;
  bool derecha = true;
  bool visitada = false; // El backtracking ya pasó por aquí
}

// ────────────────────────────────────────────────────────────
//  CLASE: Laberinto
// ────────────────────────────────────────────────────────────
class Laberinto {
  final int filas;
  final int columnas;
  late List<List<Celda>> grid;

  // Posiciones fijas de inicio y salida
  final int inicioF, inicioC;
  final int salidaF, salidaC;

  // Camino que el algoritmo está recorriendo ahora mismo
  // Si hace backtrack, las celdas se eliminan de aquí
  List<List<int>> camino = [];

  // Celdas que ya fueron exploradas y no llevan a la salida
  Set<String> descartadas = {};

  int paso = 0; // Contador de pasos para mostrar en pantalla

  Laberinto({
    required this.filas,
    required this.columnas,
    required this.inicioF,
    required this.inicioC,
    required this.salidaF,
    required this.salidaC,
  }) {
    grid = List.generate(filas, (_) => List.generate(columnas, (_) => Celda()));
  }

  // ──────────────────────────────────────────────────────────
  //  MÉTODO: abrir
  //
  //  Abre un pasillo entre dos celdas vecinas.
  //  Siempre actúa en AMBOS lados del muro para mantener
  //  consistencia: si A puede ir a B, entonces B puede ir a A.
  //
  //  Uso:   abrir(fila, columna, 'derecha')
  //         abrir(fila, columna, 'abajo')
  //         abrir(fila, columna, 'arriba')
  //         abrir(fila, columna, 'izquierda')
  //
  //  ┌───┬───┐        ┌───┬───┐
  //  │ A │ B │  →     │ A   B │   abrir(A, 'derecha')
  //  └───┴───┘        └───────┘
  // ──────────────────────────────────────────────────────────
  void abrir(int f, int c, String dir) {
    // Ignorar si la celda está fuera del mapa
    if (f < 0 || f >= filas || c < 0 || c >= columnas) return;

    if (dir == 'arriba' && f > 0) {
      grid[f][c].arriba = false; // Quita pared arriba de (f,c)
      grid[f - 1][c].abajo = false; // Quita pared abajo  de (f-1,c)
    } else if (dir == 'abajo' && f < filas - 1) {
      grid[f][c].abajo = false; // Quita pared abajo  de (f,c)
      grid[f + 1][c].arriba = false; // Quita pared arriba de (f+1,c)
    } else if (dir == 'izquierda' && c > 0) {
      grid[f][c].izquierda = false; // Quita pared izq    de (f,c)
      grid[f][c - 1].derecha = false; // Quita pared derecha de (f,c-1)
    } else if (dir == 'derecha' && c < columnas - 1) {
      grid[f][c].derecha = false; // Quita pared derecha de (f,c)
      grid[f][c + 1].izquierda = false; // Quita pared izq    de (f,c+1)
    }
  }

  // ──────────────────────────────────────────────────────────
  //  MÉTODO: mapa
  //
  //  Aquí se define el laberinto abriendo pasillos.
  //  Cada línea = un pasillo entre dos casillas vecinas.
  //
  //  Para modificar el laberinto:
  //    - Agregar línea  → nuevo pasillo aparece
  //    - Borrar línea   → ese pasillo desaparece (muro cerrado)
  //    - Cambiar dir    → cambia hacia dónde conecta
  //
  //  Coordenadas: abrir(fila, columna, dirección)
  //  Fila 0 = arriba,  Fila 11 = abajo
  //  Col 0  = izquierda, Col 11 = derecha
  // ──────────────────────────────────────────────────────────
  void mapa() {
    // ┌─ FILA 0 ──────────────────────────────────────────────
    abrir(0, 0, 'derecha');
    abrir(0, 1, 'derecha');
    abrir(0, 2, 'abajo');
    abrir(0, 3, 'derecha');
    abrir(0, 4, 'derecha');
    abrir(0, 5, 'derecha');
    abrir(0, 6, 'abajo');
    abrir(0, 7, 'derecha');
    abrir(0, 8, 'abajo');
    abrir(0, 9, 'derecha');
    abrir(0, 10, 'derecha');

    // ┌─ FILA 1 ──────────────────────────────────────────────
    abrir(1, 0, 'abajo');
    abrir(1, 1, 'derecha');
    abrir(1, 2, 'derecha');
    abrir(1, 3, 'abajo');
    abrir(1, 4, 'abajo');
    abrir(1, 5, 'abajo');
    abrir(1, 6, 'derecha');
    abrir(1, 7, 'abajo');
    abrir(1, 8, 'derecha');
    abrir(1, 9, 'abajo');
    abrir(1, 10, 'abajo');
    abrir(1, 11, 'abajo');

    // ┌─ FILA 2 ──────────────────────────────────────────────
    abrir(2, 0, 'derecha');
    abrir(2, 1, 'abajo');
    abrir(2, 2, 'abajo');
    abrir(2, 3, 'derecha');
    abrir(2, 4, 'derecha');
    abrir(2, 5, 'derecha');
    abrir(2, 6, 'abajo');
    abrir(2, 7, 'derecha');
    abrir(2, 8, 'derecha');
    abrir(2, 9, 'derecha');
    abrir(2, 10, 'abajo');

    // ┌─ FILA 3 ──────────────────────────────────────────────
    abrir(3, 0, 'abajo');
    abrir(3, 1, 'derecha');
    abrir(3, 2, 'derecha');
    abrir(3, 3, 'abajo');
    abrir(3, 4, 'derecha');
    abrir(3, 5, 'abajo');
    abrir(3, 6, 'derecha');
    abrir(3, 7, 'abajo');
    abrir(3, 8, 'abajo');
    abrir(3, 9, 'derecha');
    abrir(3, 10, 'derecha');
    abrir(3, 11, 'abajo');

    // ┌─ FILA 4 ──────────────────────────────────────────────
    abrir(4, 0, 'derecha');
    abrir(4, 1, 'abajo');
    abrir(4, 2, 'abajo');
    abrir(4, 3, 'derecha');
    abrir(4, 4, 'abajo');
    abrir(4, 5, 'derecha');
    abrir(4, 6, 'derecha');
    abrir(4, 7, 'derecha');
    abrir(4, 8, 'derecha');
    abrir(4, 9, 'abajo');
    abrir(4, 10, 'abajo');

    // ┌─ FILA 5 ──────────────────────────────────────────────
    abrir(5, 0, 'abajo');
    abrir(5, 1, 'derecha');
    abrir(5, 2, 'derecha');
    abrir(5, 3, 'abajo');
    abrir(5, 4, 'derecha');
    abrir(5, 5, 'abajo');
    abrir(5, 6, 'abajo');
    abrir(5, 7, 'abajo');
    abrir(5, 9, 'derecha');
    abrir(5, 10, 'derecha');
    abrir(5, 11, 'abajo');

    // ┌─ FILA 6 ──────────────────────────────────────────────
    abrir(6, 0, 'derecha');
    abrir(6, 1, 'abajo');
    abrir(6, 2, 'abajo');
    abrir(6, 3, 'derecha');
    abrir(6, 4, 'derecha');
    abrir(6, 5, 'derecha');
    abrir(6, 6, 'derecha');
    abrir(6, 7, 'derecha');
    abrir(6, 8, 'abajo');
    abrir(6, 9, 'abajo');
    abrir(6, 10, 'derecha');
    abrir(6, 11, 'abajo');

    // ┌─ FILA 7 ──────────────────────────────────────────────
    abrir(7, 0, 'abajo');
    abrir(7, 1, 'derecha');
    abrir(7, 2, 'derecha');
    abrir(7, 3, 'abajo');
    abrir(7, 4, 'abajo');
    abrir(7, 5, 'derecha');
    abrir(7, 6, 'abajo');
    abrir(7, 7, 'abajo');
    abrir(7, 8, 'derecha');
    abrir(7, 9, 'derecha');
    abrir(7, 10, 'abajo');

    // ┌─ FILA 8 ──────────────────────────────────────────────
    abrir(8, 0, 'derecha');
    abrir(8, 1, 'abajo');
    abrir(8, 2, 'abajo');
    abrir(8, 3, 'derecha');
    abrir(8, 4, 'derecha');
    abrir(8, 5, 'abajo');
    abrir(8, 6, 'derecha');
    abrir(8, 7, 'derecha');
    abrir(8, 8, 'abajo');
    abrir(8, 9, 'abajo');
    abrir(8, 10, 'derecha');
    abrir(8, 11, 'abajo');

    // ┌─ FILA 9 ──────────────────────────────────────────────
    abrir(9, 0, 'abajo');
    abrir(9, 1, 'derecha');
    abrir(9, 2, 'derecha');
    abrir(9, 3, 'abajo');
    abrir(9, 4, 'abajo');
    abrir(9, 5, 'derecha');
    abrir(9, 6, 'derecha');
    abrir(9, 7, 'abajo');
    abrir(9, 8, 'derecha');
    abrir(9, 9, 'derecha');
    abrir(9, 10, 'abajo');

    // ┌─ FILA 10 ─────────────────────────────────────────────
    abrir(10, 0, 'derecha');
    abrir(10, 1, 'abajo');
    abrir(10, 2, 'abajo');
    abrir(10, 3, 'derecha');
    abrir(10, 4, 'derecha');
    abrir(10, 5, 'abajo');
    abrir(10, 6, 'abajo');
    abrir(10, 7, 'derecha');
    abrir(10, 8, 'abajo');
    abrir(10, 9, 'derecha');
    abrir(10, 10, 'derecha');
    abrir(10, 11, 'abajo');

    // ┌─ FILA 11 ─────────────────────────────────────────────
    abrir(11, 0, 'derecha');
    abrir(11, 1, 'derecha');
    abrir(11, 2, 'derecha');
    abrir(11, 3, 'derecha');
    abrir(11, 4, 'derecha');
    abrir(11, 5, 'derecha');
    abrir(11, 6, 'derecha');
    abrir(11, 7, 'derecha');
    abrir(11, 8, 'derecha');
    abrir(11, 9, 'derecha');
    abrir(11, 10, 'derecha');
    // (11,11) es la salida — no se abre ninguna pared extra
  }

  // ──────────────────────────────────────────────────────────
  //  MÉTODO: pasillo
  //  ¿Existe un pasillo abierto desde (f,c) en esa dirección?
  //  Se verifica que la celda destino exista Y la pared esté abierta.
  // ──────────────────────────────────────────────────────────
  bool pasillo(int f, int c, String dir) {
    if (dir == 'arriba') return f > 0 && !grid[f][c].arriba;
    if (dir == 'abajo') return f < filas - 1 && !grid[f][c].abajo;
    if (dir == 'izquierda') return c > 0 && !grid[f][c].izquierda;
    if (dir == 'derecha') return c < columnas - 1 && !grid[f][c].derecha;
    return false;
  }

  // ──────────────────────────────────────────────────────────
  //  MÉTODO: dibujar
  //
  //  Limpia la pantalla y dibuja el estado actual.
  //
  //  Iconos:
  //    ▶  inicio (jugador)
  //    ◎  salida
  //    ◆  posición actual del algoritmo
  //    ·  camino activo (puede retroceder)
  //    ░  callejón descartado
  //       celda sin explorar
  // ──────────────────────────────────────────────────────────
  void dibujar(String estado) {
    stdout.write('\x1B[2J\x1B[0;0H'); // Limpia pantalla (ANSI)

    // Set para búsqueda rápida de celdas en el camino activo
    final enCamino = {for (final p in camino) '${p[0]},${p[1]}'};
    final actual = camino.isNotEmpty
        ? '${camino.last[0]},${camino.last[1]}'
        : '';

    // ── Encabezado ──
    print(' LABERINTO 12×12          paso $paso');
    print(' ▶ inicio  ◎ salida  ◆ explorando  · camino  ░ callejón');
    print('');

    for (int f = 0; f < filas; f++) {
      // Línea de paredes superiores
      String top = '';
      for (int c = 0; c < columnas; c++) {
        top += '┼';
        top += grid[f][c].arriba ? '───' : '   ';
      }
      print('$top┼');

      // Línea de celdas
      String mid = '';
      for (int c = 0; c < columnas; c++) {
        mid += grid[f][c].izquierda ? '│' : ' ';

        final k = '$f,$c';
        if (f == inicioF && c == inicioC)
          mid += ' ▶ ';
        else if (f == salidaF && c == salidaC)
          mid += ' ◎ ';
        else if (k == actual)
          mid += ' ◆ ';
        else if (enCamino.contains(k))
          mid += ' · ';
        else if (descartadas.contains(k))
          mid += ' ░ ';
        else
          mid += '   ';
      }
      mid += grid[f][columnas - 1].derecha ? '│' : ' ';
      print(mid);
    }

    // Línea inferior final
    String bot = '';
    for (int c = 0; c < columnas; c++) {
      bot += '┼';
      bot += grid[filas - 1][c].abajo ? '───' : '   ';
    }
    print('$bot┼');

    // Pie: estado actual del algoritmo
    print('');
    print(' $estado');
  }

  // ──────────────────────────────────────────────────────────
  //  MÉTODO: resolver  —  Backtracking DFS
  //
  //  En cada llamada:
  //   1. ¿Llegamos a la salida?    → éxito, para todo
  //   2. ¿Celda ya visitada?       → evita bucles, regresa false
  //   3. Marca visitada, entra al camino, DIBUJA
  //   4. Prueba las 4 direcciones recursivamente
  //   5. Si todas fallan (callejón) → BACKTRACK:
  //      saca del camino, marca como descartada, DIBUJA
  // ──────────────────────────────────────────────────────────
  bool resolver(int f, int c) {
    // Caso base: llegamos
    if (f == salidaF && c == salidaC) {
      camino.add([f, c]);
      paso++;
      dibujar('¡Salida encontrada!  camino: ${camino.length} pasos');
      return true;
    }

    if (grid[f][c].visitada) return false;

    // Avanza: marca, añade al camino, dibuja, pausa
    grid[f][c].visitada = true;
    camino.add([f, c]);
    paso++;
    dibujar('Explorando  ($f, $c)');
    sleep(const Duration(milliseconds: 180));

    // Prueba las 4 direcciones
    for (final d in [
      ['arriba', f - 1, c],
      ['abajo', f + 1, c],
      ['izquierda', f, c - 1],
      ['derecha', f, c + 1],
    ]) {
      if (pasillo(f, c, d[0] as String)) {
        if (resolver(d[1] as int, d[2] as int)) return true;
      }
    }

    // Backtrack: no había salida por aquí
    camino.removeLast();
    descartadas.add('$f,$c');
    paso++;
    dibujar('Retrocede   ($f, $c)  — callejón');
    sleep(const Duration(milliseconds: 120));

    return false;
  }
}

// ────────────────────────────────────────────────────────────
//  MAIN
// ────────────────────────────────────────────────────────────
void main() {
  final lab = Laberinto(
    filas: 12,
    columnas: 12,
    inicioF: 0,
    inicioC: 0, // ▶ esquina superior-izquierda
    salidaF: 11,
    salidaC: 11, // ◎ esquina inferior-derecha
  );

  lab.mapa(); // Construye el laberinto
  lab.dibujar('Listo. Iniciando backtracking...');
  sleep(const Duration(seconds: 1));

  final ok = lab.resolver(lab.inicioF, lab.inicioC);

  if (!ok) {
    lab.dibujar('Sin solución — no existe camino a la salida.');
  }

  print('\n Pasos totales (avances + retrocesos): ${lab.paso}');
  print(' Longitud del camino final: ${lab.camino.length} celdas');
}

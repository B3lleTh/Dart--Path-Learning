import 'dart:io';
import 'dart:async';

// Codificación de paredes: Norte=1, Este=2, Sur=4, Oeste=8

void main() async {
  // Laberinto 7x7 con paredes codificadas
  List<List<int>> laberinto = [
    [3, 2, 2, 2, 2, 2, 6],
    [9, 0, 2, 0, 2, 0, 4],
    [9, 0, 0, 0, 2, 0, 4],
    [9, 2, 2, 0, 2, 0, 4],
    [9, 0, 0, 0, 0, 0, 4],
    [9, 0, 2, 0, 2, 0, 4],
    [12, 8, 8, 8, 8, 8, 12],
  ];

  int filas = laberinto.length;
  int columnas = laberinto[0].length;

  List<List<int>> recorrido = List.generate(filas, (_) => List.filled(columnas, 0));

  // Limpiar pantalla
  clearConsole();

  // Resolver laberinto animado
  bool exito = await resolverLaberintoAnimado(0, 0, laberinto, recorrido);

  // Mostrar resultado final
  imprimirLaberintoVisual(laberinto, recorrido);
  print("\nResultado: ${exito ? "¡Salida encontrada!" : "No hay salida"}");
}

// Función para limpiar consola
void clearConsole() {
  if (Platform.isWindows) {
    stdout.write('\x1B[2J\x1B[0;0H');
  } else {
    stdout.write('\x1B[2J\x1B[H');
  }
}

// Determinar salida
bool esSalida(int x, int y) => x == 6 && y == 6;

// DFS animado con backtracking
Future<bool> resolverLaberintoAnimado(int x, int y, List<List<int>> laberinto, List<List<int>> recorrido) async {
  int filas = laberinto.length;
  int columnas = laberinto[0].length;

  if (x < 0 || y < 0 || x >= filas || y >= columnas) return false;
  if (recorrido[x][y] == 1) return false;

  recorrido[x][y] = 1;

  // Mostrar laberinto
  clearConsole();
  imprimirLaberintoVisual(laberinto, recorrido);
  await Future.delayed(Duration(milliseconds: 200));

  if (esSalida(x, y)) return true;

  // Mover Norte
  if ((laberinto[x][y] & 1) == 0 && await resolverLaberintoAnimado(x - 1, y, laberinto, recorrido)) return true;
  // Mover Este
  if ((laberinto[x][y] & 2) == 0 && await resolverLaberintoAnimado(x, y + 1, laberinto, recorrido)) return true;
  // Mover Sur
  if ((laberinto[x][y] & 4) == 0 && await resolverLaberintoAnimado(x + 1, y, laberinto, recorrido)) return true;
  // Mover Oeste
  if ((laberinto[x][y] & 8) == 0 && await resolverLaberintoAnimado(x, y - 1, laberinto, recorrido)) return true;

  // Backtracking
  recorrido[x][y] = 0;

  clearConsole();
  imprimirLaberintoVisual(laberinto, recorrido);
  await Future.delayed(Duration(milliseconds: 200));

  return false;
}

// Función para imprimir laberinto con caracteres bonitos
void imprimirLaberintoVisual(List<List<int>> laberinto, List<List<int>> recorrido) {
  int filas = laberinto.length;
  int columnas = laberinto[0].length;

  for (int i = 0; i < filas; i++) {
    // Pared superior
    for (int j = 0; j < columnas; j++) {
      stdout.write((laberinto[i][j] & 1) != 0 ? "┌───┐" : "     ");
    }
    print("");

    // Cuerpo de la celda
    for (int j = 0; j < columnas; j++) {
      String izquierda = (laberinto[i][j] & 8) != 0 ? "│" : " ";
      String derecha = (laberinto[i][j] & 2) != 0 ? "│" : " ";
      String contenido;
      if (i == 0 && j == 0) {
        contenido = " S ";
      } else if (i == filas - 1 && j == columnas - 1) {
        contenido = " E ";
      } else if (recorrido[i][j] == 1) {
        contenido = " * ";
      } else {
        contenido = " · ";
      }
      stdout.write("$izquierda$contenido$derecha");
    }
    print("");
  }
  print(""); // espacio al final
}

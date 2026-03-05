import 'dart:io';

//  Rows:    A–F  (indexes 0–5, vertical)
//  Columns: 1–10 (indexes 0–9, horizontal)

class Cell {
  bool top = true;
  bool bottom = true;
  bool left = true;
  bool right = true;
  bool visited = false;
}
//XD
class Maze {
  static const int ROWS = 6;
  static const int COLUMNS = 10;
  static const List<String> LETTERS = ['A', 'B', 'C', 'D', 'E', 'F'];
  static const List<String> NUMBERS = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
  ];

  final grid = List.generate(
    ROWS,
    (_) => List.generate(COLUMNS, (_) => Cell()),
  );

  // Start: F2  →  row F=5, col 2=1
  // Exit:  A9  →  row A=0, col 9=8
  final int startRow = 5, startCol = 1;
  final int exitRow = 0, exitCol = 8;

  List<List<int>> path = [];
  Set<String> discarded = {};
  int step = 0;

  // ──────────────────────────────────────────────────────────
  //  open(r, c, dir)
  //  Opens the wall between (r,c) and its neighbor. Both sides.
  //
  //  row 0=A  1=B  2=C  3=D  4=E  5=F
  //  col 0=1  1=2  2=3  3=4  4=5  5=6  6=7  7=8  8=9  9=10
  // ──────────────────────────────────────────────────────────
  void open(int r, int c, String dir) {
    if (r < 0 || r >= ROWS || c < 0 || c >= COLUMNS) return;

    if (dir == 'top' && r > 0) {
      grid[r][c].top = false;
      grid[r - 1][c].bottom = false;
    } else if (dir == 'bottom' && r < ROWS - 1) {
      grid[r][c].bottom = false;
      grid[r + 1][c].top = false;
    } else if (dir == 'left' && c > 0) {
      grid[r][c].left = false;
      grid[r][c - 1].right = false;
    } else if (dir == 'right' && c < COLUMNS - 1) {
      grid[r][c].right = false;
      grid[r][c + 1].left = false;
    }
  }

  // ──────────────────────────────────────────────────────────
  //  map()
  //  Corridors read from the board.
  // ──────────────────────────────────────────────────────────
  void map() {
    // Entrance at F2 (left outer wall open)
    grid[startRow][startCol].left = false;

    // Exit at A9 (right outer wall open)
    grid[exitRow][exitCol].right = false;

    // ── ROW A ──────────────────────────────────────────────
    open(0, 0, 'right');
    open(0, 1, 'right');
    open(0, 4, 'right');
    open(0, 5, 'right');
    open(0, 7, 'right');
    open(0, 8, 'right');

    open(0, 0, 'bottom');
    open(0, 3, 'bottom');
    open(0, 6, 'bottom');
    open(0, 9, 'bottom');

    // ── ROW B ──────────────────────────────────────────────
    open(1, 1, 'right');
    open(1, 2, 'right');
    open(1, 4, 'right');
    open(1, 5, 'right');
    open(1, 7, 'right');
    open(1, 8, 'right');

    open(1, 0, 'bottom');
    open(1, 2, 'bottom');
    open(1, 4, 'bottom');
    open(1, 6, 'bottom');
    open(1, 8, 'bottom');

    // ── ROW C ──────────────────────────────────────────────
    open(2, 0, 'right');
    open(2, 1, 'right');
    open(2, 3, 'right');
    open(2, 5, 'right');
    open(2, 6, 'right');
    open(2, 8, 'right');

    open(2, 1, 'bottom');
    open(2, 3, 'bottom');
    open(2, 5, 'bottom');
    open(2, 7, 'bottom');
    open(2, 9, 'bottom');

    // ── ROW D ──────────────────────────────────────────────
    open(3, 0, 'right');
    open(3, 2, 'right');
    open(3, 3, 'right');
    open(3, 5, 'right');
    open(3, 7, 'right');
    open(3, 8, 'right');

    open(3, 0, 'bottom');
    open(3, 2, 'bottom');
    open(3, 4, 'bottom');
    open(3, 6, 'bottom');
    open(3, 8, 'bottom');

    // ── ROW E ──────────────────────────────────────────────
    open(4, 0, 'right');
    open(4, 1, 'right');  
    open(4, 4, 'right');
    open(4, 6, 'right');
    open(4, 7, 'right');

    open(4, 1, 'bottom');
    open(4, 3, 'bottom');
    open(4, 5, 'bottom');
    open(4, 7, 'bottom');

    // ── ROW F ──────────────────────────────────────────────
    open(5, 0, 'right');
    open(5, 2, 'right');
    open(5, 3, 'right');
    open(5, 5, 'right');
    open(5, 6, 'right');
    open(5, 8, 'right');
  }

  bool corridor(int r, int c, String dir) {
    if (dir == 'top') return r > 0 && !grid[r][c].top;
    if (dir == 'bottom') return r < ROWS - 1 && !grid[r][c].bottom;
    if (dir == 'left') return c > 0 && !grid[r][c].left;
    if (dir == 'right') return c < COLUMNS - 1 && !grid[r][c].right;
    return false;
  }

  void draw() {
    stdout.write('\x1B[2J\x1B[0;0H');

    final inPath = {for (final p in path) '${p[0]},${p[1]}'};
    final current = path.isNotEmpty ? '${path.last[0]},${path.last[1]}' : '';

    String header = '     ';
    for (final n in NUMBERS) header += ' ${n.padLeft(2)} ';
    print(header);

    for (int r = 0; r < ROWS; r++) {
      String topLine = '     ';
      for (int c = 0; c < COLUMNS; c++) {
        topLine += '+';
        topLine += grid[r][c].top ? '---' : '   ';
      }
      print('$topLine+');

      String mid = ' ${LETTERS[r]}   ';
      for (int c = 0; c < COLUMNS; c++) {
        mid += grid[r][c].left ? '|' : ' ';
        final k = '$r,$c';
        if (k == current)
          mid += ' @ ';
        else if (r == exitRow && c == exitCol)
          mid += ' X ';
        else if (inPath.contains(k))
          mid += ' * ';
        else if (discarded.contains(k))
          mid += ' . ';
        else
          mid += '   ';
      }
      mid += grid[r][COLUMNS - 1].right ? '|' : ' ';
      print(mid);
    }

    String bottomLine = '     ';
    for (int c = 0; c < COLUMNS; c++) {
      bottomLine += '+';
      bottomLine += grid[ROWS - 1][c].bottom ? '---' : '   ';
    }
    print('$bottomLine+');
    print('');
    print(' @=player  X=exit  *=path  .=discarded    step $step');
  }

  bool solve(int r, int c) {
    if (r == exitRow && c == exitCol) {
      path.add([r, c]);
      draw();
      print(' final path: ${path.length} cells');
      return true;
    }

    if (grid[r][c].visited) return false;

    grid[r][c].visited = true;
    path.add([r, c]);
    step++;
    draw();
    sleep(const Duration(milliseconds: 200));

    for (final d in [
      ['top', r - 1, c],
      ['bottom', r + 1, c],
      ['left', r, c - 1],
      ['right', r, c + 1],
    ]) {
      if (corridor(r, c, d[0] as String)) {
        if (solve(d[1] as int, d[2] as int)) return true;
      }
    }

    path.removeLast();
    discarded.add('$r,$c');
    step++;
    draw();
    sleep(const Duration(milliseconds: 120));

    return false;
  }
}

void main() {
  final maze = Maze();
  maze.map();
  maze.draw();
  sleep(const Duration(milliseconds: 800));
  maze.solve(maze.startRow, maze.startCol);
}
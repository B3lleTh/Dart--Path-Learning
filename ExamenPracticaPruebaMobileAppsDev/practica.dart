//Juan Carlos Ibarra Nunez
//Adriana Yuridia Santiago Pacheco
//Filomeno Crespo Jose Alonso
//Gutierrez Silva Maria de los Angeles
//Lomeli Ulloa Gilberto 

import 'dart:io';

enum TicketStatus { pending, inProgress, resolved }

extension TicketStatusLabel on TicketStatus {
  String get label {
    switch (this) {
      case TicketStatus.pending:
        return 'Pendiente';
      case TicketStatus.inProgress:
        return 'En atención';
      case TicketStatus.resolved:
        return 'Resuelto';
    }
  }
}

class Ticket {
  static int _counter = 1;

  final int id; // Unique ID, never repeats
  String name; // Client name
  String problem; // Problem description
  String solution; // Solution description
  TicketStatus status; // Current ticket status
  final DateTime createdAt; // Date the ticket was first created
  DateTime? updatedAt; // Date of last modification (null if never modified)
  String responsible; // Technician assigned to this ticket

  Ticket({
    required this.name,
    required this.problem,
    required this.responsible,
    this.solution = '',
    this.status = TicketStatus.pending,
  }) : id = _counter++,
       createdAt = DateTime.now();

  // Returns a formatted  summary of the ticket
  String get summary {
    String date = _formatDate(createdAt);
    String mod = updatedAt != null ? '  [Mod: ${_formatDate(updatedAt!)}]' : '';
    return 'ID:${id.toString().padLeft(3, '0')} | ${status.label.padRight(11)} | $name | $responsible | $date$mod';
  }

  // Prints every field of the ticket in detail
  void printDetail() {
    print('\n┌─────────────────────────────────────────────┐');
    print('│              DETALLE DEL TICKET             │');
    print('├─────────────────────────────────────────────┤');
    print('│ ID          : ${id.toString().padLeft(3, '0')}█');
    print('│ Cliente     : $name█');
    print('│ Problema    : $problem█');
    print(
      '│ Solución    : ${solution.isEmpty ? "(sin registrar)" : solution}█',
    );
    print('│ Estado      : ${status.label}█');
    print('│ Responsable : $responsible█');
    print('│ Creado      : ${_formatDate(createdAt)}█');
    print(
      '│ Modificado  : ${updatedAt != null ? _formatDate(updatedAt!) : "(nunca)"}',
    );
    print('└─────────────────────────────────────────────┘');
  }

  static String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/'
      '${d.month.toString().padLeft(2, '0')}/'
      '${d.year} '
      '${d.hour.toString().padLeft(2, '0')}:'
      '${d.minute.toString().padLeft(2, '0')}';
}

// ─────────────────────────────────────────────
//  STACK  (ticket history)
// ─────────────────────────────────────────────

class TicketStack {
  final List<Ticket> _items = [];

  void push(Ticket t) => _items.add(t);
  Ticket pop() => _items.removeLast();
  Ticket peek() => _items.last;
  bool get isEmpty => _items.isEmpty;
  int get length => _items.length;
  bool get isNotEmpty => _items.isNotEmpty;

  // Returns tickets newest-first
  List<Ticket> toList() => List.from(_items.reversed);

  // Removes a ticket by ID before re-pushing it to the top
  void removeById(int id) => _items.removeWhere((t) => t.id == id);

  // Finds a ticket by ID, returns null if not found
  Ticket? findById(int id) {
    try {
      return _items.firstWhere((t) => t.id == id);
    } catch (_) {
      return null;
    }
  }

  // Searches tickets matching ANY of the given non-empty criteria
  List<Ticket> search({
    int? id,
    String? name,
    String? problem,
    String? solution,
    String? responsible,
    TicketStatus? status,
  }) {
    return _items.where((t) {
      if (id != null && t.id == id) return true;
      if (name != null && t.name.toLowerCase().contains(name.toLowerCase()))
        return true;
      if (problem != null &&
          t.problem.toLowerCase().contains(problem.toLowerCase()))
        return true;
      if (solution != null &&
          t.solution.toLowerCase().contains(solution.toLowerCase()))
        return true;
      if (responsible != null &&
          t.responsible.toLowerCase().contains(responsible.toLowerCase()))
        return true;
      if (status != null && t.status == status) return true;
      return false;
    }).toList();
  }
}

//  QUEUE  (pending tickets)
class TicketQueue {
  final List<Ticket> _items = [];

  void enqueue(Ticket t) => _items.add(t);
  Ticket dequeue() => _items.removeAt(0);
  Ticket peek() => _items.first;
  bool get isEmpty => _items.isEmpty;
  int get length => _items.length;
  List<Ticket> toList() => List.from(_items);
}

String readLine() => stdin.readLineSync() ?? '';

String readString(String prompt) {
  String v = '';
  while (v.trim().isEmpty) {
    stdout.write('$prompt: ');
    v = readLine();
    if (v.trim().isEmpty) print('Este campo no puede estar vacío.');
  }
  return v.trim();
}

int readInt(String prompt) {
  while (true) {
    stdout.write('$prompt: ');
    final n = int.tryParse(readLine());
    if (n != null) return n;
    print('Ingresa un número válido.');
  }
}

TicketStatus readStatus() {
  while (true) {
    print('  1. Pendiente');
    print('  2. En atención');
    print('  3. Resuelto');
    stdout.write('Estado: ');
    final input = readLine().trim();
    if (input == '1') return TicketStatus.pending;
    if (input == '2') return TicketStatus.inProgress;
    if (input == '3') return TicketStatus.resolved;
    print('Elige 1, 2 o 3.');
  }
}

void pause() {
  stdout.write('\nPresiona Enter para continuar...');
  readLine();
}

void showMainMenu() {
  print('\n╔══════════════════════════════════════════╗');
  print('║     Sistema de Atención al Cliente       ║');
  print('╠══════════════════════════════════════════╣');
  print('║  1. Agregar ticket                       ║');
  print('║  2. Atender siguiente ticket             ║');
  print('║  3. Buscar ticket                        ║');
  print('║  4. Ver historial completo               ║');
  print('║  5. Mostrar estado del sistema           ║');
  print('║  6. Salir                                ║');
  print('╚══════════════════════════════════════════╝');
  stdout.write('Elige una opción: ');
}

void showSearchMenu() {
  print('\n Buscar por ');
  print('  1. ID');
  print('  2. Nombre del cliente');
  print('  3. Descripción del problema');
  print('  4. Descripción de la solución');
  print('  5. Responsable');
  print('  6. Estado');
  stdout.write('Criterio: ');
}

void showEditMenu() {
  print('\n Qué deseas modificar? ');
  print('  1. Nombre del cliente');
  print('  2. Descripción del problema');
  print('  3. Descripción de la solución');
  print('  4. Estado');
  print('  5. Responsable');
  print('  0. Cancelar');
  stdout.write('Campo: ');
}

// Creates a new ticket, adds it to both the queue and the history stack
void addTicket(TicketQueue queue, TicketStack history) {
  print('\n Agregar Ticket ');
  final name = readString('Nombre del cliente');
  final problem = readString('Descripción del problema');
  final responsible = readString('Responsable');
  final ticket = Ticket(name: name, problem: problem, responsible: responsible);
  queue.enqueue(ticket); // Goes to the pending queue
  history.push(ticket); // Stored in history immediately
  print(
    'Ticket #${ticket.id.toString().padLeft(3, '0')} registrado y en cola.',
  );
}

// Dequeues the next pending ticket and marks it as in-progress
void attendTicket(TicketQueue queue, TicketStack history) {
  print('\n── Atender Siguiente Ticket ──');
  if (queue.isEmpty) {
    print('No hay tickets pendientes en la cola.');
    return;
  }
  final ticket = queue.dequeue(); // Remove from front of queue
  ticket.status = TicketStatus.inProgress; // Mark as being attended

  //Add HERE MOD'S To Desc 

  ticket.updatedAt = DateTime.now();

  // Move to top of history stack to reflect the change
  history.removeById(ticket.id);
  history.push(ticket);

  print('Atendiendo: ${ticket.summary}');
}

// Searches the history stack by one criteria and displays results
void searchTicket(TicketStack history) {
  print('\n── Buscar Ticket ──');
  if (history.isEmpty) {
    print('El historial está vacío.');
    return;
  }

  showSearchMenu();
  final option = readLine().trim();
  List<Ticket> results = [];

  switch (option) {
    case '1':
      final id = readInt('ID del ticket');
      results = history.search(id: id);
      break;
    case '2':
      final name = readString('Nombre (parcial o completo)');
      results = history.search(name: name);
      break;
    case '3':
      final problem = readString('Palabra clave en el problema');
      results = history.search(problem: problem);
      break;
    case '4':
      final solution = readString('Palabra clave en la solución');
      results = history.search(solution: solution);
      break;
    case '5':
      final responsible = readString('Nombre del responsable');
      results = history.search(responsible: responsible);
      break;
    case '6':
      final status = readStatus();
      results = history.search(status: status);
      break;
    default:
      print('  Opción no válida.');
      return;
  }

  if (results.isEmpty) {
    print('No se encontraron tickets con ese criterio.');
    return;
  }

  print('\n${results.length} resultado(s) encontrado(s):');
  for (int i = 0; i < results.length; i++) {
    print('  ${i + 1}. ${results[i].summary}');
  }

  stdout.write('\nAbrir alguno? (número de la lista o 0 para volver): ');
  final pick = int.tryParse(readLine()) ?? 0;
  if (pick < 1 || pick > results.length) return;

  final selected = results[pick - 1];
  selected.printDetail();
  offerEdit(selected, history);
}

// Shows all tickets in the history stack 
void showHistory(TicketStack history) {
  print('\n  Historial de Tickets (${history.length}) ──');
  if (history.isEmpty) {
    print('No hay tickets en el historial.');
    return;
  }

  final list = history.toList(); // Newest first
  for (int i = 0; i < list.length; i++) {
    print('  ${(i + 1).toString().padLeft(2)}. ${list[i].summary}');
  }

  stdout.write('\nAbrir ticket? (número de la lista o 0 para volver): ');
  final pick = int.tryParse(readLine()) ?? 0;
  if (pick < 1 || pick > list.length) return;

  final selected = list[pick - 1];
  selected.printDetail();
  offerEdit(selected, history);
}

// Shows a summary of pending queue and total tickets in history
void showStatus(TicketQueue queue, TicketStack history) {
  print('\n-----------------------------------------');
  print('          ESTADO ACTUAL   ');
  print('------------------------------------------');

  print('\n Cola de espera (${queue.length} ticket(s)):');
  if (queue.isEmpty) {
    print('   (vacía)');
  } else {
    int pos = 1;
    for (final t in queue.toList()) {
      print('   $pos. ${t.summary}');
      pos++;
    }
  }

  final all = history.toList();
  final pending = all.where((t) => t.status == TicketStatus.pending).length;
  final progress = all.where((t) => t.status == TicketStatus.inProgress).length;
  final resolved = all.where((t) => t.status == TicketStatus.resolved).length;

  print('\n Historial (${history.length} total):');
  print('   • Pendientes   : $pending');
  print('   • En atención  : $progress');
  print('   • Resueltos    : $resolved');

  if (history.isNotEmpty) {
    print('\nÚltimo ticket modificado / registrado:');
    print('   ${history.peek().summary}');
  }

  print('\n══════════════════════════════════════════');
}

// Offers the option to edit a ticket & if edited, moves it to the top
void offerEdit(Ticket ticket, TicketStack history) {
  stdout.write('\nModificar este ticket? (s/n): ');
  if (readLine().trim().toLowerCase() != 's') return;

  bool modified = false;
  bool editing = true;

  while (editing) {
    showEditMenu();
    final field = readLine().trim();

    switch (field) {
      case '1':
        ticket.name = readString('Nuevo nombre');
        modified = true;
        break;
      case '2':
        ticket.problem = readString('Nueva descripción del problema');
        modified = true;
        break;
      case '3':
        ticket.solution = readString('Descripción de la solución');
        modified = true;
        break;
      case '4':
        ticket.status = readStatus();
        modified = true;
        break;
      case '5':
        ticket.responsible = readString('Nuevo responsable');
        modified = true;
        break;
      case '0':
        editing = false; // User chose to cancel, exit the edit loop
        break;
      default:
        print('Opción no válida.');
    }

    // After each valid edit, ask if the user wants to modify another field
    if (modified && editing) {
      stdout.write('Modificar otro campo? (s/n): ');
      if (readLine().trim().toLowerCase() != 's') editing = false;
    }
  }

  if (modified) {
    ticket.updatedAt = DateTime.now(); // Stamp the modification date
    history.removeById(ticket.id); // Remove from current position in stack
    history.push(ticket); // Re-insert at the top
    print('Ticket actualizado y movido al tope del historial.');
    ticket.printDetail();
  }
}

void main() {
  final TicketQueue queue = TicketQueue(); // Pending tickets 
  final TicketStack history =
      TicketStack(); // All tickets, newest on top 

  bool running = true;

  while (running) {
    showMainMenu();
    final option = int.tryParse(readLine()) ?? 0;

    switch (option) {
      case 1:
        addTicket(queue, history);
        break;
      case 2:
        attendTicket(queue, history);
        break;
      case 3:
        searchTicket(history);
        break;
      case 4:
        showHistory(history);
        break;
      case 5:
        showStatus(queue, history);
        break;
      case 6:
        print('\nSaliendo. ¡Hasta luego!\n');
        running = false;
        break;
      default:
        print('Opción no válida. Elige entre 1 y 6.');
    }

    if (running) pause();
  }
}
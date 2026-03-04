import 'dart:io';

enum Estado { pendiente, enAtencion, resuelto }

class Ticket {
  static int _contador = 1;

  int id = _contador++;
  String nombre;
  String descripcion;
  Estado estado;

  Ticket(this.nombre, this.descripcion)
      : estado = Estado.pendiente;
}

List<Ticket> cola = [];      // Cola de tickets (FIFO)
List<String> pila = [];      // Pila de acciones (LIFO)
Ticket? actual;              // Ticket en atención

String leer(String mensaje) {
  stdout.write('$mensaje: ');
  return stdin.readLineSync()!.trim();
}

String estadoTexto(Estado e) {
  switch (e) {
    case Estado.pendiente:
      return "Pendiente";
    case Estado.enAtencion:
      return "En atención";
    case Estado.resuelto:
      return "Resuelto";
  }
}

/* ===========================
   MENÚ
=========================== */

void mostrarMenu() {
  print('''
=================================
 SISTEMA DE GESTIÓN DE TICKETS
=================================
1. Agregar ticket
2. Atender ticket
3. Registrar acción del técnico
4. Deshacer última acción
5. Mostrar estado del sistema
6. Salir
=================================
''');
}

/* ===========================
   FUNCIONES
=========================== */

// Enqueue
void agregarTicket() {
  String nombre = leer("Nombre del cliente");
  String descripcion = leer("Descripción del problema");

  Ticket t = Ticket(nombre, descripcion);
  cola.add(t);

  print("\nTicket #${t.id} registrado correctamente.");
}

// Dequeue
void atenderTicket() {
  if (cola.isEmpty) {
    print("\nNo hay tickets pendientes.");
    return;
  }

  actual = cola.removeAt(0);
  actual!.estado = Estado.enAtencion;
  pila.clear();

  print("\nAtendiendo ticket #${actual!.id}");
}

// Push
void registrarAccion() {
  if (actual == null) {
    print("\nNo hay ticket en atención.");
    return;
  }

  String accion = leer("Acción realizada");
  if (accion.isNotEmpty) {
    pila.add(accion);
    print("Acción registrada.");

    // Si se registra acción, puede marcarse como resuelto
    String cerrar = leer("¿Marcar como resuelto? (s/n)");
    if (cerrar.toLowerCase() == "s") {
      actual!.estado = Estado.resuelto;
      print("Ticket marcado como resuelto.");
    }
  }
}

// Pop
void deshacerAccion() {
  if (pila.isEmpty) {
    print("\nNo hay acciones para deshacer.");
    return;
  }

  String eliminada = pila.removeLast();
  print("\nSe eliminó la acción: $eliminada");
}

// Mostrar estado general
void mostrarEstado() {
  print("\n=========== ESTADO DEL SISTEMA ===========");

  print("\nTickets en cola (${cola.length}):");
  if (cola.isEmpty) {
    print("  No hay tickets pendientes.");
  } else {
    for (var t in cola) {
      print("  Ticket #${t.id} - ${t.nombre} - ${estadoTexto(t.estado)}");
    }
  }

  if (actual != null) {
    print("\nTicket en atención:");
    print("  ID: ${actual!.id}");
    print("  Cliente: ${actual!.nombre}");
    print("  Problema: ${actual!.descripcion}");
    print("  Estado: ${estadoTexto(actual!.estado)}");

    print("\nAcciones realizadas (${pila.length}):");
    if (pila.isEmpty) {
      print("  Ninguna acción registrada.");
    } else {
      for (var a in pila) {
        print("  - $a");
      }
    }
  } else {
    print("\nNo hay ticket en atención.");
  }

  print("==========================================\n");
}

/* ===========================
   MAIN
=========================== */

void main() {
  bool activo = true;

  while (activo) {
    mostrarMenu();

    switch (leer("Seleccione una opción")) {
      case "1":
        agregarTicket();
        break;
      case "2":
        atenderTicket();
        break;
      case "3":
        registrarAccion();
        break;
      case "4":
        deshacerAccion();
        break;
      case "5":
        mostrarEstado();
        break;
      case "6":
        activo = false;
        break;
      default:
        print("\nOpción inválida.");
    }
  }

  print("\nPrograma finalizado.");
}

// Base class
class Employee {
  String name;
  int id;

  Employee(this.name, this.id);
}

// Manager class
class Manager extends Employee {
  int employeesInCharge;

  Manager(String name, int id, this.employeesInCharge) : super(name, id);

  void showRole() {
    print("Manager: $name (Praise the Sun!)");
    print("Has $employeesInCharge employee in charge");
  }
}

// Cashier class
class Cashier extends Employee {
  int registerNumber;

  Cashier(String name, int id, this.registerNumber) : super(name, id);

  void showRole() {
    print("Cashier: $name");
    print("Works at register $registerNumber.");
  }
}

void main() {
  Manager manager = Manager("Solaire of Astora", 1, 1);
  Cashier cashier = Cashier("Siegmeyer of Catarina", 2, 6);

  manager.showRole();
  print(""); // space

  cashier.showRole();
}
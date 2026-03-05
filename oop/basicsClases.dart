// Base class
class Employee {
  String name;
  int id;
  double salary;

  Employee(this.name, this.id, this.salary);

  void showInfo() {
    print("Employee: $name | ID: $id | Salary: $salary");
  }
}

// Subclass of Employee
class Manager extends Employee {
  int teamSize;

  Manager(String name, int id, double salary, this.teamSize)
      : super(name, id, salary);

  void manageTeam() {
    print("$name manages a team of $teamSize employees.");
  }
}

// Subclass of Manager
class AreaManager extends Manager {
  String area;
  int fleetNumber;

  AreaManager(String name, int id, double salary, int teamSize, this.area, this.fleetNumber)
      : super(name, id, salary, teamSize);

  void showArea() {
    print("$name is responsible for the $area area with $fleetNumber vehicles.");
  }
}

// Another subclass of Employee
class Cashier extends Employee {
  int registerNumber;

  Cashier(String name, int id, double salary, this.registerNumber)
      : super(name, id, salary);

  void processPayment() {
    print("$name is processing payments at register $registerNumber.");
  }
}

void main() {
  AreaManager manager = AreaManager("Ranni la Bruja", 1, 20000, 8, "Sales", 4);
  Cashier cashier = Cashier("Solaire de Astora", 2, 8000, 3);

  manager.showInfo();
  manager.manageTeam();
  manager.showArea();

  print("");

  cashier.showInfo();
  cashier.processPayment();
}
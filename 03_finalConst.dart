main() {
  var a = 10;
  final double b;
  const double c = 20;
  a = 20;
  b = 20;
  //c = 20;

  print(a);
  print(b);
  print(c);


  //final personasFinal = ['Juan', 'Pedro', 'Maria'];
  //const personasConst = ['Ana', 'Luis', 'Carlos'];
  final List<String> personasFinal = ['Juan', 'Pedro', 'Maria'];
  List<String> personasConst = const ['Ana', 'Luis', 'Carlos'];

  //personasFinal = ['Sofia', 'Miguel'];
  //personasConst = ['Sofia', 'Miguel'];
  
  personasFinal.add('Maria');
  personasConst.add('Sofia');

  print(personasFinal);
  print(personasConst);
  
}

main() {
  //NUMERICOS
  int a = 10;
  double b = 3.1416;
  int? c;
  late int d;
  d = 20;

  print(a);
  print(b);
  print(c);
  print(d);
  print(a + b);

  //CADENAS

String nombre = 'Dantes';
String apellido = "Redgrave";
String apellidoRandom = 'O\'Connor';
String? cadenaVacia;
String nombreCompleto = '$nombre $apellido';
String multilinea = '''

    Hello World
    How are You $nombre $apellido? 
    i dont wanna leave $nombre
''';

print(nombre);
print(apellido);
print(nombreCompleto);
print(cadenaVacia);
print(apellidoRandom);
print(multilinea);


//Boolean

bool isActive = true;
bool isNotActive = !isActive;
print(isActive);
print(isNotActive);

//ARRAYS

var general = ['Doom Slayer','Guts','Thorfinn',3.14,1,true];
List<String> juegos = ['Dark Souls 1','Dark Souls 2','Elden Ring'];
juegos[0] = 'Dark Souls 3';
print(general);
print(juegos);
juegos.add('Bloodborne');
juegos.add('Sekiro');
print(juegos);

//Setsitos
var villanosSet = {'Lex Luthor','Red Skull','Doom',1,true,3.1416};
Set<String> villanosSetString = {'Lex Luthor', 'Red Skull','Doom'};
print(villanosSet);
print(villanosSetString);
villanosSetString.add('Underthaker');
villanosSetString.add('Underthaker');
villanosSetString.add('Underthaker');
villanosSetString.add('Underthaker');
print(villanosSetString);

var villanosSet2 = juegos.toSet();
print(villanosSet2.toList());


//Maps (Json)

var ironman = {
  'nombre': 'Tony Stark',
  'poder': 'Inteligencia y el Dinero',
  'edad':40,
};

Map<String,dynamic> warMachine ={
  'nombre': 'Rhodey Rhodes',
  'poder': 'Tactico y Tecnologia',
  'edad': '40',
};

Map<String, dynamic> capitanAmerica = Map();
capitanAmerica.addAll({
  'poder': 'Fuerza, Agilidad y Resistencia',
  'edad': 102,
});

capitanAmerica.addAll(ironman);
print(ironman);
print(warMachine);
print(ironman['nombre']);
print(warMachine['nombre']);


}
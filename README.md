# 🟦 Dart: My Learning Path

![Dart Logo](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

Bienvenido a mi repositorio de aprendizaje. Aquí documento mi progreso dominando **Dart**, desde los conceptos básicos de consola hasta lógica avanzada para aplicaciones escalables.

---

## 📖 Contenido del Repositorio

| Módulo | Conceptos Clave | Estado |
| :--- | :--- | :---: |
| **01. Fundamentos** | Variables, Strings, Booleans, Tipos de Datos | ✅ |
| **02. Consola (I/O)** | `stdin`, `stdout`, Captura de datos y Conversiones | ✅ |
| **03. Flujo de Control** | If/Else, Switch, Bucles For/While | 🔄 |
| **04. Funciones** | Parámetros, Retornos y Funciones Flecha | ⏳ |

---

## 💡 Lo que he dominado hasta ahora

### 📥 Entrada y Salida de Datos (I/O)
Uno de los mayores retos iniciales fue entender que **todo lo que entra por teclado es Texto (String)**. 

Para procesar información, aprendí el flujo de **Captura -> Validación -> Conversión**:

1. **Captura:** Usando `stdin.readLineSync()`.
2. **Validación (Null-Safety):** Uso del operador `??` como Plan B si el usuario no escribe nada.
3. **Conversión (Parsing):** Transformar el texto en números para realizar cálculos.



```dart
// Ejemplo de mi lógica actual
stdout.write('Introduce un valor: ');
String? input = stdin.readLineSync();

// Plan B: Si es nulo, usamos '0'. Luego convertimos a número.
int valor = int.parse(input ?? '0');

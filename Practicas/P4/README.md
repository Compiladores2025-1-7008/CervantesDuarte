<p  align="center">
  <img  width="200"  src="https://www.fciencias.unam.mx/sites/default/files/logoFC_2.png"  alt="">  <br>Compiladores  2025-1 <br>
  Práctica 4: Analizadores sintácticos con BYACC/J (YACC) <br> Profesora: Ariel Adara Mercado Martínez
</p>



### Ejercicios
1. Reemplazar el _StringTokenizer_ utilizado en el método original ```int yylex()``` con un analizador léxico generado mediante JFLex combinando ambas tecnologías (_BYACCJ+JFlex_).
2. Definir tokens para todos los operadores de la calculadora en ```archivo.y``` y devolverlos en los patrones que corresponda mediante acciones léxicas del archivo de _JFlex_. 
3. La calculadora debe ser capaz de mantener su funcionamiento interactivo mediante la consola y/o ser capaz de leer un archivo de entrada.


### Estructura del directorio
```c++
P4
├── README.md
├── src
│   ├── calc
│   │    ├── java
│   │    │    └── Main.java // Clase con el método main
│   │    ├── jflex
│   │    │    └── Lexer.flex // Definición del An. Léxico
│   │    └── byacc
│   │         └── calculadora.y // Definición del An. Sintáctico
│   └── main
│       ├── java
│       │   └── Main.java // Clase con el método main
│       ├── jflex
│       │   └── Lexer.flex // Definición del An. Léxico
│       └── byacc
│           └── Parser.y // Definición del An. Sintáctico
└── tst
    └── prueba.txt // Archivo de entrada prueba que debe ser aceptado por el parser

```

### Uso

### Compilación

```bash
[P4/]$ jflex src/calc/jflex/Lexer.flex
[P4/src/main/byacc/]$ byaccj -J -Jpackage=calc.byacc calculadora.y
[P4/]$ javac --source-path src -d build src/calc/java/Main.java
```

### Ejecución

Para usar un archivo de entrada:

```bash
[P4/]$ java -cp build calc.java.Main src/tst/<nombre_archivo>.txt
```

Para usar la terminal como entrada:

```bash
[P4/]$ java -cp build calc.java.Main 
```
---

### Ejercicios para la definción de un Analizador Sintáctico en BYACC/J
Para la gramática de la práctica anterior (Práctica 3) o la siguiente G = ( N, Σ, P, S), descrita por las siguientes producciones: 
````
P = {
    S → Expr | Asig
    Expr → Term Expr’
    Expr’ → + Term Expr’ | - Term Expr’ | ε 
    Term → Factor Term’
    Term’ → * Factor Term’ | / Factor Term’| ε 
    Factor → Num | Var | (Expr) | - Expr
    Num → Entero Decimal
    Decimal → . Entero | ε
    Entero → Digito | Digito Entero
    Digito→0|1|2|... |9 
    Asig → var Var = Expr
    Var → Letra Pos
    Pos → Var | ε
    Letra → _|a|b|... |z|A|B|... |Z
}
```


4. Determinar en un archivo Readme, en formato Markdown (.md) o LaTeX (.tex) -- con su respectivo PDF, para este último -- , los conjuntos _N_, _Σ_ y el símbolo inicial _S_.  (0.5 pts.) (HECHO EN EL PDF)
5. Mostrar en el archivo el proceso de eliminación de ambigüedad o justificar, en caso de no ser necesario. (1 pts.). (HECHO EN EL PDF)
6. Mostrar en el archivo el proceso de eliminación de la recursividad izquierda o justificar, en caso de no ser necesario. (1 pts.) (HECHO EN EL PDF)
7. Mostrar en el archivo el proceso de factorización izquierda o justificar, en caso de no ser necesario. (1 pts.) (HECHO EN EL PDF)
8. Mostrar en el archivo los nuevos conjuntos _N_ y _P_. (0.5 pts.) (HECHO EN EL PDF)
9. Realizar cualquier otro tratamiento necesario para evitar conflictos de _shift/reduce_ mostrando el proceso. (HECHO EN EL PDF)
10. Crear una definición con _BYACC/J_ para la gramática resultante. (UBICADO EN LA RUTA src/main/byacc/Parser.y)

### Compilación

```bash
[P4/]$ jflex src/main/jflex/Lexer.flex
[P4/src/main/byacc/]$ byaccj -J -Jpackage=main.byacc Parser.y
[P4/]$ javac --source-path src -d build src/main/java/Main.java
```

### Ejecución

```bash
[P4/]$ java -cp build main.java.Main src/tst/<nombre_archivo>.txt
```
---
#### Extras

11. Documentar el código. (0.25pts)
12. Proponer 4 archivos de prueba nuevos, 2 válidos y 2 inválidos. (0.25pts)
13. Crear un archivo build.xml para ANT que permita la automatización de la generación de los analizadores léxico y sintáctico y la compilación del resultado. 

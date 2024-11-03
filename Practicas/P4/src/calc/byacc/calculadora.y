%{
  import java.lang.Math;
  import java.io.Reader;
  import java.io.IOException;
  import calc.jflex.Lexer;  // Importa el lexer para usarlo en el parser
%}



/// los tokes seran los terminales que seran reconocidos
%token SUMA RESTA MULTI DIVII POTE  LPAR RPAR  NUMERO SALTOLINEA 

// Precedencias y asociatividades de operadores
%left RESTA SUMA          
%left MULTI DIVI           
%right POTE               
%left NEG                 // Negación unaria
%nonassoc LPAR RPAR   // Paréntesis son no asociativos











/* Gramatica */
%%
input:
    /* Cadena vacía */
  | input line          
;

line:
    SALTOLINEA                // Si detecta un salto de linea que no haga nada 
  | exp SALTOLINEA { System.out.println("Resultado: " + $1.dval); }  // Muestra el resultado de una expresión
;

// Lo que esta entre {} es la accion lexica que va a realizar 
// con .dval obtenemos el valor semantico  double del token  
exp:
    NUMERO                  { $$ = new ParserVal($1.dval); }        
  | exp SUMA exp         { $$ = new ParserVal($1.dval + $3.dval); } 
  | exp RESTA exp        { $$ = new ParserVal($1.dval - $3.dval); }  
  | exp MULTI exp        { $$ = new ParserVal($1.dval * $3.dval); }  
  | exp DIVI exp          { $$ = new ParserVal($1.dval / $3.dval); } 
  | RESTA exp %prec NEG  { $$ = new ParserVal(-$2.dval); }       
  | exp POTE exp          { $$ = new ParserVal(Math.pow($1.dval, $3.dval)); }  
  | LPAR exp RPAR    { $$ = $2; }                           
;

%%










/* Instancia del lexer */
Lexer scanner;

/* Constructor del parser */
public Parser(Reader r) {
  this.scanner = new Lexer(r, this);  // Inicializa el lexer con el lector de entrada
}

// Método para establecer  el valor del token actual 
public void setValor(ParserVal valor) {
  ///yylval es una variable para guardar el valor//el lexema // del token 
  this.yylval = valor; 
}

//METODO QUE  INICIA TODO  
  //desde el main
public void parse() {
  // este metodo pide manda a llamar yylex repetidamente para obtener los tokens uno a uno 
  this.yyparse();  
}


 
//El metodo se recomienda sobreescribirlo para permitir personalizar cómo se manejan y reportan errores

void yyerror(String error1) {
  System.out.println("Error sintactico: " + error1);  
}


// Obtener el token actual
// Debido a que implemente el lexer dentro del parser tengo que definir la función yylex para que sea 
// llamada por parse() 

int yylex() {
  int token = -1;
  try {
    token= scanner.yylex(); 
  } catch (IOException e) {
    System.err.println("Error ");  
  }
  return token;  // Retorna el token obtenido
}



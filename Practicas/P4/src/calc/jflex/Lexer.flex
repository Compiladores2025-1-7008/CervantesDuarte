package calc.jflex;


import java.io.Reader;
// Nota: si lo puedo importar aunque todavia no este creado 
import calc.byacc.Parser;  
import calc.byacc.ParserVal;  







%%

// Para usar el parser dentro del lexer
%{
   
    private Parser parser;  // Instancia del parser 

   // constructor de lexer
    public Lexer(Reader r, Parser parser) {
        this(r);  
        this.parser = parser;  // Asigna el parser a la variable de instancia
    }
 

%}


/// Configuraciones del lexer
%public       // Declara la clase como pública
%class Lexer  // Define el nombre de la clase como "Lexer"
%standalone   // Puede usar independiente 
%unicode      // caracteres Unicode


// Definición de un número decimal
Numero = ([1-9][0-9]*|0)(\\.[0-9]+)?  

%%






// Regla para reconocer numeros 
{Numero} { 
        // Convierte el texto del token a un valor double
	 double value = Double.parseDouble(yytext());
        /// setValor es un metodo que se usa para asignar el valor semantico del token que se acaba de leer 
        /// ParserVal es una clase auxiliar para guardar informacion , enteros ,double, string u objetos 
     parser.setValor(new ParserVal(value));
    return Parser.NUMERO;  // Retorna el token NUMERO, indicando que es un número
}


// Reglas con sus acciones lexicas
"+"          { return Parser.SUMA; }   
"*"          { return Parser.MULTI; }  
"/"          { return Parser.DIVI; }    
"-"          { return Parser.RESTA; }  
"^"          { return Parser.POTE; }  // Potencia
"("          { return Parser.LPAR; } // (
")"          { return Parser.RPAR; } // )


// Espacios en blanco
[ \t\r]+     { /* Ignorar espacios en blanco */ }

// Regla para manejar saltos de lInea 
\n           { return Parser.SALTOLINEA; }  // Retorna un token para el salto de línea

// Regla para manejar el fin de archivo (EOF)
<<EOF>>      { return -1; }      // Retorna -1 para indicar el fin de archivo

// El punto puede ser cualquier cosa asi que si no es un caracter reconocido 
// mandar un error lexico 
.            { System.err.println("Error léxico: " + yytext()); }


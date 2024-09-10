/**
 * Escáner que detecta el lenguaje C_1
*/

/*Importante la instrucción de package porque si no esta los camandos no funcionan */
package main.jflex;
import main.java.ClaseLexica;
import main.java.Token;



%%

%{

public Token actual;

%}

%public
%class Lexer
%standalone
%unicode

/*[/s] incluye todos , hasta tabulaciones , saltos de linea , retornos de carro y saltos de pagina*/
espacio=[\s]+ 
digito = [0-9]
letra = [a-zA-Z]
palabra={letra}+

id = [a-zA-Z_][a-zA-Z0-9_]* 
lpar = [(]
rpar = [)]
/*? para indicar que puede aparecer una o cero veces*/
notacionCi =[0-9]*\.[0-9]+([eE][+-]?[0-9]+)? 

%%






{espacio} {/* La acción léxica puede ir vacía si queremos que el escáner ignore la regla */}
{digito}+ { System.out.println(new Token(ClaseLexica.NUMERO,yytext()).toString()); }
{notacionCi} { System.out.println(new Token(ClaseLexica.NUMERO,yytext()).toString()); }
float { System.out.println(new Token(ClaseLexica.FLOAT,yytext()).toString()); }
while { System.out.println(new Token(ClaseLexica.WHILE,yytext()).toString()); }
int { System.out.println(new Token(ClaseLexica.INT,yytext()).toString()); }
else { System.out.println(new Token(ClaseLexica.ELSE,yytext()).toString()); }
if { System.out.println(new Token(ClaseLexica.IF,yytext()).toString()); }
{id} { System.out.println(new Token(ClaseLexica.ID,yytext()).toString()); }
, { System.out.println(new Token(ClaseLexica.COMA,yytext()).toString()); }
{lpar} { System.out.println(new Token(ClaseLexica.LPAR,yytext()).toString()); }
{rpar} { System.out.println(new Token(ClaseLexica.RPAR,yytext()).toString()); }
; { System.out.println(new Token(ClaseLexica.PYC,yytext()).toString()); }



/**
 * Escáner que detecta números y palabras
*/


/** Seccion de declaraciones */
%%
%public
%class Lexer
%standalone

digito = [0-9]
letra = [a-zA-Z]
palabra={letra}+
espacio =[ \t\n]+
hexDigit = [0-9a-fA-F]
keyword = "float"|"public"|"interface"|"implements"|"int"
identifier = {letra}({letra}|{digito}|[$_]){0,31}


%%

/** seccion de expresiones regulares  o seccion de reglas */
{espacio}  { System.out.print("Encontre un espacio en blanco  " + yytext()+"\n"); }
{digito}+ { System.out.print("Encontré un número: "+yytext()+"\n"); }
{keyword} { System.out.print("Palabra reservada encontrada: " + yytext()+"\n"); }
{palabra} { System.out.print("Encontré una palabra: "+yytext()+"\n"); }

"0x"{hexDigit}+  { System.out.print("Hexadecimal encontrado: " + yytext()+"\n"); }
"0X"{hexDigit}+  { System.out.print("Hexadecimal encontrado: " + yytext()+"\n"); }

{identifier} { System.out.print("Identificador válido encontrado: " + yytext()+"\n"); }


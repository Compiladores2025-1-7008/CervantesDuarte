package main.jflex;

import main.java.ClaseLexica;
import main.java.Token;

%%

%{

public Token actual;
public int getLine() { return yyline; }

%}

%public
%class Lexer
%standalone
%unicode
%line

espacio=[ \t\n]

digito = [0-9]
letra = [a-zA-Z]
palabra={letra}+
id = [a-zA-Z_][a-zA-Z0-9_]* 
lpar = [(]
rpar = [)]
/*? para indicar que puede aparecer una o cero veces*/
notacionCi =[0-9]*\.[0-9]+([eE][+-]?[0-9]+)? 
suma =[+]
igual =[=]
multi = [*]
divi = [/]
resta= [-]


%%

{espacio}+ { }
"int" {  return ClaseLexica.INT; }
{digito}+ { return ClaseLexica.NUMERO; }
float {  return ClaseLexica.FLOAT; }
//Aquí el resto de las definiciones



while { return ClaseLexica.WHILE ; }
else { return ClaseLexica.ELSE;  }
if { return ClaseLexica.IF ; }
{id} { return ClaseLexica.ID  ;}
, {return ClaseLexica.COMA ; }
{lpar} {return ClaseLexica.LPAR ; }
{rpar} { return ClaseLexica.RPAR ;}
; {return ClaseLexica.PYC;}
{igual} {return ClaseLexica.IGUAL;}
{suma} {return ClaseLexica.SUMA;}
{multi} {return ClaseLexica.MULTI;}
{divi} {return ClaseLexica.DIVI;}
{resta} {return ClaseLexica.RESTA;}


<<EOF>> { return 0; }
. { return -1; }

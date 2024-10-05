package main.java;

import java.io.IOException;
import main.jflex.Lexer;

public class Parser implements ParserInterface {
    private Lexer lexer;
    private int actual;
    //sirve para llevar un control de cuantos tokens ha leido
    private int contador =0;

    public Parser(Lexer lexer) {
        this.lexer = lexer;
    }


    @Override
    public void eat(int claseLexica) {
        // System.out.println("el valor de la clase lexica que lee es : "+actual+ "  El que recibe  = "+claseLexica);
        // nos permite solicitar un token pero si la entrada es igual al esperado 
        if(actual == claseLexica) {
            try {
                actual = lexer.yylex();
                contador++;
            } catch (IOException ioe) {
                System.err.println("Failed to read next token");
            }
        }
        else
            System.err.println("Se esperaba el token: "+ actual); 
    }

    @Override
    public void error(String msg) {
        System.err.println("ERROR DE SINTAXIS: "+msg+" en la línea "+lexer.getLine());
    }

    @Override
    public void parse() {
        try {

            //avanza un token cada que se manda a llamar a lexer.yylex  y el caracter que se manda al final del archivo es
            // EOF y si retorna 0 
          
            this.actual = lexer.yylex();
         

        } catch (IOException ioe) {
            System.err.println("Error: No fue posible obtener el primer token de la entrada.");
            System.exit(1);
        }
        S();
        if(actual == 0) //llegamos al EOF sin error
            System.out.println("La cadena es aceptada");
        else 
            System.out.println("La cadena no pertenece al lenguaje generado por la gramática");
    }

    public void S() { // S() = programa()
        // System.out.println("Entre a S");
        declaraciones();
        sentencias();
    }


    public void declaraciones(){
        // System.out.println("Entre a declaraciones");
        declaracion();
        declaraciones2();

    }


    public void declaraciones2(){
        // System.out.println("Entre a declaraciones2");
        // se hace esta validacion para ver si continua recursivamente 
        // si ya no se consumieron caracteres entonces ya no continua recursivamente 
        int contador2=contador;
        declaracion();
        if(contador2 < contador){
            declaraciones2();
        }

    }

    public void declaracion(){
        // System.out.println("Entre a declaracion");
        tipo();
        lista_var(); 
        //consumir ";"
        eat(8);
     

    }

    public void tipo(){
    //   System.out.println("Entre a  tipo");
    // Se hacen estos if porque si no permitiria cadenas de la forma int float x;
        if(actual==1 ){
            eat(1);
        }
        if(actual==2){
            eat(2);
        }
     
    }


    public void lista_var(){
        // System.out.println("Entre a lista_var()");
        eat(7);
        lista_var2();
      
    }


     public void lista_var2(){
        // System.out.println("Entre a lista_var2");
        
        if(actual==9){
            // consumir ,
            eat(9);
            eat(7);
            lista_var2();

        }
        parteSentencia();

    }
       
        
    

    public void parteSentencia(){
        // System.out.println("Entra en parteSentencia");
        eat(12);
        expresion();
    }

    public void sentencias(){
        // System.out.println("sentencias");
        sentencia();
        sentencias2();
    }

    public void sentencias2 (){
        // System.out.println("sentencias2");
        // se usa el contador para controlar la recursividad 
        int contador2=contador;
        sentencia();
        if (contador2<contador){
            sentencias2();
        }
    }

    public void sentencia(){
        // System.out.println("sentencia");

        switch (actual) {
            case 7:
                // Código para identificador
                eat(7);
                eat(12);
                expresion();
                eat(8);
                break;
            case 3:
                // codigo para el if 
                eat(3);
                eat(10);
                expresion();
                eat(11);
                sentencias();
                eat(4); //else
                sentencias();

                break;

            case 5:
                // codigo para el while
                eat(5);
                eat(10);
                expresion();
                eat(11); //)
                sentencias();

                break;
          
            
        }
    }

    public void expresion(){
        // System.out.println("expresion");
        switch (actual) {
            case 7:
                // Código para identificador
                eat(7);
                expresion2();
                break;
            case 6:
                // Código para numero
                eat(6);
                expresion2();

                break;
            case 10:
                // Código para (expresion)
                eat(10);
                expresion();
                eat(11);
                expresion2();
                break;
    
        }


    }

    public void expresion2(){
        // System.out.println("expresion2");

        switch (actual) {
            case 13:
                // Código para la suma
                eat(13);
                expresion();
                expresion2();
                break;
            case 16:
                // Código para la resta
                eat(16);
                expresion();
                expresion2();
                break;
            case 14:
                // Código para multiplicacion
                eat(14);
                expresion();
                expresion2();
                break;
            case 15:
                // Código para division
                eat(15);
                expresion();
                expresion2();
                break;
            
        }

    }


}
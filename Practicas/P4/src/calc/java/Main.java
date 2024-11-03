package calc.java;


import java.io.FileReader;            
import java.io.InputStreamReader;     
import java.io.Reader;               
import calc.jflex.Lexer;           // Importa el lexer
import calc.byacc.Parser;          // Importa el parser

public class Main {
    public static void main(String[] args) {
        try {
            // Para ver si la entrada es desde la terminal o desde un archivo
            Reader reader;
            if (args.length > 0) {
            
                reader = new FileReader(args[0]);  
            } else {
               
                System.out.println("Escribe una expresion y presiona ENTER:");
                reader = new InputStreamReader(System.in); 
            }
            
            // Crear una instancia del parser
            Parser parser = new Parser(reader);  
            // Inicia el proceso de parser
            parser.parse();                       
            
        } catch (Exception e) {
            System.err.println("Error : " + e.getMessage());
           
        }
    }
}


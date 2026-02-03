package org.taulyd.torrente;


import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.net.URL;

public class Gestor {
    private static final URL enlace = Gestor.class.getResource("/con.txt");

    public static void guardar(String contra) {
        try (BufferedWriter escritor = new BufferedWriter(new FileWriter(new File(enlace.getFile())))) {
            escritor.write(contra);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static boolean recuperar(String contra) {
        try (BufferedReader lector = new BufferedReader(new FileReader(new File(enlace.getFile())))) {
            String hash = lector.readLine();

            return hash.equals(contra);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    
    public static void certificado() {
        // TODO: Generar certificados digitales y guardarlo en el sistema operativo o un archivo

        
        
    }


}

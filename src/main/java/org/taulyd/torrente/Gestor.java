package org.taulyd.torrente;


import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.security.PrivateKey;
import java.security.PublicKey;

public class Gestor {
    private static final String ENLACE = Gestor.class.getResource("/con.txt").getFile();
    private static final String CP = Gestor.class.getResource("/cp.key").getFile();

    public static boolean guardar(String contra) {
        try (BufferedWriter escritor = new BufferedWriter(new FileWriter(new File(ENLACE)))) {
            escritor.write(contra);
            return true;
        } catch (Exception e) {
            System.err.println(e.getMessage());
            return false;
        }
    }

    public static boolean recuperar(String contra) {
        try (BufferedReader lector = new BufferedReader(new FileReader(new File(ENLACE)))) {
            String hash = lector.readLine();

            return hash.equals(contra);
        } catch (Exception e) {
            System.err.println(e.getMessage());
            return false;
        }
    }

    public static boolean existeContrasena() {
        File archivo = new File(ENLACE);
        return archivo.length() != 0;
    }

    public static boolean existeClavePrivada() {
        File archivo = new File(CP);
        return archivo.length() != 0;
    }

    public static void guardarClavePrivada(PrivateKey clavePrivada) {
        try (ObjectOutputStream escritor = new ObjectOutputStream(new FileOutputStream(CP))) {
            escritor.writeObject(clavePrivada);
        } catch(Exception e){
            System.err.println(e.getMessage());
        }
    }

    public static PrivateKey cargarClavePrivada() {
        try (ObjectInputStream lector = new ObjectInputStream(new FileInputStream(CP))) {
            return (PrivateKey) lector.readObject();
        }catch(Exception e){
            System.err.println(e.getMessage());
            return null;
        }
    }

    public static void guardarClavePublica(PublicKey publicKey, String ruta){
        try (ObjectOutputStream escritor = new ObjectOutputStream(new FileOutputStream(ruta))) {
            escritor.writeObject(publicKey);
        }catch(Exception e){
            System.err.println(e.getMessage());
        }
    }

    public static PublicKey cargarClavePublica(String ruta) {
        try (ObjectInputStream lector = new ObjectInputStream(new FileInputStream(ruta))) {
            return (PublicKey) lector.readObject();
        }catch(Exception e){
            System.err.println(e.getMessage());
            return null;
        }
    }
}

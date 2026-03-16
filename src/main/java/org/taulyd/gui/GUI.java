package org.taulyd.gui;

import java.io.BufferedInputStream;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Properties;

import org.taulyd.App;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

public class GUI extends Application {
    public static Scene escena;

    @Override
    public void start(Stage ventana) throws IOException {
        escena = new Scene(loadFXML("/FXML/InicioSesion"), 640, 480);
        escena.getStylesheets().add(estilo(recuperarEstilo()));
        ventana.setScene(escena);
        ventana.show();
    }

    public static void setRoot(String fxml)  {
        try {
            escena.setRoot(loadFXML(fxml));
        } catch (IOException e) {
            System.err.println(e.getMessage());
        }
    }

    private static Parent loadFXML(String fxml) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(App.class.getResource(fxml + ".fxml"));
        return fxmlLoader.load();
    }

    private static String estilo(String estilo){
        return GUI.class.getResource("/CSS/"+estilo+".css").toExternalForm();
    }

    public static void cambiarEstilo(String estilo) {
        escena.getStylesheets().clear();
        escena.getStylesheets().add(estilo(estilo));
    }

    public static void atualizarEstilo(String estilo) {
        Properties configuracion = new Properties();

        try (BufferedWriter escritor = new BufferedWriter(new FileWriter(new File(GUI.class.getResource("/configuracion.properties").getFile())))) {

            configuracion.setProperty("Tema", estilo);
            configuracion.store(escritor, "");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void iniciar(){
        launch();
    }

    public static String recuperarEstilo(){
        Properties configuracion = new Properties();

        String estilo = "";

        try (BufferedInputStream lector = new BufferedInputStream(GUI.class.getResourceAsStream("/configuracion.properties"))) {
            configuracion.load(lector);

            estilo=configuracion.getProperty("Tema", "Claro");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return estilo;
    }

    
}

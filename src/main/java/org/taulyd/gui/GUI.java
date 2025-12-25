package org.taulyd.gui;

import java.io.IOException;

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
        escena.getStylesheets().add(estilo());
        ventana.setScene(escena);
        ventana.show();
    }

    static void setRoot(String fxml) throws IOException {
        escena.setRoot(loadFXML(fxml));
    }

    private static Parent loadFXML(String fxml) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(App.class.getResource(fxml + ".fxml"));
        return fxmlLoader.load();
    }

    private static String estilo(){
        return GUI.class.getResource("/CSS/Claro.css").toExternalForm();
    }

    public static void iniciar(){
        launch();
    }
}

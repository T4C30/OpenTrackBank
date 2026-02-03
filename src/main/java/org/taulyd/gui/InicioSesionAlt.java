package org.taulyd.gui;

import javafx.fxml.FXML;
import javafx.scene.Group;
import javafx.scene.Scene;
import javafx.stage.Stage;

// Ventana de espera cuando se llama al certificado
public class InicioSesionAlt {

    @FXML
    private void initialize() {
        //TODO: Ventana de espera cuando se llama al certificado
        Group raiz = new Group();
        Stage ventana = new Stage();
        Scene escena = new Scene(raiz, 300,300);
        ventana.setScene(escena);
        ventana.show();

        

        
    }
}

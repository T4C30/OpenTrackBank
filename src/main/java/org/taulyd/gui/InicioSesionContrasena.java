package org.taulyd.gui;

import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.TextField;
import javafx.scene.input.MouseEvent;

public class InicioSesionContrasena {
    @FXML
    private TextField con;

    @FXML
    private TextField repetirCon;

    @FXML
    private Button inicio;


    @FXML
    private void initialize() {
        inicio.setOnMouseClicked(this::inicioSesion);
    }

    @FXML
    private void inicioSesion(MouseEvent e){
        // TODO: Agregar Comportamiento
    }
}

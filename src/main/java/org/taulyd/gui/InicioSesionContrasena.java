package org.taulyd.gui;

import java.io.IOException;

import org.taulyd.seguridad.Cifrado;
import org.taulyd.torrente.Gestor;

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
        if (con.getText().equals(repetirCon.getText())) {
            if (Gestor.recuperar(Cifrado.sha256(con.getText()))) {
                try {
                    GUI.setRoot("/FXML/PantallaPrincipal");
                } catch (IOException ex) {System.err.println(ex.getMessage());}
            }
        }  
    }
}

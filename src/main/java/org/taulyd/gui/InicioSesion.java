package org.taulyd.gui;

import java.io.IOException;

import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.input.MouseEvent;

public class InicioSesion {

    @FXML
    private Button iniCon;

    @FXML
    private Button iniAlt;

    @FXML
    private void initialize() {
        iniCon.setOnMouseClicked(this::inicioCon);
        iniAlt.setOnMouseClicked(this::inicioAlternativo);
    }


    @FXML
    private void inicioCon(MouseEvent e){
        try {
            GUI.setRoot("/FXML/InicioSesionCon");
        } catch (IOException ex) {System.err.println(ex.getMessage());}
    }
    
    @FXML
    private void inicioAlternativo(MouseEvent e){
        try {
            GUI.setRoot("/FXML/InicioSesionAlt");
        } catch (IOException ex) {System.err.println(ex.getMessage());}
    }
}

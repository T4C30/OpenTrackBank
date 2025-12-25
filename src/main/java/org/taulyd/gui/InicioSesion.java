package org.taulyd.gui;

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
        // TODO: Agregar Comportamiento
    }
    
    @FXML
    private void inicioAlternativo(MouseEvent e){
        // TODO: Agregar Comportamiento
    }
}

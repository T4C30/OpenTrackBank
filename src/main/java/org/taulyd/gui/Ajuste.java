package org.taulyd.gui;

import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.ChoiceBox;
import javafx.scene.image.ImageView;
import javafx.scene.input.MouseEvent;

public class Ajuste {
    @FXML
    private Button ajustes;

    @FXML
    private Button estado;

    @FXML
    private ImageView cerrar;

    @FXML
    private ChoiceBox<String> localizacion;

    @FXML
    private ChoiceBox<String> tema;



    @FXML
    private void initialize() {
        ajustes.setOnMouseClicked(this::botonAjuste);
        estado.setOnMouseClicked(this::botonEstado);
        cerrar.setOnMouseClicked(this::botonCerrar);
        localizacion.setOnMouseClicked(this::seleccionIdioma);
        tema.setOnMouseClicked(this::seleccionTema);
    }



    @FXML
    private void botonAjuste(MouseEvent e){
        // TODO: Agregar Comportamiento
    }

    @FXML
    private void botonEstado(MouseEvent e){
        // TODO: Agregar Comportamiento
    }

    @FXML
    private void botonCerrar(MouseEvent e){
        // TODO: Agregar Comportamiento
    }

    @FXML
    private void seleccionIdioma(MouseEvent e){
        // TODO: Agregar Comportamiento
    }

    @FXML
    private void seleccionTema(MouseEvent e){
        // TODO: Agregar Comportamiento
    }
}

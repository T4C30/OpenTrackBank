package org.taulyd.gui;

import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.image.ImageView;
import javafx.scene.layout.HBox;
import javafx.scene.shape.Circle;

public class PantallaPrincipal {
    @FXML
    private ImageView menu;

    @FXML
    private ImageView ajuste;

    @FXML
    private ImageView izquierda;

    @FXML
    private Circle punto;

    @FXML
    private ImageView derecha;

    @FXML
    private Label entidadBancaria;

    @FXML
    private Label resumenMensual;

    @FXML
    private HBox totalDinero;

    @FXML
    private Label ordenTrasaccion;

    @FXML
    private Label banco;

    @FXML
    private Label movimiento;

    @FXML
    private Label muestraAnterior;



    @FXML
    private void initialize() {
        // Hint: initialize() will be called when the associated FXML has been completely loaded.
    }
}

package org.taulyd.gui;

import org.taulyd.seguridad.Cifrado;
import org.taulyd.torrente.Gestor;

import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.input.MouseEvent;

public class InicioSesionContrasena {
    @FXML
    private Label textoRepetir;

    @FXML
    private TextField con;

    @FXML
    private TextField repetirCon;

    @FXML
    private Button inicio;


    @FXML
    private void initialize() {
        if (Gestor.existeContrasena()) {
            inicio.setOnMouseClicked(this::inicioSesion);
            repetirCon.setVisible(false);
            textoRepetir.setVisible(false);
        }else{
            inicio.setText("Registrar Contraseña");
            inicio.setOnMouseClicked(this::registrarSesion);
        }
    }

    @FXML
    private void registrarSesion(MouseEvent e){
        if (con.getText().equals(repetirCon.getText())) {
            if (Gestor.guardar(Cifrado.sha256(con.getText()))) {
                cambio();
            }
        }  
    }
    
    @FXML
    private void cambio(){
        GUI.setRoot("/FXML/PantallaPrincipal");
    }

    @FXML
    private void inicioSesion(MouseEvent e){
        if (Gestor.recuperar(Cifrado.sha256(con.getText()))) cambio();
    }
}

package org.taulyd.gui;

import java.io.File;
import java.security.PublicKey;

import org.taulyd.model.Idioma;
import org.taulyd.model.Tema;
import org.taulyd.seguridad.Cifrado;
import org.taulyd.torrente.Gestor;

import javafx.beans.value.ObservableValue;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.ChoiceBox;
import javafx.scene.image.ImageView;
import javafx.scene.input.MouseEvent;
import javafx.stage.FileChooser;
import javafx.stage.Stage;

public class Ajuste {
    @FXML
    private Button clavePublica;

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
        localizacion.getItems().addAll(Idioma.Espanol.name(),Idioma.Ingles.name());
        tema.getItems().addAll(Tema.Oscuro.name(),Tema.Claro.name());
        

        tema.getSelectionModel().selectedItemProperty().addListener((ObservableValue<? extends String> observable, String oldValue, String newValue) -> {
            GUI.atualizarEstilo(newValue);
            GUI.cambiarEstilo(newValue);
        });

        localizacion.getSelectionModel().selectedItemProperty().addListener((ObservableValue<? extends String> observable, String oldValue, String newValue) -> {

        });

        cerrar.setOnMouseClicked(e-> GUI.setRoot("/FXML/PantallaPrincipal"));
        
        clavePublica.setOnMouseClicked(this::generarClave);
    }


    @FXML
    private void generarClave(MouseEvent e){
        PublicKey llave = Cifrado.generatePublicKeyFromPrivate(Gestor.cargarClavePrivada());

        FileChooser selector = new FileChooser();
        selector.setTitle("Elige donde guardar la clave publica");
        File archivo = selector.showSaveDialog(new Stage());

        Gestor.guardarClavePublica(llave, archivo.getAbsolutePath());
    }


}

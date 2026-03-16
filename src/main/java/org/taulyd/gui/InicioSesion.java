package org.taulyd.gui;

import java.io.File;
import java.security.KeyPair;
import java.security.PrivateKey;
import java.security.PublicKey;

import org.taulyd.seguridad.Cifrado;
import org.taulyd.torrente.Gestor;

import javafx.fxml.FXML;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.Button;
import javafx.scene.input.MouseEvent;
import javafx.stage.FileChooser;
import javafx.stage.Stage;

public class InicioSesion {
    @FXML
    private Button iniClave;


    @FXML
    private Button iniCon;


    @FXML
    private void initialize() {
        iniCon.setOnMouseClicked(this::inicioCon);
        iniClave.setOnMouseClicked(this::inicioClave);
    }


    @FXML
    private void inicioCon(MouseEvent e){
        GUI.setRoot("/FXML/InicioSesionCon");
    }
    
    @FXML
    private void inicioClave(MouseEvent e){
        FileChooser selector = new FileChooser();
        PrivateKey clavePrivada;
        PublicKey clavePublica;
        if (Gestor.existeClavePrivada()) {
            selector.setTitle("Elige la Clave publica");
            File archivoClavePublica = selector.showOpenDialog(new Stage());
            if (archivoClavePublica == null) return;

            clavePrivada = Gestor.cargarClavePrivada();
            clavePublica = Gestor.cargarClavePublica(archivoClavePublica.getAbsolutePath());
            if (!Cifrado.comprobacionClaves(clavePrivada, clavePublica)) return;
        }else{
            KeyPair pares = Cifrado.generadorClave();
            if (pares == null) return;
            clavePrivada = pares.getPrivate();
            clavePublica = pares.getPublic();
            selector.setTitle("Elige donde guardar la clave publica");
            File archivo = selector.showSaveDialog(new Stage());
            if (archivo == null) return;
            Gestor.guardarClavePrivada(clavePrivada);
            Gestor.guardarClavePublica(clavePublica, archivo.getAbsolutePath());
        }
        if (!Gestor.existeContrasena()) mensajeAdvertencia();
        GUI.setRoot("/FXML/PantallaPrincipal");
    }

    @FXML
    private void mensajeAdvertencia(){
        Alert alerta = new Alert(AlertType.INFORMATION);
        alerta.setTitle("Aviso a Navegantes");
        alerta.setHeaderText("Contraseña no generada");
        alerta.setContentText("Se recomienda al usuario generar una contraseña, la perdida del fichero ocasionaria la imposibilidad de entrar en el programa.");
        alerta.showAndWait();
    }
}

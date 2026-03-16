package org.taulyd.gui;

import java.util.List;

import org.taulyd.torrente.PlaidCliente;
import org.taulyd.torrente.PlaidCliente.Cuenta;
import org.taulyd.torrente.PlaidCliente.Transaccion;

import javafx.application.Platform;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.control.ListView;
import javafx.scene.image.ImageView;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;

public class PantallaPrincipal {
    @FXML
    private ListView<TransaccionLista> listaTransaccion;

    @FXML
    private Label saldoDisponible;

    @FXML
    private Label saldoActual;

    @FXML
    private ImageView menu;

    @FXML
    private ImageView ajuste;

    @FXML
    private ImageView izquierda;

    @FXML
    private ImageView derecha;

    @FXML
    private Label entidadBancaria;
    
    private List<Cuenta> cuentas;

    private int indice;

    private Thread tarea;

    
    @FXML
    private void initialize() {
        indice = 0;
        cuentas = List.of();


        ajuste.setOnMouseClicked(_ -> GUI.setRoot("/FXML/Ajuste"));

        derecha.setOnMouseClicked(this::mas);
        izquierda.setOnMouseClicked(this::menos);

        tarea = new Thread(() -> {
            cuentas = PlaidCliente.recuperarCuentas();
            actualizarTransacciones();
        });

        carga("Cargando");
        
        inicio();
    }

    @FXML
    private void inicio(){
        tarea.start();

        new Thread(()->{
            try {
                tarea.join();
                Platform.runLater(()-> {
                    actualizarCuenta(cuentas.get(0));
                });
            } catch (InterruptedException ex) {
                ex.printStackTrace();
            }

        }).start();
        
    }

    private void carga(String carga){
        entidadBancaria.setText(carga);
        saldoDisponible.setText(carga);
        saldoActual.setText(carga);
    }

    @FXML
    private void menos(MouseEvent e){
        if (indice != 0) {
            indice--;
            actualizarCuenta(cuentas.get(indice));
        }
    }

    @FXML
    private void mas(MouseEvent e){
        if (indice < cuentas.size()-1) {
            indice++;
            actualizarCuenta(cuentas.get(indice));
        }
    }

    @FXML
    private void actualizarCuenta(Cuenta cuenta){
        entidadBancaria.setText(cuenta.nombre());
        saldoDisponible.setText(String.valueOf(cuenta.disponible()==null? 0 : cuenta.disponible()));
        saldoActual.setText(String.valueOf(cuenta.actual()));
    }
    
    @FXML
    private void actualizarTransacciones(){
        List<Transaccion> transacciones = PlaidCliente.recuperarTransacciones();

        List<TransaccionLista> vistaLista = transacciones.stream().map(TransaccionLista::new).toList();

        ObservableList<TransaccionLista> lista = FXCollections.observableList(vistaLista);

        listaTransaccion.setItems(lista);
    }
    
    private class TransaccionLista extends VBox {
        private AnchorPane parteSuperior;
        private AnchorPane parteInferior;
        private Label ordenTransaccion;
        private Label fecha;
        private Label cantidad;
        

        public TransaccionLista(Transaccion transaccion) {
            this.cantidad = contructorCantidad(transaccion.cantidad());
            this.ordenTransaccion = new Label(transaccion.ordenTransaccion());
            this.fecha = new Label(String.valueOf(transaccion.fecha()));
            Label fechaTexto = new Label("Fecha");
            this.parteSuperior = new AnchorPane(ordenTransaccion, fechaTexto);
            this.parteInferior = new AnchorPane(cantidad, fecha);

            AnchorPane.setLeftAnchor(this.ordenTransaccion, 0.0);
            AnchorPane.setLeftAnchor(this.cantidad, 0.0);
            AnchorPane.setRightAnchor(this.fecha, 0.0);
            AnchorPane.setRightAnchor(fechaTexto, 0.0);
            
            getChildren().add(this.parteSuperior);
            getChildren().add(this.parteInferior);
        }

        private Label contructorCantidad(Double cantidad){
            Label c = new Label(String.valueOf(cantidad));
            Color color = cantidad >= 0 ? Color.GREEN : Color.RED;

            c.setTextFill(color);
            return c;
        }

        


        
        
    }
}

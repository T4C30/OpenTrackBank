
// Comprobar que el correo y la contra este bien puesto
import 'package:flutter/material.dart';
import 'package:open_track_bank/modelo/icono.dart';

bool minimoRegistro(String email, String con, String repetirCon){
  if (!email.contains("@")) {
    return false;
  }

  if (con != repetirCon) {
    return false;
  }

  return true;
}

// Comprobar que no exista en la base de datos
bool comprobarRegistro(String email, String con) {
  // Hacer aqui la api de python
  return true;
}

bool comprobarSesion(String email, String con){
  return true;
}

List<Map<String, dynamic>> obtenerCuentas(){
  List<Map<String,dynamic>> cuentas = [];
  
  Map<String, dynamic> cuentaA = {
    "id": "asdfaercvef",
    "nombre": "Ahorros",
    "saldo": 12.00
  };


  Map<String, dynamic> cuentaB = {
    "id": "gnhjjhkghjkybv",
    "nombre": "Cuenta Principal",
    "saldo": 123.00
  };

  cuentas.addAll([cuentaA, cuentaB]);

  return cuentas;
}


List<ListTile> obtenerUltimasTransacciones(String id){
  List<ListTile> transacciones = [];
  List supuestoJson = [
    {
      "icono": "comida",
      "nombre": "Mercadona",
      "total": 45.00
    },
    {
      "icono": "compra",
      "nombre": "Mercadona",
      "total": 15.00
    },
    {
      "icono": "compra",
      "nombre": "El Chino",
      "total": 5.00
    }
  ];


  for (Map json in supuestoJson) {
    IconData icd = Icono.values.firstWhere(
      (e) => e.name == json["icono"]
    ).icono;
    transacciones.add(
      ListTile(leading: Icon(icd), title: Text(json["nombre"]), trailing: Text("${json["total"]} €"))
    );
  }


  return transacciones;

}

List<Map<String, dynamic>> obtenerTransacciones({String id=""}){
  // FIXME: Arreglar esto porque no se me mete en parametros de la funcion
  DateTime horario = DateTime(2017, 9, 7, 17, 30);
  List<Map<String, dynamic>> transacciones = List.empty();
  
  Map<String, dynamic> transaccion = {
    "id": "IDVWRfsdf34sg",
    "tipo": "Merchant", // Enum
    "nombre": "Burguer King",
    "ingreso": true,
    "saldo": 12.00
  };

  transacciones.add(transaccion);

  return transacciones;
}
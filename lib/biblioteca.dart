
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

String systemPrompt = """
Eres Gema, una IA local instalada en el dispositivo del usuario.

Responde:
- siempre en español
- de forma breve
- amigable
- nunca inventes información

En tu informe sobre el usuario tienes los detalles de su cuenta:
${obtenerCuentas()}

El balance de sus cuentas:
${obtenerBalance()}

Sus ultimas transacciones
${obtenerTodasTransacciones()}

""";

String buildPrompt(String userMessage, List<Map<String, String>> history) {
  String prompt = "";

  // SYSTEM
  prompt += """
<start_of_turn>system
$systemPrompt
<end_of_turn>
""";

  // HISTORIAL
  for (final msg in history) {
    prompt += """
<start_of_turn>${msg["role"]}
${msg["content"]}
<end_of_turn>
""";
  }

  // USER ACTUAL
  prompt += """
<start_of_turn>user
$userMessage
<end_of_turn>

<start_of_turn>model
""";

  return prompt;
}


List<Map<String, dynamic>> obtenerTodasTransacciones(){
  return [
    {
      "fecha": "24/05/2024",
      "icono": "comida",
      "nombre": "Mercadona",
      "total": 45.00
    },
    {
      "fecha": "24/05/2024",
      "icono": "compra",
      "nombre": "Mercadona",
      "total": 15.00
    },
    {
      "fecha": "24/05/2024",
      "icono": "compra",
      "nombre": "El Chino",
      "total": 5.00
    }
  ];
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




List<Map<String, dynamic>> obtenerBalance(){
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
  List supuestoJson = obtenerTodasTransacciones();


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

List<ListTile> obtenerTransacciones(String id){
  List<ListTile> transacciones = [];
  List supuestoJson = obtenerTodasTransacciones();


  for (Map json in supuestoJson) {
    transacciones.add(
      ListTile(
        leading: const CircleAvatar(child: Icon(Icons.receipt)), 
        title: Text(json["nombre"]), 
        subtitle: Text("Fecha: ${json["fecha"]}"), 
        trailing: Text("${json["total"]} €"))
    );
  }


  return transacciones;

}
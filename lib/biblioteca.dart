
// Comprobar que el correo y la contra este bien puesto
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

List<String> obtenerCuentas(){
  Map<String, dynamic> cuenta = {
    "id": 3,
    "nombre": "Ahorros",
    "saldo": 12.00
  };

  return ["Cuenta Principal", "Ahorros"];
}

Map<String, dynamic> obtenerTransacciones(String id){
  Map<String, dynamic> transaccion = {
    "tag": "Hamburgesa",
    "causa": "Nomina",
    "ingreso": true,
    "saldo": 12.00
  };

  return transaccion;
}
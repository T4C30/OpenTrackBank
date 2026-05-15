import 'package:flutter/material.dart';
import 'package:open_track_bank/biblioteca.dart';
import 'transacciones_page.dart';

class CuentaTab extends StatefulWidget {
  const CuentaTab({super.key});

  

  @override
  State<CuentaTab> createState() => _CuentaTabState();
}

class _CuentaTabState extends State<CuentaTab> {
  // Cambia esto a false para ver el mensaje de advertencia
  late bool tieneCuentaEnlazada; 
  int cuentaIndex = 0;
  late List<Map<String,dynamic>> cuentas;
  late Map<String, dynamic> cuenta;

  _CuentaTabState(){
    cuentas = obtenerCuentas();
    tieneCuentaEnlazada = cuentas.isNotEmpty;
    if (tieneCuentaEnlazada) {
      cuenta = cuentas[0];  
    }else {
      cuenta = {};
    }
  }

  

  void decrementar(){
    setState(() {
      if (cuentaIndex > 0) {
        cuentaIndex--;
        cuenta = cuentas[cuentaIndex]; 
      }
    });
  }

  void incrementar(){
    setState(() {
      if (cuentas.length-1 > cuentaIndex){
        cuentaIndex++;
        cuenta = cuentas[cuentaIndex];
      }
    });
  }




  @override
  Widget build(BuildContext context) {
    if (!tieneCuentaEnlazada) {
      return const Center(
        child: Text(
          'No tienes ninguna cuenta enlazada.\nVe a Ajustes para enlazar tu banco.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 12),
          Text(cuenta["nombre"], style: const TextStyle(color: Colors.grey)),
          // Selector de cuenta y Saldo
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 2),
              IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => decrementar(),
                ),
              Spacer(),
                                 
              Text("${cuenta["saldo"]} €", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),

              Spacer(),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () => incrementar(),
              ),
              Spacer(flex: 2,)
            ],
          ),
          const SizedBox(height: 12),
          const Divider(),



          // Últimas transacciones
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Últimas Transacciones', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ),
          Expanded(
            child: ListView(
              children: obtenerUltimasTransacciones(cuenta["id"]),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TransaccionesPage()),
              );
            },
            child: const Text('Ver todas las transacciones'),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
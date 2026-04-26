import 'package:flutter/material.dart';
import 'transacciones_page.dart';

class CuentaTab extends StatefulWidget {
  const CuentaTab({Key? key}) : super(key: key);

  @override
  State<CuentaTab> createState() => _CuentaTabState();
}

class _CuentaTabState extends State<CuentaTab> {
  // Cambia esto a false para ver el mensaje de advertencia
  bool tieneCuentaEnlazada = true; 
  int cuentaIndex = 0;
  List<String> cuentas = ["Cuenta Principal", "Ahorros"];

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
          // Selector de cuenta y Saldo
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () => setState(() => cuentaIndex = (cuentaIndex - 1) % cuentas.length),
                  )
                ),
                Column(
                  children: [
                    Text(cuentas[cuentaIndex.abs()], style: const TextStyle(color: Colors.grey)),
                    const Text('\$12,450.00', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () => setState(() => cuentaIndex = (cuentaIndex + 1) % cuentas.length),
                  )
                )
              ],
            ),
          ),
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
              children: const [
                ListTile(leading: Icon(Icons.fastfood), title: Text('Restaurante'), trailing: Text('-\$45.00')),
                ListTile(leading: Icon(Icons.shopping_cart), title: Text('Supermercado'), trailing: Text('-\$120.50')),
                ListTile(leading: Icon(Icons.attach_money), title: Text('Nómina'), trailing: Text('+\$2,500.00', style: TextStyle(color: Colors.green))),
              ],
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
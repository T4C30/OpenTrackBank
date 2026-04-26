import 'package:flutter/material.dart';

class TransaccionesPage extends StatelessWidget {
  const TransaccionesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todas las transacciones')),
      body: ListView.builder(
        itemCount: 15, // Ejemplo
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(child: Icon(Icons.receipt)),
            title: Text('Transacción #${index + 1}'),
            subtitle: const Text('Fecha: 25/04/2026'),
            trailing: Text(index % 3 == 0 ? '+\$100.00' : '-\$20.00', 
                style: TextStyle(color: index % 3 == 0 ? Colors.green : Colors.red)),
          );
        },
      ),
    );
  }
}
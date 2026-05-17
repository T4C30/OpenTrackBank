import 'package:flutter/material.dart';
import 'package:open_track_bank/biblioteca.dart';

class TransaccionesPage extends StatelessWidget {
  final String id;
  
  const TransaccionesPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todas las transacciones')),
      body: ListView(
        children: obtenerTransacciones(id)
      )
    );
  }
}
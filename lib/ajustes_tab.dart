import 'package:flutter/material.dart';
import 'package:plaid_universal/plaid_universal.dart';

class AjustesTab extends StatelessWidget {
  const AjustesTab({super.key});


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Ajustes', 
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 40),
            const Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("Usuario de Pruebas"),
                subtitle: Text("usuario@ejemplo.com"),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
              final result = await Navigator.of(context).push<String>(
                MaterialPageRoute(
                  builder: (context) => PlaidUniversal(
                    config: const LinkTokenConfiguration(
                      token: "link-sandbox-39cd53ee-b656-46b7-bbe6-5efe149262f6"
                    ),
                    onEnrollment: (publicToken, metadata){
                      Navigator.pop(context, publicToken);
                    },
                    onExit: (exit){
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
              print(result);
            },
              icon: const Icon(Icons.account_balance),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              label: const Text('Enlazar Cuenta con Plaid'),
            ),
          ],
        ),
      ),
    );
  }
}
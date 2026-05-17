import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_track_bank/inicio_page.dart';
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
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 40),
          
            Card(
              child: ListTile(
                title: Text("Cuentas vinculadas a la aplicacion"),
                onTap: () {
                  // Obtener cuentas Y guardarlas
                },
              ),
            ),
            
            ListView(
              shrinkWrap: true,
                // Obtener todas las cuentas disponible
              children: [
                ListTile(
                  title: Text("Cuenta A"),
                  subtitle: Text("Tipo"),
                  leading: Icon(Icons.subdirectory_arrow_right),
                ),
              ],
            ),
            
            Card(
              child: ListTile(
                title: Text("Salir de la sesion"),
                onTap: () {
                  Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => InicioPage()),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Salir de la aplicacion"),
                onTap: () {
                  exit(0);
                },
              ),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () async {
                // Primero obtener el token, usar ela funcion create_link_token
                String token =
                    "link-sandbox-39cd53ee-b656-46b7-bbe6-5efe149262f6";
                final result = await Navigator.of(context).push<String>(
                  MaterialPageRoute(
                    builder: (context) => PlaidUniversal(
                      config: LinkTokenConfiguration(token: token),
                      onEnrollment: (publicToken, metadata) {
                        Navigator.pop(context, publicToken);
                      },
                      onExit: (exit) {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
                // Guardar el access token, get_access_token
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

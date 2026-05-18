import 'package:flutter/material.dart';
import 'package:open_track_bank/biblioteca.dart';
import 'main_layout.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController correo = TextEditingController();
  final TextEditingController con = TextEditingController();
  final TextEditingController conRep = TextEditingController();

  RegisterPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear Cuenta')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 1),
            const Text(
              'Open Track Bank',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.0,
              ),
            ),
            const Text(
              'Tu futuro financiero, hoy.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const Spacer(flex: 1),

            TextField(
              decoration: const InputDecoration(labelText: 'Correo Electrónico'),
              keyboardType: TextInputType.emailAddress,
              controller: correo,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
              controller: con,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: 'Repetir Contraseña'),
              obscureText: true,
              controller: conRep,
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () async {
                if (!minimoRegistro(correo.text, con.text, conRep.text)) {
                  return;
                }
                if (await comprobarRegistro(correo.text, con.text)) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MainLayout()),
                    (Route<dynamic> route) => false,
                  );
                }
                
              },
              child: const Text('Registrarse'),
            ),
            const Spacer(flex: 1)
          ],
        ),
      ),
    );
  }
}
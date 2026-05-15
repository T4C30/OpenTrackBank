import 'package:flutter/material.dart';
import 'package:open_track_bank/biblioteca.dart';
import 'main_layout.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController correo = TextEditingController();
  final TextEditingController con = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar Sesión')),
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
            const TextField(
              decoration: InputDecoration(labelText: 'Correo Electrónico'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla principal tras "iniciar sesión"
                if (comprobarSesion(correo.text, con.text)) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MainLayout()),
                    (Route<dynamic> route) => false,
                  );
                }
              },
              child: const Text('Entrar'),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
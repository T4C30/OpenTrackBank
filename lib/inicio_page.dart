import 'package:flutter/material.dart';
import 'login_page.dart';
import 'register_page.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity, // Forzamos a que el contenedor ocupe todo el ancho
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              // Centramos horizontalmente todos los hijos de la columna
              crossAxisAlignment: CrossAxisAlignment.center, 
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
                
                // Contenedor de botones
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 250,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                        },
                        child: const Text('INICIAR SESIÓN'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 250,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterPage()),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Theme.of(context).primaryColor),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          minimumSize: const Size(double.infinity, 55),
                        ),
                        child: const Text('CREAR CUENTA'),
                      ),
                    ),
                  ],
                ),
                
                const Spacer(flex: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
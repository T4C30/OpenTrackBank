import 'package:flutter/material.dart';
import 'inicio_page.dart';

void main() {
  runApp(const MiFintechApp());
}

class MiFintechApp extends StatelessWidget {
  const MiFintechApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fintech App',
      debugShowCheckedModeBanner: false, // Quitamos la etiqueta de debug
      // Definimos el tema oscuro profesional
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212), // Fondo principal oscuro
        primaryColor: const Color(0xFF1E88E5), // Azul profesional
        
        // Esquema de colores moderno
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF1E88E5), // Azul para botones principales
          secondary: Color(0xFF00BFA5), // Verde agua para acentos/dinero
          surface: Color(0xFF1E1E1E), // Gris oscuro para tarjetas y barras
        ),
        
        // Estilo global de la barra superior
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        
        // Estilo global de la barra de navegación inferior
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1E1E1E),
          selectedItemColor: Color(0xFF1E88E5),
          unselectedItemColor: Colors.grey,
          elevation: 8,
          type: BottomNavigationBarType.fixed,
        ),
        
        // Estilo global de los botones
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E88E5),
            foregroundColor: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            minimumSize: const Size(double.infinity, 55), // Botones anchos y altos
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
        ),
        
        // Estilo global de los campos de texto
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF2C2C2C), // Fondo del input
          labelStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF1E88E5), width: 2),
          ),
        ),
        
        // Estilo global de las tarjetas
        cardTheme: CardThemeData(
          color: const Color(0xFF1E1E1E),
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      home: const InicioPage(),
    );
  }
}
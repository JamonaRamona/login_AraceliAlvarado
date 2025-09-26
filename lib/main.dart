import 'package:flutter/material.dart'; //importar el paquete principal de Flutter
import 'package:app_login/login_screen.dart'; //importar la pantalla de login
import 'package:google_fonts/google_fonts.dart'; //importar el paquete de Google Fonts para usar fuentes personalizadas

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Polaval Propiedades",

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E3A8A), // azul marino
          brightness: Brightness.light,
        ),

        scaffoldBackgroundColor: const Color(0xFFF8F8F2),
        
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),

      home: const LoginScreen(), //pantalla que se muestra al abrir la app
    );
  }
}


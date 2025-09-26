// -------------------- IMPORTS --------------------
import 'package:flutter/material.dart'; //importar el paquete principal de Flutter


// -------------------- PANTALLA DE BIENVENIDA --------------------
class WelcomeScreen extends StatelessWidget {
  final String email;
  const WelcomeScreen({super.key, required this.email}); // recibir el email ingresado en la pantalla de login

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Polaval Propiedades")),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text(
                "¡Bienvenido/a, $email!",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),
              
              const Text(
                "Gracias por confiar en Polaval Propiedades.\n"
                "Desde esta aplicación podrás consultar el estado de tus propiedades, "
                "así como el progreso de tus solicitudes de compra, venta o arriendo.\n\n"
                "¡Tus sueños, nuestra meta!",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

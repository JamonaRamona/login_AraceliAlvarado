import 'package:app_login/login_fields.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      appBar: AppBar(title: const Text("Login")),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            
            //desplazar la vista al aparecer el teclado
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            
            padding: EdgeInsets.fromLTRB(
              16, 24, 16, 
              MediaQuery.of(context).viewInsets.bottom + 24,
            ),
            
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: LoginFields()),

          ),
          )),
    );
  }
}
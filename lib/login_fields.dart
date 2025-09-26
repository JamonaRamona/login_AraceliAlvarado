//importar el paquete principal de Flutter
import 'package:flutter/material.dart';
//importar la pantalla a la que se navega después de iniciar sesión
import 'package:app_login/welcome_screen.dart';


//constructor del widget StateFul (que puede cambiar durante la ejecución, por ejemplo al escribir o validar)
class LoginFields extends StatefulWidget {
  const LoginFields({super.key});
  @override
  State<LoginFields> createState() => _LoginFieldsState();
}

//variables internas para manejar el estado del formulario de login
class _LoginFieldsState extends State<LoginFields>{
  final _formKey=GlobalKey<FormState>(); // clave para validar el formulario
  final _emailCtrl=TextEditingController(); //controlador para el campo email
  final _passCtrl=TextEditingController(); //controlador para el campo contraseña
  bool _obscure=true; //controla visibilidad de contraseña (true=oculta, false=muestra)
  bool _loading=false; //controla si se está procesando el login (true=procesando, false=no)
  String? _error; //mensaje de error (null si no hay error)


//libera los recursos de los controladores cuando el widget se elimina
  @override void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

//método que procesa el envío del formulario de login
  Future<void> _submit() async{
    FocusScope.of(context).unfocus(); //oculta el teclado al enviar el formulario

//validar el formulario (si no es válido, no continuar)
    final ok=_formKey.currentState?.validate()??false;
    if (!ok) return;
    setState(() {
      _loading=true; //indica que se está procesando la petición (true)
      _error=null; //limpia mensajes de error previos
    });

//almacenar el email ingresado
    final email = _emailCtrl.text.trim(); 

//simular una petición de login (aquí se debería conectar a un servidor real)
    try{
      await Future.delayed(const Duration(milliseconds: 3000));
      if(!mounted) return; //verifica que el widget siga montado antes de navegar (evita errores si se desmonta)
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>WelcomeScreen(email: email,))); //si la petición es exitosa, navegar a la pantalla de bienvenida

    }catch(e){ //manejo de errores (credenciales inválidas, error de red)
      if(!mounted) return;
      setState(() => _error="Credenciales inválidas o error de red"); //es una simulación, en este proyecto no hay como validar credenciales aún
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No se ha podido iniciar sesión")));
    }finally{
      if(mounted) setState(() => _loading=false); //detener rueda de carga (false)
    }
  }

//construir la interfaz del formulario de login
  @override
  Widget build(BuildContext context) {
    return GestureDetector( 
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(), //cierra el teclado al tocar fuera de los campos
      
          child: AutofillGroup(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min, //la altura al mínimo necesario

                children: [
                  Center(
                    child: Image.network(
                      "https://i.ibb.co/LXhNCjGy/polaval-logo.png",
                      height: 300,
                      fit: BoxFit.contain,
                    ),
                  ),
                  
                  const SizedBox(height: 16),

                  //------ TÍTULO DEL FORMULARIO -------
                  const Text(
                    "Iniciar sesión",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 16),


                  //------ CAMPO EMAIL -------
                  TextFormField(
                    enabled: !_loading,
                    controller: _emailCtrl,
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    enableSuggestions: false,
                    autofillHints: const [AutofillHints.email],

                    decoration: const InputDecoration(
                      labelText: "Email",
                      hintText: "tucorreo@correo.cl",
                      prefixIcon: Icon(Icons.email_rounded),
                      border: OutlineInputBorder(),
                    ),

                    //validación del email
                    validator: (v) {
                      final value = v?.trim() ?? '';
                      if (value.isEmpty) return "Ingresa tu email";
                      final emailOk = RegExp(r'^\S+@\S+\.\S+$').hasMatch(value);
                      return emailOk ? null : "Email inválido";
                    },

                    //mover el foco al siguiente campo al presionar "enter"
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  ),

                  const SizedBox(height: 16),

                  //------ CAMPO CONTRASEÑA -------
                  TextFormField(
                    enabled: !_loading,
                    controller: _passCtrl, //controlador que guarda la contraseña
                    obscureText: _obscure, //oculta el texto (true=oculta, false=muestra)
                    autocorrect: false,
                    enableSuggestions: false,
                    autofillHints: const [AutofillHints.password],

                    decoration: InputDecoration(
                      labelText: "Contraseña",
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(
                        Icons.lock_outlined, //ícono ANTES de que se envíe petición
                      ),
                      
                      //botón dentro del input para mostrar/ocultar la contraseña
                      suffixIcon: IconButton(
                        onPressed: () => setState(() => _obscure = !_obscure),
                        icon: Icon(
                          _obscure ? Icons.visibility : Icons.visibility_off,
                        ), //esto es un IF-ELSE
                        tooltip: _obscure
                            ? "Mostrar"
                            : "Ocultar", //cambia el estado de la contraseña (mostrar/ocultar)
                      ),
                    ),

                    //validación de la contraseña (mínimo 6 caracteres)
                    validator: (validadorContrasena) {
                      if (validadorContrasena == null || validadorContrasena.isEmpty) return "Ingrese su contraseña";
                      if (validadorContrasena.length < 6) return "La contraseña debe contener mínimo 6 caracteres";
                      return null; //si la contraseña es correcta, return null (oka)
                    },

                    textInputAction: TextInputAction.done, //indica que es el último campo
                    onFieldSubmitted: (_) => _submit(), //envía el formulario al presionar "enter"
                  ),

                  const SizedBox(height: 16),

                  if (_error != null) //muestra el mensaje de error al llenar mal el formulario
                    Text(
                      _error!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),

                  const SizedBox(height: 16),

                  //------ BOTON INGRESAR-------
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF009B77),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: _loading ? null : _submit, //deshabilita el botón si está cargando
                      child: _loading
                      // muestra una rueda de carga si está procesando, sino muestra el texto "Ingresar"
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : const Text("Ingresar"),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: _loading ? null : () {},
                    child: const Text("¿Olvidaste tu contraseña?"),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}

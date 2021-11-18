import 'package:flutter/material.dart';

// Importaciones locales
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/logo.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/boton_azul.dart';
import 'package:chat/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:chat/helpers/mostrar_alerta.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.95,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo( titulo: 'Registro', ),
                _Form(),
                Labels(
                  ruta: 'login',
                  mensaje: '¿Ya tienes cuenta?',
                  accion: 'Ingresar con mi cuenta',
                  pushOrPop: 'pop',
                ),
                Padding(
                  padding: const EdgeInsets.only( bottom: 10 ),
                  child: Text( 'Términos y condiciones de uso', style: TextStyle( fontWeight: FontWeight.w300 ), ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: EdgeInsets.only( top: 40.0 ),
      padding: EdgeInsets.symmetric( horizontal: 50.0 ),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.person,
            placeholder: 'Nombre',
            keboardType: TextInputType.text,
            textController: nameCtrl,
          ),
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),
          SizedBox( height: 10.0, ),
          botonAzul(
            text: 'Registrar',
            onPressed: authService.autenticando ? null : () async {

              FocusScope.of(context).unfocus(); // Cerramos el teclado

              final registerOK = await authService.register( nameCtrl.text.trim(), emailCtrl.text.trim(), passCtrl.text.trim() );
              
              if( registerOK == 'register ok' ) {

                mostrarAlerta(
                  context,
                  'Registro Exitoso!',
                  'El usuario ${nameCtrl.text.trim()} se registró correctamente',
                  'usuarios',
                );
              } else {

                mostrarAlerta(
                  context,
                  'Error en el Registro!',
                  registerOK
                );
              }
            },
          ),
          
        ],
      ),
    );

}
  }
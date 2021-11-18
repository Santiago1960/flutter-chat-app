
import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Importaciones locales
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/logo.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/boton_azul.dart';
import 'package:chat/services/auth_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({ Key? key }) : super(key: key);

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
                Logo( titulo: 'AYLLIPURA', ),
                _Form(),
                Labels(
                  ruta: 'register',
                  mensaje: '¿No tienes cuenta?',
                  accion:  'Crea una ahora!',
                  pushOrPop: 'push',
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
            text: 'Ingresar',
            onPressed: authService.autenticando ? null : () async {

              FocusScope.of(context).unfocus(); // Cerramos el teclado
              
              final loginOK = await authService.login( emailCtrl.text.trim(), passCtrl.text.trim() );

              print('El login es ${loginOK}');

              if(loginOK == 'login ok') {

                // !Conectar a socket service
                Navigator.pushReplacementNamed(context, 'usuarios' );
              } else {

                if ( loginOK == 'login error' ) {

                  mostrarAlerta(
                    context,
                    'Error en los datos!',
                    'Revisa tus credenciales'
                  );
                } else {

                  mostrarAlerta(
                    context,
                    'Error!',
                    'No se pudo establecer conexión con el servidor.\n\nRevisa tu conexión a Internet e intenta nuevamente.'
                  );
                }
              }
            },
          ),
          
        ],
      ),
    );
  }

}
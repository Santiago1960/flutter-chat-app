import 'package:chat/pages/usuarios_page.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Text( 'Por favor espere...' ),
          );
        },
      ),
    );
  }

  Future checkLoginState( BuildContext context ) async {

    final authService = Provider.of<AuthService>( context, listen: false );
    final autenticado = await authService.isLoggedIn();

    if ( autenticado == 'login ok' ) {

      // !CONEXTAR AL SOCKET SERVER
      // Navigator.pushReplacementNamed( context, 'usuarios' ); //La transición es brusca
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: ( _, __, ___ ) => UsuariosPage(),
          transitionDuration: Duration( milliseconds: 0 ),
        )
      );
    } else {

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: ( _, __, ___ ) => LoginPage(),
          transitionDuration: Duration( milliseconds: 0 ),
        )
      );
    }
  }
}
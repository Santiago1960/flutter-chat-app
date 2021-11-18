import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// Importaciones
import 'package:chat/models/usuario.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({ Key? key }) : super(key: key);

  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario( uid: '1', nombre: 'María', email: 'maria@gmail.com', online: true ),
    Usuario( uid: '1', nombre: 'Lorena', email: 'lorena@gmail.com', online: true ),
    Usuario( uid: '1', nombre: 'Joaquín', email: 'joaquin@gmail.com', online: false ),
  ];

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text( usuario.nombre, style: TextStyle( color: Colors.black54 ), ),
        elevation: 3.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon( Icons.exit_to_app, color: Colors.black54, ),
          onPressed: () {

            // !DESCONECTARNOS DEL SOCKET SERVER
            Navigator.pushReplacementNamed( context, 'login' );
            AuthService.deleteToken();
          },
        ),
        actions: [
          Container(
            margin: EdgeInsets.only( right: 10.0 ),
            child: Icon( Icons.check_circle, color: Colors.blue[400], ),
            // child: Icon( Icons.offline_bolt, color: Colors.red[400], ),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          waterDropColor: Colors.blue,
          complete: Icon( Icons.check, color: Colors.blue[400], ),
        ),
        child: _listViewUsuarios(),
      )
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: ( _, i ) => _usuarioListTile( usuarios[i] ),
      separatorBuilder: ( _, i ) => Divider(),
      itemCount: usuarios.length,
    );
  }

  ListTile _usuarioListTile( Usuario usuario ) {
    return ListTile(
        title: Text( usuario.nombre ),
        subtitle: Text( usuario.email ),
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text( usuario.nombre.substring( 0, 2 ) ),
        ),
        trailing: Container(
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(
            color: usuario.online ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular( 50.0 )
          ),
        ),
      );
  }

  Future<void> _cargarUsuarios() async {

    await Future.delayed( Duration( milliseconds: 1000 ) );

    _refreshController.refreshCompleted();
  }
}
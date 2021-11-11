import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  const Labels({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text( '¿No tienes cuenta?', style: TextStyle( color: Colors.black54, fontSize: 15.0, fontWeight: FontWeight.w300 ), ),
          SizedBox( height: 10.0, ),
          Text( 'Crea una ahora!', style: TextStyle( color: Colors.blue[600], fontSize: 18.0, fontWeight: FontWeight.bold ), ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {

  final String titulo;

  const Logo({
    Key? key,
    required this.titulo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of( context).size.width,
        margin: EdgeInsets.only( top: 30.0 ),
        child: Column(
          children: [
            Container(
              width: 170.0,
              child: Image(image: AssetImage( 'assets/tag-logo.png' ))
            ),
            SizedBox( height: 20.0, ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text( this.titulo, style: TextStyle( fontSize: 30.0 ), ),
            ],
            )
          ],
        ),
      ),
    );
  }
}
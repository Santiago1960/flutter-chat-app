import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

mostrarAlerta( BuildContext context, String titulo, String subtitulo, [String navegar = ''] ) {

  if( Platform.isAndroid ) {

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: ( _ ) => AlertDialog(
        title: Text( titulo ),
        content: Text( subtitulo ),
        actions: [
          MaterialButton(
            child: Text( 'Ok' ),
            elevation: 5.0,
            textColor: Colors.blue,
            onPressed: () => navegar == '' ? Navigator.pop(context) : Navigator.pushReplacementNamed(context, navegar),
          )
        ],
      )
    );
  }

  showCupertinoDialog(
    context: context,
    builder: ( _ ) => CupertinoAlertDialog(
      title: Text( titulo ),
      content: Text( subtitulo ),
      actions: [
        CupertinoDialogAction(
          child: Text( 'Ok' ),
          onPressed: () => navegar == '' ? Navigator.pop(context) : Navigator.pushReplacementNamed(context, navegar),
        )
      ],
    )
  );

}
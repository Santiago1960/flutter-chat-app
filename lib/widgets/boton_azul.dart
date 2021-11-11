import 'package:flutter/material.dart';

class botonAzul extends StatelessWidget {
  
  final String text;
  final onPressed;

  const botonAzul({
    Key? key,
    required this.text,
    required this.onPressed}
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(5.0),
        shape: MaterialStateProperty.all( StadiumBorder() ),
      ),
      onPressed: this.onPressed,
      child: Container(
        width: double.infinity,
        height: 55.0,
        child: Center(
          child: Text( this.text, style: TextStyle( fontSize: 18.0 ), ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  
  const CustomInput({ Key? key,
                      required this.icon,
                      required this.placeholder,
                      required this.textController,
                      this.keboardType = TextInputType.text,
                      this.isPassword = false }) : super(key: key);

  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keboardType;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only( top: 5, left: 15, bottom: 5, right: 20 ),
      margin: EdgeInsets.only( bottom: 10, ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular( 30.0 ),
        boxShadow: <BoxShadow> [
          BoxShadow(
            color: Colors.black.withOpacity( 0.05 ),
            offset: Offset( 0, 5 ),
            blurRadius: 5,
          )
          ,
        ]
      ),
      child: TextField(
        controller: this.textController,
        autocorrect: false,
        keyboardType: this.keboardType,
        obscureText: this.isPassword,
        decoration: InputDecoration(
          icon: Icon( this.icon, ),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: this.placeholder,
        ),
      ),
    );
  }
}
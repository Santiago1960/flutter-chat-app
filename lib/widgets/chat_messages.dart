import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  
  final String texto;
  final String uid;
  final AnimationController animationController;

  const ChatMessage({
    Key? key,
    required this.texto,
    required this.uid,
    required this.animationController,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: animationController,
          curve: Curves.easeOut,
        ),
        child: Container(
          child: this.uid == '123'
            ? _myMessage()
            : _notMyMessage(),
        ),
      ),
    );
  }

  _myMessage() {

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all( 15.0 ),
        margin: EdgeInsets.only(
          bottom: 5.0,
          right: 5.0,
          left: 80.0
        ),
        child: Text( this.texto, style: TextStyle(color: Colors.white, ), ),
        decoration: BoxDecoration(
          color: Color( 0xff4D9EF6 ),
          borderRadius: BorderRadius.circular( 20.0 ),
        ),
      ),
    );
  }

  _notMyMessage() {

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all( 15.0 ),
        margin: EdgeInsets.only(
          bottom: 5.0,
          right: 80.0,
          left: 5.0
        ),
        child: Text( this.texto, style: TextStyle(color: Colors.black87 ), ),
        decoration: BoxDecoration(
          color: Color( 0xffE4E5E8 ),
          borderRadius: BorderRadius.circular( 20.0 )
        ),
      ),
    );
  }
}
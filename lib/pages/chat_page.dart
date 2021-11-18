import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:chat/widgets/chat_messages.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({ Key? key }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {

  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _escribiendo = false;
  List<ChatMessage> _messages = [
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1.0,
        title: Column(
          children: [
            CircleAvatar(
              child: Text( 'Te' ),
              backgroundColor: Colors.blue[100],
              maxRadius: 14.0,
            ),
            SizedBox( height: 3.0, ),
            Text( 'Test de usuario', style: TextStyle( color: Colors.black87, fontSize: 12.0 ), )
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: ( _, i ) => _messages[i],
                reverse: true,
              )
            ),
            Divider( height: 1.0, ),
            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {

    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric( horizontal: 8.0 ),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: ( String texto ) {
                  setState(() {
                    
                    texto.trim().length > 0 ? _escribiendo = true : _escribiendo = false;
                  });
                },
                decoration: const InputDecoration.collapsed(
                  hintText: 'Enviar mensaje',
                ),
                focusNode: _focusNode,
              ),
            ),
            // Botón de enviar
            Container(
              margin: EdgeInsets.symmetric( horizontal: 4.0 ),
              child: Platform.isIOS ? 
                CupertinoButton(
                  child: Text( 'Enviar' ),
                  onPressed: _escribiendo 
                    ? () => _handleSubmit( _textController.text.trim() )
                    : null,
                ) :
                Container(
                  margin: EdgeInsets.symmetric( horizontal: 4.0 ),
                  child: IconTheme(
                    data: IconThemeData( color: Colors.blue ),
                    child: IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: Icon( Icons.send, ),
                      onPressed: _escribiendo 
                        ? () => _handleSubmit( _textController.text.trim() )
                        : null,
                    ),
                  ),
                ),
            )
          ],
        ),
      ),
    );
  }



  _handleSubmit(String texto) {

    if( texto.length == 0 ) return;

    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      uid: '123',
      texto: texto,
      animationController: AnimationController( vsync: this, duration: Duration( milliseconds: 500 ) ),
    );
    _messages.insert( 0, newMessage );
    newMessage.animationController.forward();

    setState(() {
      
      _escribiendo = false;
    });
  }

  @override
  void dispose() {
    // !OFF DEL SOCKET

    // Limpiar cada una de las instancias
    for( ChatMessage message in _messages ) {

      message.animationController.dispose();
    }
    super.dispose();
  }

}
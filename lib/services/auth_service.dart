import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat/global/enviroment.dart';
import 'package:chat/models/login_response.dart';
import 'package:chat/models/usuario.dart';

class AuthService with ChangeNotifier {

  late Usuario usuario;
  bool _autenticando = false;
  bool _registrando = false;

  // Create storage
  final _storage = new FlutterSecureStorage();

  bool get autenticando => this._autenticando; // getter
  set autenticando(bool valor) { // setter
    this._autenticando = valor;
    notifyListeners();
  }

  bool get registrando => this._registrando; // getter
  set registrando(bool valor) { // setter
    this._autenticando = valor;
    notifyListeners();
  }

  // Getters del token de forma estática
  static Future getToken() async {

    final _storage = new FlutterSecureStorage();
    final token = await _storage.read( key: 'token' );
    return token;
  }

  static Future deleteToken() async {

    final _storage = new FlutterSecureStorage();
    await _storage.delete( key: 'token' );
  }

  Future login( String email, String password ) async {

    this.autenticando = true;

    final data = {
      'email': email,
      'password': password
    };

    var url = Uri.parse('${Enviroment.apiUrl}/login');

    try {

      final resp = await http.post(url,
        body: jsonEncode(data),
        headers: {
          'content-Type': 'application/json'
        }
      );

      this.autenticando = false;
      if(resp.statusCode == 200) {

        final loginResponse = loginResponseFromJson(resp.body);
        this.usuario = loginResponse.usuario;

        // Guardamos el TOKEN en la memoria del dispositiov
        await _guardarToken(loginResponse.token);

        return 'login ok';
      } else {

        return 'login error';
      }
    } on Exception catch (error) {

      this.autenticando = false;

      return 'conexion error';
    }
  }

  Future register( String nombre, String email, String password ) async {

    this.registrando = true;

    final data = {
      'nombre': nombre,
      'email': email,
      'password': password
    };

    var url = Uri.parse('${Enviroment.apiUrl}/login/new');

    final resp = await http.post(url,
      body: jsonEncode(data),
      headers: {
        'content-Type': 'application/json'
      }
    );

    this.registrando = false;

    if(resp.statusCode == 200) {

        final loginResponse = loginResponseFromJson(resp.body);
        this.usuario = loginResponse.usuario;

        // Guardamos el TOKEN en la memoria del dispositiov
        await _guardarToken(loginResponse.token);

        return 'register ok';
      } else {

        final respBody = jsonDecode(resp.body);
        return respBody['msg'];
      }
  }

  Future isLoggedIn()  async {

    final token = await this._storage.read( key: 'token' );

    var url = Uri.parse('${Enviroment.apiUrl}/login/renew');

    try {

      final resp = await http.get(url,
        headers: {
          'content-Type': 'application/json',
          'x-token': token.toString(),
        }
      );

      if(resp.statusCode == 200) {

        final loginResponse = loginResponseFromJson(resp.body);
        this.usuario = loginResponse.usuario;

        // Guardamos el TOKEN en la memoria del dispositiov
        await _guardarToken(loginResponse.token);

        return 'login ok';
      } else {

        this.logout();

        return 'login error';
      }
    } on Exception catch (error) {
      return 'conexion error';
    }
  }

  Future _guardarToken( String token ) async {

    return await _storage.write( key: 'token', value: token );
  }

  Future logout() async {

    await _storage.delete( key: 'token' );
  }
}
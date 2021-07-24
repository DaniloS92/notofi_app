import 'dart:convert';
import 'package:chat/models/login_response.dart';
import 'package:chat/models/usuario.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat/global/enviroment.dart';

class AuthService with ChangeNotifier {
  Usuario usuario;
  bool _autenticando = false;

  // Create storage
  final _storage = new FlutterSecureStorage();

  bool get autenticando => this._autenticando;

  set autenticando(bool value) {
    this._autenticando = value;
    notifyListeners();
  }

  // Getter del token de forma statica
  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String pass) async {
    this.autenticando = true;

    final data = {'email': email, 'password': pass, 'gettoken': true};

    Uri uri = Uri.parse('${Enviroment.apiUrl}/api/login');

    final resp = await http.post(uri,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    print(resp.body);
    this.autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);
      await this._guardarIdUsuario(usuario.id);
      return true;
    } else {
      return false;
    }
  }

  Future register(String nombre, String email, String pass, String apellido,
      String phone) async {
    this.autenticando = true;

    final data = {
      'name': nombre,
      'email': email,
      'password': pass,
      'lastname': apellido,
      'role': 'cliente',
      'phone': phone
    };

    Uri uri = Uri.parse('${Enviroment.apiUrl}/api/register');

    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    this.autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      // await this._guardarToken(loginResponse.token);
      await this.login(email, pass);
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future updateUser(String nombre, String email, String pass, String apellido,
      String phone) async {
    this.autenticando = true;

    final data = {
      'name': nombre,
      'email': email,
      'password': pass,
      'lastname': apellido,
      'phone': phone
    };

    final idUser = await this._storage.read(key: 'usuario_id');
    final token = await this._storage.read(key: 'token');

    final headers = {
      'Authorization': token,
      'Content-Type': 'application/json',
    };

    Uri uri = Uri.parse('${Enviroment.apiUrl}/api/update-user/$idUser');

    final resp = await http.put(
      uri,
      body: jsonEncode(data),
      headers: headers,
    );

    this.autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      // await this._guardarToken(loginResponse.token);
      // await this.login(email, pass);
      notifyListeners();
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: 'token');

    Uri uri = Uri.parse('${Enviroment.apiUrl}/login/renew');

    final resp = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'x-token': token,
      },
    );

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);
      return true;
    } else {
      this.logout();
      return false;
    }
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future _guardarIdUsuario(String id) async {
    return await _storage.write(key: 'usuario_id', value: id);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
    await _storage.delete(key: 'usuario_id');
  }
}

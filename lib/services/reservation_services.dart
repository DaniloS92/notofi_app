import 'dart:convert';
import 'package:chat/models/usuario.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat/global/enviroment.dart';

class ReservationService with ChangeNotifier {
  Usuario usuario;
  bool _autenticando = false;

  // Create storage
  final _storage = new FlutterSecureStorage();

  bool get autenticando => this._autenticando;

  set autenticando(bool value) {
    this._autenticando = value;
    notifyListeners();
  }

  Future updateUser(String idService) async {
    this.autenticando = true;

    final data = {
      'idService': idService,
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
      // Aqui mandamos a actualizar la lista de reservaciones
      notifyListeners();
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }
}

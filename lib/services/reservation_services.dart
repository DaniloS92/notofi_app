import 'dart:convert';
import 'package:chat/models/reservation.dart';
import 'package:chat/models/usuario.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat/global/enviroment.dart';

class ReservationService with ChangeNotifier {
  Usuario usuario;

  // Create storage
  final _storage = new FlutterSecureStorage();

  List<Reservation> arrayReservation = [];

  Future<List<Reservation>> getAllReservation(BuildContext context) async {
    final token = await this._storage.read(key: 'token');
    final idUser = await this._storage.read(key: 'usuario_id');

    if (arrayReservation.length > 0) {
      return arrayReservation;
    }

    final headers = {
      'Authorization': token,
      'Content-Type': 'application/json',
    };

    Uri uri = Uri.parse('${Enviroment.apiUrl}/api/get-reservations/$idUser');

    final resp = await http.get(uri, headers: headers);

    if (resp.statusCode == 200) {
      final services = json.decode(resp.body)['Reservations'];

      for (final line in services) {
        arrayReservation.add(Reservation.fromJson(line));
      }
    }
    return arrayReservation;
  }

  Future saveReservation(idReservation, date, hour) async {
    final token = await this._storage.read(key: 'token');
    final idUser = await this._storage.read(key: 'usuario_id');

    final data = {
      'date': date,
      'hour': hour,
      'service_id': idReservation,
      'user_id': idUser,
    };

    final headers = {
      'Authorization': token,
      'Content-Type': 'application/json',
    };

    Uri uri = Uri.parse('${Enviroment.apiUrl}/api/register-reservation');

    final resp = await http.post(uri, body: jsonEncode(data), headers: headers);

    if (resp.statusCode == 200) {
      //Aqui actualizar array de citas medicas
      return {'res': true, 'msg': resp.body};
    } else {
      return {'res': false, 'msg': resp.body};
    }
  }
}

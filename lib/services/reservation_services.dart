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

  final List<Reservation> arrayReservation = [];

  Future<List<Reservation>> getAllReservation() async {
    final token = await this._storage.read(key: 'token');
    final idUser = await this._storage.read(key: 'usuario_id');

    if (arrayReservation.length > 0) {
      return arrayReservation;
    }

    final headers = {
      'Authorization': token,
      'Content-Type': 'application/json',
    };

    Uri uri = Uri.parse('${Enviroment.apiUrl}/api/get-reservations');

    final resp = await http.get(uri, headers: headers);

    if (resp.statusCode == 200) {
      final services = json.decode(resp.body)['Reservations'];

      for (final line in services) {
        arrayReservation.add(Reservation.fromJson(line));
      }
    }
    return arrayReservation;
  }
}

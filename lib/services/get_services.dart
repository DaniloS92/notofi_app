import 'dart:convert';
import 'package:chat/models/service.dart';
import 'package:chat/models/usuario.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat/global/enviroment.dart';

class GetServices with ChangeNotifier {
  Usuario usuario;
  bool _loadServicesData = false;

  // Create storage
  final _storage = new FlutterSecureStorage();

  // bool get loadServicesData => this._loadServicesData;

  // set loadServicesData(bool value) {
  //   this._loadServicesData = value;
  //   notifyListeners();
  // }

  Future<List<Service>> getAllServices() async {
    // this.loadServicesData = true;

    final token = await this._storage.read(key: 'token');

    final headers = {
      'Authorization': token,
      'Content-Type': 'application/json',
    };

    Uri uri = Uri.parse('${Enviroment.apiUrl}/api/get-services');

    final resp = await http.get(uri, headers: headers);

    print(resp.body);
    final List<Service> arrayServices = [];
    // this.loadServicesData = false;
    if (resp.statusCode == 200) {
      final services = json.decode(resp.body)['services'];

      for (final line in services) {
        arrayServices.add(Service.fromJson(line));
      }
    }
    return arrayServices;
  }
}

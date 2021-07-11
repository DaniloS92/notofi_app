// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
    this.id,
    this.name,
    this.lastname,
    this.username,
    this.email,
    this.phone,
    this.role,
    this.image,
    this.active,
  });

  String id;
  String name;
  String lastname;
  dynamic username;
  String email;
  String phone;
  String role;
  dynamic image;
  bool active;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["_id"],
        name: json["name"],
        lastname: json["lastname"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        role: json["role"],
        image: json["image"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "lastname": lastname,
        "username": username,
        "email": email,
        "phone": phone,
        "role": role,
        "image": image,
        "active": active,
      };
}

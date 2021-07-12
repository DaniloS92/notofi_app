// To parse this JSON data, do
//
//     final service = serviceFromJson(jsonString);

import 'dart:convert';

Service serviceFromJson(String str) => Service.fromJson(json.decode(str));

String serviceToJson(Service data) => json.encode(data.toJson());

class Service {
  Service({
    this.id,
    this.name,
    this.description,
    this.active,
    this.price,
  });

  String id;
  String name;
  String description;
  bool active;
  String price;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        active: json["active"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "active": active,
        "price": price,
      };
}

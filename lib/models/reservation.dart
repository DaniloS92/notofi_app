// To parse this JSON data, do
//
//     final reservation = reservationFromJson(jsonString);

import 'dart:convert';

import 'package:chat/models/service.dart';

Reservation reservationFromJson(String str) =>
    Reservation.fromJson(json.decode(str));

String reservationToJson(Reservation data) => json.encode(data.toJson());

class Reservation {
  Reservation({
    this.service,
    this.hour,
    this.date,
    this.reservationId,
  });

  Service service;
  String hour;
  DateTime date;
  String reservationId;

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
        service: Service.fromJson(json["service"]),
        hour: json["hour"],
        date: DateTime.parse(json["date"]),
        reservationId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "service": service,
        "hour": hour,
        "date": date.toIso8601String(),
        "id": reservationId,
      };
}

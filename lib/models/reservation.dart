import 'dart:convert';

Reservation serviceFromJson(String str) =>
    Reservation.fromJson(json.decode(str));

String serviceToJson(Reservation data) => json.encode(data.toJson());

class Reservation {
  Reservation({
    this.id,
    this.hour,
    this.seviceId,
    this.userId,
  });

  String id;
  String hour;
  String seviceId;
  String userId;

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
        id: json["_id"],
        hour: json["hour"],
        seviceId: json["seviceId"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "hour": hour,
        "seviceId": seviceId,
        "userId": userId,
      };
}

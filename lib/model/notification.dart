// To parse this JSON data, do
//
//     final notificationResponse = notificationResponseFromJson(jsonString);

import 'dart:convert';

NotificationResponse notificationResponseFromJson(String str) =>
    NotificationResponse.fromJson(json.decode(str));

String notificationResponseToJson(NotificationResponse data) =>
    json.encode(data.toJson());

class NotificationResponse {
  NotificationResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  int? statusCode;
  String? message;
  List<Notifications>? data;

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      NotificationResponse(
        statusCode: json["statusCode"],
        message: json["message"],
        data: List<Notifications>.from(
            json["data"].map((x) => Notifications.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Notifications {
  Notifications({
    this.id,
    this.dateCreate,
    this.description,
    this.type,
    this.status,
  });

  int? id;
  DateTime? dateCreate;
  String? description;
  String? type;
  String? status;

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        id: json["id"],
        dateCreate: DateTime.parse(json["dateCreate"]),
        description: json["description"],
        type: json["type"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dateCreate":
            "${dateCreate!.year.toString().padLeft(4, '0')}-${dateCreate!.month.toString().padLeft(2, '0')}-${dateCreate!.day.toString().padLeft(2, '0')}",
        "description": description,
        "type": type,
        "status": status,
      };
}

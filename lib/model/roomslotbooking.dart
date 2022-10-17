// To parse this JSON data, do
//
//     final roomSlotBookingResponse = roomSlotBookingResponseFromJson(jsonString);

import 'dart:convert';

RoomSlotBookingResponse roomSlotBookingResponseFromJson(String str) =>
    RoomSlotBookingResponse.fromJson(json.decode(str));

String roomSlotBookingResponseToJson(RoomSlotBookingResponse data) =>
    json.encode(data.toJson());

class RoomSlotBookingResponse {
  RoomSlotBookingResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  int? statusCode;
  String? message;
  List<RoomSlotBooking>? data;

  factory RoomSlotBookingResponse.fromJson(Map<String, dynamic> json) =>
      RoomSlotBookingResponse(
        statusCode: json["statusCode"],
        message: json["message"],
        data: List<RoomSlotBooking>.from(
            json["data"].map((x) => RoomSlotBooking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class RoomSlotBooking {
  RoomSlotBooking({
    this.id,
    this.chanelName,
    this.token,
  });

  int? id;
  String? chanelName;
  String? token;

  factory RoomSlotBooking.fromJson(Map<String, dynamic> json) =>
      RoomSlotBooking(
        id: json["id"],
        chanelName: json["chanelName"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chanelName": chanelName,
        "token": token,
      };
}

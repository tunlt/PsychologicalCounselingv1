// To parse this JSON data, do
//
//     final appointmentResponse = appointmentResponseFromJson(jsonString);

import 'dart:convert';

AppointmentResponse appointmentResponseFromJson(String str) =>
    AppointmentResponse.fromJson(json.decode(str));

String appointmentResponseToJson(AppointmentResponse data) =>
    json.encode(data.toJson());

class AppointmentResponse {
  AppointmentResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  int? statusCode;
  String? message;
  List<Appointment>? data;

  factory AppointmentResponse.fromJson(Map<String, dynamic> json) =>
      AppointmentResponse(
        statusCode: json["statusCode"],
        message: json["message"],
        data: List<Appointment>.from(
            json["data"].map((x) => Appointment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Appointment {
  Appointment({
    this.id,
    this.timeStart,
    this.timeEnd,
    this.price,
    this.dateSlot,
    this.imageUrl,
    this.customerName,
    this.status,
    this.consultantId,
    this.bookingId,
  });

  int? id;
  String? timeStart;
  String? timeEnd;
  int? price;
  DateTime? dateSlot;
  String? imageUrl;
  String? customerName;
  String? status;
  int? consultantId;
  int? bookingId;

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        id: json["id"],
        timeStart: json["timeStart"],
        timeEnd: json["timeEnd"],
        price: json["price"],
        dateSlot: DateTime.parse(json["dateSlot"]),
        imageUrl: json["imageUrl"],
        customerName: json["customerName"],
        status: json["status"],
        consultantId: json["consultantId"],
        bookingId: json["bookingId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "timeStart": timeStart,
        "timeEnd": timeEnd,
        "price": price,
        "dateSlot":
            "${dateSlot!.year.toString().padLeft(4, '0')}-${dateSlot!.month.toString().padLeft(2, '0')}-${dateSlot!.day.toString().padLeft(2, '0')}",
        "imageUrl": imageUrl,
        "customerName": customerName,
        "status": status,
        "consultantId": consultantId,
        "bookingId": bookingId,
      };
}

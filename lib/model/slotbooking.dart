// To parse this JSON data, do
//
//     final slotBookingReponse = slotBookingReponseFromJson(jsonString);

import 'dart:convert';

SlotBookingReponse slotBookingFromJson(String str) =>
    SlotBookingReponse.fromJson(json.decode(str));

String slotBookingToJson(SlotBookingReponse data) => json.encode(data.toJson());

class SlotBookingReponse {
  SlotBookingReponse({
    this.statusCode,
    this.message,
    this.data,
  });

  int? statusCode;
  String? message;
  List<SlotBooking>? data;

  factory SlotBookingReponse.fromJson(Map<String, dynamic> json) =>
      SlotBookingReponse(
        statusCode: json["statusCode"],
        message: json["message"],
        data: List<SlotBooking>.from(
            json["data"].map((x) => SlotBooking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SlotBooking {
  SlotBooking({
    this.id,
    this.timeStart,
    this.timeEnd,
    this.price,
    this.dateSlot,
    this.status,
    this.consultantId,
    this.bookingId,
  });

  int? id;
  String? timeStart;
  String? timeEnd;
  dynamic? price;
  DateTime? dateSlot;
  String? status;
  int? consultantId;
  dynamic? bookingId;

  factory SlotBooking.fromJson(Map<String, dynamic> json) => SlotBooking(
        id: json["id"],
        timeStart: json["timeStart"],
        timeEnd: json["timeEnd"],
        price: json["price"],
        dateSlot: DateTime.parse(json["dateSlot"]),
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
        "status": status,
        "consultantId": consultantId,
        "bookingId": bookingId,
      };
}

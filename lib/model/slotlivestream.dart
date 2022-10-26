// To parse this JSON data, do
//
//     final slotLiveResponse = slotLiveResponseFromJson(jsonString);

import 'dart:convert';

SlotLiveResponse slotLiveResponseFromJson(String str) =>
    SlotLiveResponse.fromJson(json.decode(str));

String slotLiveResponseToJson(SlotLiveResponse data) =>
    json.encode(data.toJson());

class SlotLiveResponse {
  SlotLiveResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  int? statusCode;
  String? message;
  List<SlotLive>? data;

  factory SlotLiveResponse.fromJson(Map<String, dynamic> json) =>
      SlotLiveResponse(
        statusCode: json["statusCode"],
        message: json["message"],
        data:
            List<SlotLive>.from(json["data"].map((x) => SlotLive.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SlotLive {
  SlotLive({
    this.id,
    this.timeStart,
    this.timeEnd,
    this.price,
    this.dateSlot,
    this.description,
    this.consultantName,
    this.imageUrl,
    this.status,
    this.consultantId,
    this.bookingId,
  });

  int? id;
  String? timeStart;
  String? timeEnd;
  int? price;
  DateTime? dateSlot;
  String? description;
  String? consultantName;
  String? imageUrl;
  String? status;
  int? consultantId;
  dynamic bookingId;

  factory SlotLive.fromJson(Map<String, dynamic> json) => SlotLive(
        id: json["id"],
        timeStart: json["timeStart"],
        timeEnd: json["timeEnd"],
        price: json["price"],
        dateSlot: DateTime.parse(json["dateSlot"]),
        description: json["description"],
        consultantName: json["consultantName"],
        imageUrl: json["imageUrl"],
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
        "description": description,
        "consultantName": consultantName,
        "imageUrl": imageUrl,
        "status": status,
        "consultantId": consultantId,
        "bookingId": bookingId,
      };
}

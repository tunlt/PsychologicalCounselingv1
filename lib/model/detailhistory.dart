// To parse this JSON data, do
//
//     final detailHistoryResponse = detailHistoryResponseFromJson(jsonString);

import 'dart:convert';

DetailHistoryResponse detailHistoryResponseFromJson(String str) =>
    DetailHistoryResponse.fromJson(json.decode(str));

String detailHistoryResponseToJson(DetailHistoryResponse data) =>
    json.encode(data.toJson());

class DetailHistoryResponse {
  DetailHistoryResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  int? statusCode;
  String? message;
  List<DetailHistory>? data;

  factory DetailHistoryResponse.fromJson(Map<String, dynamic> json) =>
      DetailHistoryResponse(
        statusCode: json["statusCode"],
        message: json["message"],
        data: List<DetailHistory>.from(
            json["data"].map((x) => DetailHistory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DetailHistory {
  DetailHistory({
    this.id,
    this.timeStart,
    this.timeEnd,
    this.date,
    this.rate,
    this.feedback,
    this.price,
    this.imageUrlCustomer,
    this.customerName,
    this.reasonCustomer,
    this.reasonConsultant,
    this.status,
  });

  int? id;
  String? timeStart;
  String? timeEnd;
  DateTime? date;
  dynamic rate;
  dynamic feedback;
  int? price;
  String? imageUrlCustomer;
  String? customerName;
  dynamic reasonCustomer;
  dynamic reasonConsultant;
  String? status;

  factory DetailHistory.fromJson(Map<String, dynamic> json) => DetailHistory(
        id: json["id"],
        timeStart: json["timeStart"],
        timeEnd: json["timeEnd"],
        date: DateTime.parse(json["date"]),
        rate: json["rate"],
        feedback: json["feedback"],
        price: json["price"],
        imageUrlCustomer: json["imageUrlCustomer"],
        customerName: json["customerName"],
        reasonCustomer: json["reasonCustomer"],
        reasonConsultant: json["reasonConsultant"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "timeStart": timeStart,
        "timeEnd": timeEnd,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "rate": rate,
        "feedback": feedback,
        "price": price,
        "imageUrlCustomer": imageUrlCustomer,
        "customerName": customerName,
        "reasonCustomer": reasonCustomer,
        "reasonConsultant": reasonConsultant,
        "status": status,
      };
}

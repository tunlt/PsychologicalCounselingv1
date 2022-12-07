// To parse this JSON data, do
//
//     final detailBookingResponse = detailBookingResponseFromJson(jsonString);

import 'dart:convert';

DetailBookingResponse detailBookingResponseFromJson(String str) =>
    DetailBookingResponse.fromJson(json.decode(str));

String detailBookingResponseToJson(DetailBookingResponse data) =>
    json.encode(data.toJson());

class DetailBookingResponse {
  DetailBookingResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  int? statusCode;
  String? message;
  List<DetailBooking>? data;

  factory DetailBookingResponse.fromJson(Map<String, dynamic> json) =>
      DetailBookingResponse(
        statusCode: json["statusCode"],
        message: json["message"],
        data: List<DetailBooking>.from(
            json["data"].map((x) => DetailBooking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DetailBooking {
  DetailBooking({
    this.slotId,
    this.customerName,
    this.urlImageCustomer,
    this.price,
    this.timeStart,
    this.timeEnd,
    this.dateOfSlot,
    this.resultSurvey,
    this.discChart,
    this.urlBirthChart,
  });

  int? slotId;
  String? customerName;
  String? urlImageCustomer;
  int? price;
  String? timeStart;
  String? timeEnd;
  DateTime? dateOfSlot;
  String? resultSurvey;
  String? discChart;
  String? urlBirthChart;

  factory DetailBooking.fromJson(Map<String, dynamic> json) => DetailBooking(
        slotId: json["slotId"],
        customerName: json["customerName"],
        urlImageCustomer: json["urlImageCustomer"],
        price: json["price"],
        timeStart: json["timeStart"],
        timeEnd: json["timeEnd"],
        dateOfSlot: DateTime.parse(json["dateOfSlot"]),
        resultSurvey: json["resultSurvey"],
        discChart: json["discChart"],
        urlBirthChart: json["urlBirthChart"],
      );

  Map<String, dynamic> toJson() => {
        "slotId": slotId,
        "customerName": customerName,
        "urlImageCustomer": urlImageCustomer,
        "price": price,
        "timeStart": timeStart,
        "timeEnd": timeEnd,
        "dateOfSlot":
            "${dateOfSlot!.year.toString().padLeft(4, '0')}-${dateOfSlot!.month.toString().padLeft(2, '0')}-${dateOfSlot!.day.toString().padLeft(2, '0')}",
        "resultSurvey": resultSurvey,
        "discChart": discChart,
        "urlBirthChart": urlBirthChart,
      };
}



// // To parse this JSON data, do
// //
// //     final detailBookingResponse = detailBookingResponseFromJson(jsonString);

// import 'dart:convert';

// DetailBookingResponse detailBookingResponseFromJson(String str) =>
//     DetailBookingResponse.fromJson(json.decode(str));

// String detailBookingResponseToJson(DetailBookingResponse data) =>
//     json.encode(data.toJson());

// class DetailBookingResponse {
//   DetailBookingResponse({
//     this.statusCode,
//     this.message,
//     this.data,
//   });

//   int? statusCode;
//   String? message;
//   List<DetailBooking>? data;

//   factory DetailBookingResponse.fromJson(Map<String, dynamic> json) =>
//       DetailBookingResponse(
//         statusCode: json["statusCode"],
//         message: json["message"],
//         data: List<DetailBooking>.from(
//             json["data"].map((x) => DetailBooking.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "statusCode": statusCode,
//         "message": message,
//         "data": List<dynamic>.from(data!.map((x) => x.toJson())),
//       };
// }

// class DetailBooking {
  
//   DetailBooking({
//     this.customerName,
//     this.urlImageCustomer,
//     this.price,
//     this.timeStart,
//     this.timeEnd,
//     this.dateOfSlot,
//     this.resultSurvey,
//     this.discChart,
//     this.urlBirthChart,
//   });

//   String? customerName;
//   String? urlImageCustomer;
//   int? price;
//   String? timeStart;
//   String? timeEnd;
//   DateTime? dateOfSlot;
//   String? resultSurvey;
//   String? discChart;
//   String? urlBirthChart;

//   factory DetailBooking.fromJson(Map<String, dynamic> json) => DetailBooking(
//         customerName: json["customerName"],
//         urlImageCustomer: json["urlImageCustomer"],
//         price: json["price"],
//         timeStart: json["timeStart"],
//         timeEnd: json["timeEnd"],
//         dateOfSlot: DateTime.parse(json["dateOfSlot"]),
//         resultSurvey: json["resultSurvey"],
//         discChart: json["discChart"],
//         urlBirthChart: json["urlBirthChart"],
//       );

//   Map<String, dynamic> toJson() => {
//         "customerName": customerName,
//         "urlImageCustomer": urlImageCustomer,
//         "price": price,
//         "timeStart": timeStart,
//         "timeEnd": timeEnd,
//         "dateOfSlot":
//             "${dateOfSlot!.year.toString().padLeft(4, '0')}-${dateOfSlot!.month.toString().padLeft(2, '0')}-${dateOfSlot!.day.toString().padLeft(2, '0')}",
//         "resultSurvey": resultSurvey,
//         "discChart": discChart,
//         "urlBirthChart": urlBirthChart,
//       };
// }

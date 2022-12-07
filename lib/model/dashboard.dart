// To parse this JSON data, do
//
//     final dashboardResponse = dashboardResponseFromJson(jsonString);

import 'dart:convert';

DashboardResponse dashboardResponseFromJson(String str) =>
    DashboardResponse.fromJson(json.decode(str));

String dashboardResponseToJson(DashboardResponse data) =>
    json.encode(data.toJson());

class DashboardResponse {
  DashboardResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  int? statusCode;
  String? message;
  List<Dashboard>? data;

  factory DashboardResponse.fromJson(Map<String, dynamic> json) =>
      DashboardResponse(
        statusCode: json["statusCode"],
        message: json["message"],
        data: List<Dashboard>.from(
            json["data"].map((x) => Dashboard.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Dashboard {
  Dashboard({
    this.id,
    this.fullName,
    this.imageUrl,
    this.experience,
    this.rating,
    this.specialization,
    this.feedback,
    this.amountWallet,
  });

  int? id;
  String? fullName;
  String? imageUrl;
  int? experience;
  double? rating;
  String? specialization;
  int? feedback;
  int? amountWallet;

  factory Dashboard.fromJson(Map<String, dynamic> json) => Dashboard(
        id: json["id"],
        fullName: json["fullName"],
        imageUrl: json["imageUrl"],
        experience: json["experience"],
        rating: json["rating"].toDouble(),
        specialization: json["specialization"],
        feedback: json["feedback"],
        amountWallet: json["amountWallet"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "imageUrl": imageUrl,
        "experience": experience,
        "rating": rating,
        "specialization": specialization,
        "feedback": feedback,
        "amountWallet": amountWallet,
      };
}

// To parse this JSON data, do
//
//     final consultantResponse = consultantResponseFromJson(jsonString);

import 'dart:convert';

ConsultantResponse consultantResponseFromJson(String str) =>
    ConsultantResponse.fromJson(json.decode(str));

String consultantResponseToJson(ConsultantResponse data) =>
    json.encode(data.toJson());

class ConsultantResponse {
  ConsultantResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  int? statusCode;
  String? message;
  List<Consultant>? data;

  factory ConsultantResponse.fromJson(Map<String, dynamic> json) =>
      ConsultantResponse(
        statusCode: json["statusCode"],
        message: json["message"],
        data: List<Consultant>.from(
            json["data"].map((x) => Consultant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Consultant {
  Consultant({
    this.id,
    this.fullName,
    this.imageUrl,
    this.email,
    this.address,
    this.dob,
    this.gender,
    this.phone,
    this.status,
    this.experience,
    this.rating,
    this.specialization,
  });

  int? id;
  String? fullName;
  String? imageUrl;
  String? email;
  String? address;
  DateTime? dob;
  String? gender;
  String? phone;
  String? status;
  int? experience;
  double? rating;
  String? specialization;

  factory Consultant.fromJson(Map<String, dynamic> json) => Consultant(
        id: json["id"],
        fullName: json["fullName"],
        imageUrl: json["imageUrl"],
        email: json["email"],
        address: json["address"],
        dob: DateTime.parse(json["dob"]),
        gender: json["gender"],
        phone: json["phone"],
        status: json["status"],
        experience: json["experience"],
        rating: json["rating"].toDouble(),
        specialization: json["specialization"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "imageUrl": imageUrl,
        "email": email,
        "address": address,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "phone": phone,
        "status": status,
        "experience": experience,
        "rating": rating,
        "specialization": specialization,
      };
}

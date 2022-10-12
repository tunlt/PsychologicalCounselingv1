// To parse this JSON data, do
//
//     final ConsultantResponse = ConsultantResponseFromJson(jsonString);

import 'dart:convert';

ConsultantResponse ConsultantResponseFromJson(String str) =>
    ConsultantResponse.fromJson(json.decode(str));

String ConsultantResponseToJson(ConsultantResponse data) =>
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
    this.email,
    this.avartarUrl,
    this.imageUrl,
    this.address,
    this.dob,
    this.gender,
    this.phone,
    this.experience,
    this.rating,
    this.status,
  });

  int? id;
  String? fullName;
  String? email;
  String? avartarUrl;
  String? imageUrl;
  String? address;
  DateTime? dob;
  String? gender;
  String? phone;
  int? experience;
  int? rating;
  String? status;

  factory Consultant.fromJson(Map<String, dynamic> json) => Consultant(
        id: json["id"],
        fullName: json["fullName"],
        email: json["email"],
        avartarUrl: json["avartarUrl"],
        imageUrl: json["imageUrl"],
        address: json["address"],
        dob: DateTime.parse(json["dob"]),
        gender: json["gender"],
        phone: json["phone"],
        experience: json["experience"],
        rating: json["rating"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "email": email,
        "avartarUrl": avartarUrl,
        "imageUrl": imageUrl,
        "address": address,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "phone": phone,
        "experience": experience,
        "rating": rating,
        "status": status,
      };
}

// To parse this JSON data, do
//
//     final withdrawalResponse = withdrawalResponseFromJson(jsonString);

import 'dart:convert';

WithdrawalResponse withdrawalResponseFromJson(String str) =>
    WithdrawalResponse.fromJson(json.decode(str));

String withdrawalResponseToJson(WithdrawalResponse data) =>
    json.encode(data.toJson());

class WithdrawalResponse {
  WithdrawalResponse({
    this.statusCode,
    this.content,
    this.data,
    this.totalpage,
  });

  int? statusCode;
  String? content;
  List<Withdrawalinfo>? data;
  int? totalpage;

  factory WithdrawalResponse.fromJson(Map<String, dynamic> json) =>
      WithdrawalResponse(
        statusCode: json["statusCode"],
        content: json["content"],
        data: List<Withdrawalinfo>.from(
            json["data"].map((x) => Withdrawalinfo.fromJson(x))),
        totalpage: json["totalpage"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "content": content,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "totalpage": totalpage,
      };
}

class Withdrawalinfo {
  Withdrawalinfo({
    this.id,
    this.accountName,
    this.bankName,
    this.bankNumber,
    this.description,
    this.dateCreate,
    this.requestAmount,
    this.actualWithdrawal,
    this.status,
  });

  int? id;
  String? accountName;
  String? bankName;
  String? bankNumber;
  String? description;
  DateTime? dateCreate;
  int? requestAmount;
  int? actualWithdrawal;
  String? status;

  factory Withdrawalinfo.fromJson(Map<String, dynamic> json) => Withdrawalinfo(
        id: json["id"],
        accountName: json["accountName"],
        bankName: json["bankName"],
        bankNumber: json["bankNumber"],
        description: json["description"] == null ? null : json["description"],
        dateCreate: DateTime.parse(json["dateCreate"]),
        requestAmount: json["requestAmount"],
        actualWithdrawal: json["actualWithdrawal"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "accountName": accountName,
        "bankName": bankName,
        "bankNumber": bankNumber,
        "description": description == null ? null : description,
        "dateCreate":
            "${dateCreate!.year.toString().padLeft(4, '0')}-${dateCreate!.month.toString().padLeft(2, '0')}-${dateCreate!.day.toString().padLeft(2, '0')}",
        "requestAmount": requestAmount,
        "actualWithdrawal": actualWithdrawal,
        "status": status,
      };
}

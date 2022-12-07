// To parse this JSON data, do
//
//     final bankResponse = bankResponseFromJson(jsonString);

import 'dart:convert';

BankResponse bankResponseFromJson(String str) =>
    BankResponse.fromJson(json.decode(str));

String bankResponseToJson(BankResponse data) => json.encode(data.toJson());

class BankResponse {
  BankResponse({
    this.code,
    this.desc,
    this.data,
  });

  String? code;
  String? desc;
  List<Bank>? data;

  factory BankResponse.fromJson(Map<String, dynamic> json) => BankResponse(
        code: json["code"],
        desc: json["desc"],
        data: List<Bank>.from(json["data"].map((x) => Bank.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "desc": desc,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Bank {
  Bank({
    this.id,
    this.name,
    this.code,
    this.bin,
    this.shortName,
    this.logo,
    this.transferSupported,
    this.lookupSupported,
  });

  int? id;
  String? name;
  String? code;
  String? bin;
  String? shortName;
  String? logo;
  int? transferSupported;
  int? lookupSupported;

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        bin: json["bin"],
        shortName: json["shortName"],
        logo: json["logo"],
        transferSupported: json["transferSupported"],
        lookupSupported: json["lookupSupported"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "bin": bin,
        "shortName": shortName,
        "logo": logo,
        "transferSupported": transferSupported,
        "lookupSupported": lookupSupported,
      };
}

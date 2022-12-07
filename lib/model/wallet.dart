// To parse this JSON data, do
//
//     final walletResponse = walletResponseFromJson(jsonString);

import 'dart:convert';

WalletResponse walletResponseFromJson(String str) =>
    WalletResponse.fromJson(json.decode(str));

String walletResponseToJson(WalletResponse data) => json.encode(data.toJson());

class WalletResponse {
  WalletResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  int? statusCode;
  String? message;
  List<Wallet>? data;

  factory WalletResponse.fromJson(Map<String, dynamic> json) => WalletResponse(
        statusCode: json["statusCode"],
        message: json["message"],
        data: List<Wallet>.from(json["data"].map((x) => Wallet.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Wallet {
  Wallet({
    this.name,
    this.gem,
  });

  String? name;
  int? gem;

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        name: json["name"],
        gem: json["gem"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "gem": gem,
      };
}

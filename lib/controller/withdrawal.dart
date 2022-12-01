import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WithdrawalController extends GetxController {
  var isLoading = true.obs;
  String? token;

  Future<void> WithdrawalConsultant(TextEditingController bankName, password,
      amount, bankNumber, fullName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
    try {
      final String body = json.encode({
        // 'bankName': bankName.text,
        // 'bankNumber': bankNumber.text,
        // 'amount': amount.text,
        // 'consultantId': id,
        // 'password': password.text,
        // "fullName": fullName.text,
        "fullName": fullName.text,
        "bankName": bankName.text,
        "bankNumber": bankNumber.text,
        "amount": amount.text,
        "consultantId": id,
        "password": password.text,
      });
      final response = await http.post(
          Uri.parse(
              "https://psycteamv2.azurewebsites.net/api/Withdrawals/withdraw"),
          body: body,
          headers: {"content-type": "application/json"});
      print("api len");
      print(response.statusCode);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Yêu cầu thành công",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromARGB(255, 35, 236, 28),
            textColor: Colors.black,
            fontSize: 16.0);
        print("withdrawal success");
      } else {
        print("fail withdrawal");
        Fluttertoast.showToast(
            msg: "rút tiền thất bại",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red.shade200,
            textColor: Colors.black,
            fontSize: 16.0);
      }
    } catch (error) {
      print(error);
    }
  }
}

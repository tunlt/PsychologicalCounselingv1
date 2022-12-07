import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:psychological_counseling/Withdrawal/historywithdrawal_screen.dart';
import 'package:psychological_counseling/controller/dashboard.dart';
import 'package:psychological_counseling/controller/wallet.dart';
import 'package:psychological_counseling/model/withdrawal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WithdrawalController extends GetxController {
  var isLoading = true.obs;
  late List<Withdrawalinfo> listWithdrawalHistory = <Withdrawalinfo>[].obs;
  final listwallet = Get.find<WalletController>();
  var checkrequest = false.obs;
  String? token;
  final _dashboard = Get.find<DashboardController>();

  Future<void> WithdrawalConsultant(TextEditingController bankName, password,
      amount, bankNumber, fullName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
    try {
      final String body = json.encode({
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
      print(body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        getListwithdrawalInfo();
        listwallet.getWallet();
        _dashboard.getDashboard();
        Fluttertoast.showToast(
            msg: "Yêu cầu rút tiền thành công",
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
            msg: "Yêu cầu rút tiền thất bại",
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

  Future<List<Withdrawalinfo>> getListwithdrawalInfo() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    int? id = pref.getInt('id');
    String? token = pref.getString('token');
    try {
      print(id);
      isLoading(true);
      final response = await http.get(
          Uri.parse(
              'https://psycteamv2.azurewebsites.net/api/Withdrawals/historywithdrawal?consultantid=${id}&pagesize=10&pagenumber=1'),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        print("chạy rồi hehe");
        var appointment = withdrawalResponseFromJson(jsonString);
        if (appointment.data != null) {
          listWithdrawalHistory = appointment.data as List<Withdrawalinfo>;
          print("o day co chay appointment");
          update();
          Get.to(HistoryWithdrawalScreen());
        }
      }
    } catch (error) {
      print('loi');
    } finally {
      isLoading(false);
    }
    return listWithdrawalHistory;
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:psychological_counseling/Withdrawal/withdrawal_screen.dart';
import 'package:psychological_counseling/model/consultant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckpassWalletController extends GetxController {
  var isLoading = true.obs;
  var checkpass = false.obs;
  // ignore: non_constant_identifier_names
  Future<void> Checkpass() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt('id');
    try {
      isLoading(true);
      final response = await http.get(
          Uri.parse(
              "https://psycteamv2.azurewebsites.net/api/Consultants/checkpasswalletbyid?id=${id}"),
          headers: {"content-type": "application/json"});
      print("api len");
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('check pass');
        var jsonString = json.decode(response.body);
        int checkpass1 = jsonString['data'];
        // 0 là chưa có
        print(checkpass1);
        if (checkpass1 == 0) {
          checkpass = true.obs;
        } else if (checkpass1 == 1) {
          checkpass = false.obs;
        }
      }
    } catch (error) {
      print(error);
    } finally {
      isLoading(false);
    }
    ;
  }

  Future<void> CreatePassWallet(
    TextEditingController password,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt('id');
    final String body = json.encode({
      'newPassword': password.text,
      'consultantId': id,
    });
    try {
      final response = await http.put(
          Uri.parse(
              "https://psycteamv2.azurewebsites.net/api/Wallets/createpasswordwallet"),
          body: body,
          headers: {"content-type": "application/json"});
      print(response.statusCode);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "tạo mật khẩu thành công",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromARGB(255, 43, 204, 22),
            textColor: Colors.black,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "tạo mật khẩu thất bại",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromARGB(255, 231, 13, 13),
            textColor: Colors.black,
            fontSize: 16.0);
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> ChangePassWallet(
    TextEditingController oldPass,
    newPass,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt('id');
    final String body = json.encode({
      'oldPassword': oldPass.text,
      'newPassword': newPass.text,
      'consultantId': id
    });
    try {
      final response = await http.put(
          Uri.parse(
              "https://psycteamv2.azurewebsites.net/api/Wallets/forgotpasswallet"),
          body: body,
          headers: {"content-type": "application/json"});
      print(response.statusCode);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Mật khẩu thay đổi thành công",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromARGB(255, 43, 204, 22),
            textColor: Colors.black,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Mật khẩu thay đổi thất bại",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromARGB(255, 231, 13, 13),
            textColor: Colors.black,
            fontSize: 16.0);
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> ChangePassAccount(
    TextEditingController oldPass,
    TextEditingController newPass,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt('id');
    final String body = json.encode(
        {'oldPassword': oldPass.text, 'newPassword': newPass.text, 'id': id});
    try {
      final response = await http.put(
          Uri.parse(
              "https://psycteamv2.azurewebsites.net/api/Users/changepassuserbyconsultantid"),
          body: body,
          headers: {"content-type": "application/json"});
      print(response.statusCode);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Mật khẩu thay đổi thành công",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromARGB(255, 43, 204, 22),
            textColor: Colors.black,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Mật khẩu thay đổi thất bại",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromARGB(255, 231, 13, 13),
            textColor: Colors.black,
            fontSize: 16.0);
      }
    } catch (error) {
      print(error);
    }
  }
}

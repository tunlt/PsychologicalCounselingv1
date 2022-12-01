import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:psychological_counseling/Home/home_screen.dart';
import 'package:psychological_counseling/Login/login_screen.dart';
import 'package:psychological_counseling/model/consultant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var isLoading = true.obs;
  late List<Consultant> consultantdetail = <Consultant>[].obs;
  String? token;
  String tokenDevice = "";

  Future<void> LoginConsultant(
      TextEditingController usernameController, passwordController) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      isLoading(false);
      final String body = json.encode({
        'userName': usernameController.text,
        'passWord': passwordController.text,
        'fcmToken': tokenDevice,
      });
      print(tokenDevice);
      print(body);
      final response = await http.post(
          Uri.parse(
              "https://psycteamv2.azurewebsites.net/api/FirebaseServices/loginconsultant"),
          body: body,
          headers: {"content-type": "application/json"});
      print("api len");
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("Login success");
        var jsonString = json.decode(response.body);
        int consultantId = jsonString['id'];
        var token = jsonString['jwttoken'];
        prefs.setInt('id', consultantId);
        prefs.setString('token', token);
        print(consultantId);
        print(token);
        Get.to(HomeScreenConsultant());
      } else {
        print("fail login");
        Fluttertoast.showToast(
            msg: "login fail",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red.shade200,
            textColor: Colors.black,
            fontSize: 16.0);
      }
    } catch (error) {
      print(error);
    } finally {
      isLoading(true);
    }
  }

  void setTokenDevice(String token) {
    tokenDevice = token;
    update();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    // Get.reset();
    // Get.to(LoginScreen());
    Get.to(LoginScreen());
  }
}

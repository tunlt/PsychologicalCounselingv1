import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:psychological_counseling/Register/veriify_email.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends GetxController {
  Future<void> addRegister(
      TextEditingController emailController,
      fullnameController,
      usernameController,
      passwordController,
      addressController,
      genderController,
      dobController,
      phoneController,
      String? avatarURL) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = emailController.text;
    prefs.setString('emailConsultant', email);
    // final String? token = prefs.getString('token');
    String? token = prefs.getString('token');
    try {
      String body = json.encode({
        'userName': usernameController.text,
        'passWord': passwordController.text,
        'email': emailController.text,
      });
      String body2 = json.encode({
        'email': emailController.text,
        'fullName': fullnameController.text,
        'address': addressController.text,
        'dob': dobController.text,
        'gender': genderController.text,
        'phone': phoneController.text,
        'imageUrl': avatarURL,
      });
      print(body);
      final response = await http.post(
          Uri.parse(
              "https://psycteam.azurewebsites.net/api/Users/createconsultantv2"),
          body: body,
          headers: {"content-type": "application/json"});

      final response2 = await http.put(
          Uri.parse(
              "https://psycteam.azurewebsites.net/api/Consultants/update"),
          body: body2,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          });

      print("api len");
      print(response.statusCode);

      print(response2.statusCode);
      print("api 2 len");
      if (response.statusCode == 200 && response2.statusCode == 200) {
        print("regis success");
        Get.to(VerifyEmailScreen());
        Fluttertoast.showToast(
            msg: "Code đã được gửi vào mail của bạn",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromARGB(255, 44, 194, 6),
            textColor: Colors.black,
            fontSize: 16.0);
      } else {
        print("fail regis");
        Fluttertoast.showToast(
            msg: "Đăng Kí không thành công",
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

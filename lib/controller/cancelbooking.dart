// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class RegisterController extends GetxController {
//   Future<void> CancelBookingSlot(
//       TextEditingController reason,
//       int idSlot) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     String email = reason.text;
//     // final String? token = prefs.getString('token');
//     String? token = prefs.getString('token');
//     try {
//       final Map<String, String> queryparam = {
//         'id': idSlot.toString(),
//         'reason': reason.text,
//       };
//       final response = await http.put(
//           Uri.parse(
//               "https://psycteam.azurewebsites.net/api/SlotBookings/cancelbyconsultant")
//               .replace(queryParameters: queryparam),
          
//           headers: {
//             "Content-Type": "application/json",
//             "Authorization": "Bearer $token"
//           });

//       print("cancel booking chạy");

//       print(response.statusCode);
//       if (response.statusCode == 200) {
//         print("cancel chạy");
//         // Get.to(VerifyEmailScreen());
//         Fluttertoast.showToast(
//             msg: "Cancel thành công",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.BOTTOM,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.white,
//             textColor: Colors.black,
//             fontSize: 16.0);
//       } else {
//         // print("fail regis");
//         Fluttertoast.showToast(
//             msg: "Cancel thành công",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.BOTTOM,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.red.shade200,
//             textColor: Colors.black,
//             fontSize: 16.0);
//       }
//     } catch (error) {
//       print(error);
//     }
//   }
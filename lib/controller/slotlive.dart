import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:psychological_counseling/Live.dart/live_screen.dart';
import 'package:psychological_counseling/model/slotlivestream.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SlotLiveController extends GetxController {
  var isLoading = true.obs;
  late List<SlotLive> listSlotLive = <SlotLive>[].obs;

  var formatdate = DateFormat('yyyy-MM-dd');

  Future<List<SlotLive>> getListSlotLive(
    String date,
  ) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    int? id = pref.getInt('id');
    String? token = pref.getString('token');
    try {
      print(id);
      print(date);
      isLoading(true);
      final response = await http.get(
          Uri.parse(
              'https://psycteamv2.azurewebsites.net/api/SlotBookings/GetSlotLiveStreamByDateAndConsultanid?date=${date}&consultantid=${id}'),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var slotlive = slotLiveResponseFromJson(jsonString);
        if (slotlive.data != null) {
          listSlotLive = slotlive.data as List<SlotLive>;
          print("o day co chay slotlive");
          Get.to(LiveScreen());
          update();
        }
      }
    } catch (error) {
      print('loi slot live');
    } finally {
      isLoading(false);
    }
    return listSlotLive;
  }
  // create slotlive

  Future<void> addSlotLive(
    String dateSlot,
    String timeStart,
    TextEditingController description,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
    // final String? token = prefs.getString('token');
    try {
      String body = json.encode({
        'timeStart': timeStart,
        'dateSlot': dateSlot,
        'consultantId': id,
        'description': description.text,
        // "price": price?.text,
      });
      print(body);
      final response = await http.post(
          Uri.parse(
              "https://psycteamv2.azurewebsites.net/api/SlotBookings/createlivestream"),
          body: body,
          headers: {"content-type": "application/json"});
      print(response.statusCode);
      var jsonString = json.decode(response.body);
      if (response.statusCode == 200) {
        getListSlotLive(dateSlot);
        Fluttertoast.showToast(
            msg: "${jsonString['message']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.green,
            textColor: Colors.black,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "${jsonString['message']}",
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

  Future<void> CancelSlotLive(
    int idSlot,
    String dateSlot,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // final String? token = prefs.getString('token');
    String? token = prefs.getString('token');
    try {
      final Map<String, String> queryparam = {
        'id': idSlot.toString(),
      };
      final response = await http.put(
          Uri.parse(
                  "https://psycteamv2.azurewebsites.net/api/SlotBookings/remove")
              .replace(queryParameters: queryparam),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          });

      print("cancel Slot live chạy");

      print(response.statusCode);
      if (response.statusCode == 200) {
        print("cancel chạy");
        // Get.to(VerifyEmailScreen());
        getListSlotLive(dateSlot);
        Get.to(LiveScreen());
        Fluttertoast.showToast(
            msg: "Hủy thành công",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Color.fromARGB(255, 108, 219, 113),
            textColor: Colors.black,
            fontSize: 16.0);
      } else {
        // print("fail regis");
        Fluttertoast.showToast(
            msg: "Hủy thất bại",
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
  // Future<void> confirmVideocall(int? id) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String? token = prefs.getString('token');
  //   try {
  //     final response = await http.put(
  //         Uri.parse(
  //             "https://psycteam.azurewebsites.net/api/SlotBookings/confirmvideocall?id=${id}"),
  //         headers: {
  //           "Content-Type": "application/json",
  //           "Authorization": "Bearer $token"
  //         });

  //     print("api len");
  //     print(response.statusCode);

  //     print("api 2 len");
  //     if (response.statusCode == 200) {
  //       print("cuộc gọi thành công");
  //       // Get.to(VerifyEmailScreen());
  //       appointmentController
  //           .getListHistoryAppointment(formatdate.format(DateTime.now()));
  //       print(formatdate.format(DateTime.now()));
  //       Fluttertoast.showToast(
  //           msg: "Cuộc gọi đã kết thúc",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Color.fromARGB(255, 40, 165, 9),
  //           textColor: Colors.black,
  //           fontSize: 16.0);
  //     } else {
  //       print("fail regis");
  //       Fluttertoast.showToast(
  //           msg: "kết thúc không thành công",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.red.shade200,
  //           textColor: Colors.black,
  //           fontSize: 16.0);
  //     }
  //   } catch (error) {
  //     print(error);
  //   }
  // }
}

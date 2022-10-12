import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:psychological_counseling/Schedule/schedule_screen.dart';
import 'package:psychological_counseling/model/slotbooking.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SlotbookingController extends GetxController {
  var isLoading = true.obs;
  late List<SlotBooking> listSlotBooking = <SlotBooking>[].obs;

  Future<List<SlotBooking>> getListSlotBooking(
    String date,
  ) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    int? id = pref.getInt('id');
    String? token = pref.getString('token');
    try {
      print(id);
      isLoading(true);
      final response = await http.get(
          Uri.parse(
              'https://psycteam.azurewebsites.net/api/SlotBookings/GetSlotBookingByDateAndConsultantid?date=${date}&consultantid=${id}'),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        print("chạy rồi hehe");
        var slotbooking = slotBookingFromJson(jsonString);
        if (slotbooking.data != null) {
          print('loi tieu r');
          listSlotBooking = slotbooking.data as List<SlotBooking>;
          print("o day co chay slotbooking");
          update();
        }
      }
    } catch (error) {
      print('loi');
    } finally {
      isLoading(false);
    }
    return listSlotBooking;
  }
  // create slot

  Future<void> addSlotBooking(
    String dateSlot,
    String timeStart,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
    // final String? token = prefs.getString('token');
    try {
      String body = json.encode({
        'timeStart': timeStart,
        'dateSlot': dateSlot,
        'consultantId': id,
      });
      print(body);
      final response = await http.post(
          Uri.parse(
              "https://psycteam.azurewebsites.net/api/SlotBookings/create"),
          body: body,
          headers: {"content-type": "application/json"});
      print(response.statusCode);

      if (response.statusCode == 200) {
        Get.to(ScheduleScreen());
        Fluttertoast.showToast(
            msg: "Slot đã được thêm thành công",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "thêm slot thất bại",
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

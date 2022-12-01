import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:psychological_counseling/Appointment/appointment_screen.dart';
import 'package:psychological_counseling/History/history_screen.dart';
import 'package:psychological_counseling/Schedule/schedule_screen.dart';
import 'package:psychological_counseling/model/appointment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentController extends GetxController {
  var isLoading = true.obs;
  late List<Appointment> listUpcommingAppointment = <Appointment>[].obs;
  late List<Appointment> listHistoryAppointment = <Appointment>[].obs;

  Future<List<Appointment>> getListUpcommingAppointment(
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
              'https://psycteamv2.azurewebsites.net/api/SlotBookings/GetAppointmentByConsultantid?date=${date}&consultantid=${id}'),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        print("chạy rồi hehe");
        var appointment = appointmentResponseFromJson(jsonString);
        if (appointment.data != null) {
          listUpcommingAppointment = appointment.data as List<Appointment>;
          print("o day co chay appointment");
          update();
          Get.to(AppointmentScreen());
        }
      }
    } catch (error) {
      print('loi');
    } finally {
      isLoading(false);
    }
    return listUpcommingAppointment;
  }

  // get history
  Future<List<Appointment>> getListHistoryAppointment(
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
              'https://psycteamv2.azurewebsites.net/api/SlotBookings/GetHistoryByConsultantid?date=${date}&consultantid=${id}'),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        print("chạy rồi hehe");
        var appointment = appointmentResponseFromJson(jsonString);
        if (appointment.data != null) {
          listHistoryAppointment = appointment.data as List<Appointment>;
          print("o day co chay history");
          update();
          Get.to(HistoryScreen());
        }
      }
    } catch (error) {
      print('loi');
    } finally {
      isLoading(false);
    }
    return listHistoryAppointment;
  }

  Future<void> CancelBookingSlot(
    TextEditingController reason,
    int idSlot,
    String dateSlot,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = reason.text;
    // final String? token = prefs.getString('token');
    String? token = prefs.getString('token');
    try {
      final Map<String, String> queryparam = {
        'id': idSlot.toString(),
        'reason': reason.text,
      };
      final response = await http.put(
          Uri.parse(
                  "https://psycteamv2.azurewebsites.net/api/SlotBookings/cancelbyconsultant")
              .replace(queryParameters: queryparam),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          });

      print("cancel booking chạy");

      print(response.statusCode);
      if (response.statusCode == 200) {
        print("cancel chạy");
        // Get.to(VerifyEmailScreen());
        getListUpcommingAppointment(dateSlot);
        Get.to(AppointmentScreen());
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
}

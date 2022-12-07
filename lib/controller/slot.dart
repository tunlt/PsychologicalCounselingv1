import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:psychological_counseling/Appointment/detail_screen.dart';
import 'package:psychological_counseling/History/historydetail_screen.dart';
import 'package:psychological_counseling/Schedule/schedule_screen.dart';
import 'package:psychological_counseling/components/bottombar_consultant.dart';
import 'package:psychological_counseling/controller/appointment.dart';
import 'package:psychological_counseling/controller/bottom_navigation.dart';
import 'package:psychological_counseling/controller/dashboard.dart';
import 'package:psychological_counseling/model/detailbooking.dart';
import 'package:psychological_counseling/model/detailhistory.dart';
import 'package:psychological_counseling/model/slotbooking.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SlotbookingController extends GetxController {
  var isLoading = true.obs;
  late List<SlotBooking> listSlotBooking = <SlotBooking>[].obs;
  late List<DetailBooking> listbookingDetail = <DetailBooking>[].obs;
  late List<DetailHistory> listhistoryDetail = <DetailHistory>[].obs;
  final appointmentController = Get.find<AppointmentController>();
  final bottomNavigationController = Get.find<BottomNavigationController>();
  final _dashboard = Get.find<DashboardController>();

  var formatdate = DateFormat('yyyy-MM-dd');

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
              'https://psycteamv2.azurewebsites.net/api/SlotBookings/GetSlotBookingByDateAndConsultanid?date=${date}&consultantid=${id}'),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var slotbooking = slotBookingFromJson(jsonString);
        if (slotbooking.data != null) {
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
    // TextEditingController? price,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
    // final String? token = prefs.getString('token');
    try {
      String body = json.encode({
        'timeStart': timeStart,
        'dateSlot': dateSlot,
        'consultantId': id,
        // "price": price?.text,
      });
      print(body);
      final response = await http.post(
          Uri.parse(
              "https://psycteamv2.azurewebsites.net/api/SlotBookings/create"),
          body: body,
          headers: {"content-type": "application/json"});
      print(response.statusCode);
      var jsonString = json.decode(response.body);
      if (response.statusCode == 200) {
        getListSlotBooking(dateSlot);
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

  Future<void> confirmLive(int? id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    try {
      print(id);
      final response = await http.put(
          Uri.parse(
              "https://psycteamv2.azurewebsites.net/api/SlotBookings/confirmlivestream?id=${id}"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          });

      print("api len");
      print(response.statusCode);

      print("api 2 len");
      if (response.statusCode == 200) {
        print("cuộc gọi thành công");

        bottomNavigationController.changeTabIndex(1);
        Get.to(NavigationPage());

        Fluttertoast.showToast(
            msg: "Cuộc gọi đã kết thúc",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromARGB(255, 40, 165, 9),
            textColor: Colors.black,
            fontSize: 16.0);
      } else {
        print("fail regis");
        Fluttertoast.showToast(
            msg: "kết thúc không thành công",
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

  Future<void> confirmVideocall(int? id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    try {
      print(id);
      final Map<String, String> queryparam = {
        'id': id.toString(),
      };
      final response = await http.put(
          Uri.parse(
                  "https://psycteamv2.azurewebsites.net/api/SlotBookings/confirmvideocall")
              .replace(queryParameters: queryparam),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          });

      print("api len");
      print(response.statusCode);

      print("api 2 len");
      if (response.statusCode == 200) {
        print("cuộc gọi thành công");
        // Get.to(VerifyEmailScreen());
        appointmentController
            .getListHistoryAppointment(formatdate.format(DateTime.now()));
        bottomNavigationController.changeTabIndex(3);
        _dashboard.getDashboard();
        Get.to(NavigationPage());
        print(formatdate.format(DateTime.now()));
        Fluttertoast.showToast(
            msg: "Cuộc gọi đã kết thúc",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromARGB(255, 40, 165, 9),
            textColor: Colors.black,
            fontSize: 16.0);
      } else {
        print("fail regis");
        Fluttertoast.showToast(
            msg: "kết thúc không thành công",
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

  Future<void> CustomerDetailBooking(int? idslotBooking) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    try {
      final response = await http.get(
          Uri.parse(
              "https://psycteamv2.azurewebsites.net/api/SlotBookings/detailcustomerbyslotid?id=${idslotBooking}"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          });

      print(response.statusCode);

      if (response.statusCode == 200) {
        // var jsonString = response.body;
        var jsonString = response.body;
        print(jsonString);
        var detailBooking = detailBookingResponseFromJson(jsonString);
        print("chạy ở đây");
        if (detailBooking.data != null) {
          listbookingDetail = detailBooking.data as List<DetailBooking>;
          print("o day co detail slotbooking");
          Get.to(DetailUpcomingScreen());
          update();
        }
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> CustomerDetailHistory(int? idslotBooking) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    try {
      final response = await http.get(
          Uri.parse(
              "https://psycteamv2.azurewebsites.net/api/SlotBookings/getdetailslotbookingv2?id=${idslotBooking}"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          });

      print(response.statusCode);

      if (response.statusCode == 200) {
        // var jsonString = response.body;
        var jsonString = response.body;
        print(jsonString);
        var detailHistory = detailHistoryResponseFromJson(jsonString);
        if (detailHistory.data != null) {
          listhistoryDetail = detailHistory.data as List<DetailHistory>;
          print("o day co detail history");
          Get.to(DetailHistoryScreen());
          update();
        }
      }
    } catch (error) {
      print(error);
    }
  }
}

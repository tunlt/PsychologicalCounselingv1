import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:psychological_counseling/Notification/notification_screen.dart';
import 'package:psychological_counseling/model/notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationController extends GetxController {
  var isLoading = true.obs;
  String? urlImage;
  var countNotification = 0.obs;
  late List<Notifications> listNotification = <Notifications>[].obs;
  Future<List<Notifications>> getLitsNotification(bool check) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
    String? token = prefs.getString('token');
    try {
      print('chay Notification detail');
      isLoading(true);
      final response = await http.get(
          Uri.parse(
              'https://psycteam.azurewebsites.net/api/Notifications/getnotificationbyconsultant?id=${id}'),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonString = response.body;

        var notification = notificationResponseFromJson(jsonString);
        // consultant.data![0].dob = ;
        if (notification.data != null) {
          listNotification = notification.data as List<Notifications>;
          update();
          if (check == true) {
            Get.to(NotificationScreen());
          }
        }
      }
    } catch (error) {
      print('loi noti');
    } finally {
      isLoading(false);
    }
    return listNotification;
  }

  Future<void> SeenNotification(int id) async {
    try {
      final Map<String, String> queryparam = {'id': id.toString()};
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      print('chạy seen noti');
      // final response = await http.put(Uri.parse(
      //         'https://psycteam.azurewebsites.net/api/Notifications/seennoti')
      //     .replace(queryParameters: queryparam));

      final response = await http.put(
          Uri.parse(
                  'https://psycteam.azurewebsites.net/api/Notifications/seennoti')
              .replace(queryParameters: queryparam),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          });
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('seen change');
      }
    } catch (error) {
      print('lỗi seen noti');
    } finally {}
  }

  Future<void> RemoveNotification(int id) async {
    try {
      final Map<String, String> queryparam = {'id': id.toString()};
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      print('chạy hidden noti');
      // final response = await http.put(Uri.parse(
      //         'https://psycteam.azurewebsites.net/api/Notifications/seennoti')
      //     .replace(queryParameters: queryparam));

      final response = await http.put(
          Uri.parse(
                  'https://psycteam.azurewebsites.net/api/Notifications/hiddennoti')
              .replace(queryParameters: queryparam),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          });
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(' hidden run');
      }
    } catch (error) {
      print('lỗi hidden noti');
    } finally {}
  }

  Future<void> CountNewNotification() async {
    try {
      var count;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      int? id = prefs.getInt('id');
      print('chạy count new noti');
      // final response = await http.put(Uri.parse(
      //         'https://psycteam.azurewebsites.net/api/Notifications/seennoti')
      //     .replace(queryParameters: queryparam));

      final response = await http.get(
          Uri.parse(
              'https://psycteam.azurewebsites.net/api/Notifications/countnotibyconsultant?id=${id}'),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonString = json.decode(response.body);
        countNotification.value = jsonString['amount'];
      }
    } catch (error) {
      print('lỗi count noti');
    } finally {}
  }

  Future<void> RefreshCountNotification() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      int? id = prefs.getInt('id');
      print('chạy refresh noti');

      final response = await http.post(
          Uri.parse(
              'https://psycteam.azurewebsites.net/api/Notifications/refreshnotibyconsultant?id=${id}'),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          });
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('refresh success');
      }
    } catch (error) {
      print('lỗi count noti');
    } finally {}
  }
}

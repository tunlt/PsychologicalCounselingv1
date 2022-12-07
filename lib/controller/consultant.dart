import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:psychological_counseling/Profile/editprofile_screen.dart';
import 'package:psychological_counseling/Profile/profile_screen.dart';
import 'package:psychological_counseling/model/consultant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConsultantController extends GetxController {
  var isLoading = true.obs;
  String? urlImage;
  // late List<Consultant> consultantdetail = <Consultant>[].obs;
  late List<Consultant> consultantdetail = <Consultant>[].obs;
  late List<Consultant> consultantprofile = <Consultant>[].obs;
  // Future<List<Consultant>> getConsultantDetail(bool check) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int? id = prefs.getInt('id');
  //   String? token = prefs.getString('token');
  //   try {
  //     print('chay Consultant detail');
  //     print(id);
  //     isLoading(true);
  //     final response = await http.get(
  //         Uri.parse(
  //             'https://psycteam.azurewebsites.net/api/Consultants/getbyid?id=${2}'),
  //         headers: {
  //           "Content-Type": "application/json",
  //           "Authorization": "Bearer $token"
  //         });
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       print('co chay day khong');

  //       var jsonString = response.body;
  //       print("o day co chay 2");
  //       var consultant = consultantResponseFromJson(jsonString);

  //       if (consultant.data != null) {
  //         consultantdetail = consultant.data as List<Consultant>;

  //         print(consultantdetail[0].imageUrl);
  //         update();
  //         if (check) {
  //           Get.to(EditProfileConsultantScreen());
  //         } else {
  //           Get.to(ProfileConsultantScreen());
  //         }
  //       }
  //     }
  //   } catch (error) {
  //     print('loi consul');
  //   } finally {
  //     isLoading(false);
  //   }
  //   return consultantdetail;
  // }

  Future<List<Consultant>> getConsultantDetail(bool check) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
    String? token = prefs.getString('token');
    try {
      print('chay Consultant detail');
      print(id);
      isLoading(true);
      final response = await http.get(
          Uri.parse(
              'https://psycteamv2.azurewebsites.net/api/Consultants/getbyid?id=${id}'),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          });
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('co chay day khong');

        var jsonString = response.body;
        print("o day co chay 2");
        var consultant = consultantResponseFromJson(jsonString);

        if (consultant.data != null) {
          consultantdetail = consultant.data as List<Consultant>;

          update();
          if (check) {
            Get.to(EditProfileConsultantScreen());
          }
        }
      }
    } catch (error) {
      print('loi consul');
    } finally {
      isLoading(false);
    }
    return consultantdetail;
  }

  //UPLoad avatar
  Future<void> loadImageConsultant(File file) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
    String? token = prefs.getString('token');
    try {
      var postUri = Uri.parse(
          "https://psycteamv2.azurewebsites.net/api/FirebaseServices/upload");
      http.MultipartRequest request = http.MultipartRequest("POST", postUri);
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'file',
        file.path,
      );
      request.headers.addAll({"Authorization": "Bearer $token"});
      request.files.add(multipartFile);
      http.StreamedResponse response = await request.send();
      print(response.statusCode);
      final request1 = await http.Response.fromStream(response);
      var reusult = request1.body;
      if (response.statusCode == 200) {
        print("update success");
        var jsonString = json.decode(reusult);
        urlImage = jsonString['data'];
        print(urlImage);
      }
    } catch (error) {
      print("lỗi rồi ");
    }
  }

// update consultant
  Future<void> UpdateConsultant(
      TextEditingController fullname,
      TextEditingController address,
      TextEditingController email,
      String? gender,
      String? urlImage,
      String? dob,
      TextEditingController phone) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      final String body = json.encode({
        "fullName": fullname.text,
        "email": email.text,
        "imageUrl": urlImage,
        "address": address.text,
        "dob": "$dob",
        "gender": gender,
        "phone": phone.text
      });
      print("image ở dưới ");
      print(urlImage);
      final response = await http.put(
          Uri.parse(
              "https://psycteamv2.azurewebsites.net/api/Consultants/update"),
          body: body,
          headers: {"content-type": "application/json"});
      print("update lên");
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("update success");
        var jsonString = json.decode(response.body);
        Fluttertoast.showToast(
            msg: "update success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red.shade200,
            textColor: Colors.black,
            fontSize: 16.0);

        update();
        getConsultantDetail(true);
      } else {
        print("update consultant fail");
        Fluttertoast.showToast(
            msg: "update fail",
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

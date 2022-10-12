import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
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
              'https://psycteam.azurewebsites.net/api/SlotBookings/GetAppointmentByConsultantid?date=${date}&consultantid=${id}'),
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
          print('loi tieu r');
          listUpcommingAppointment = appointment.data as List<Appointment>;
          print("o day co chay appointment");
          update();
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
              'https://psycteam.azurewebsites.net/api/SlotBookings/GetHistoryByConsultantid?date=${date}&consultantid=${id}'),
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
        }
      }
    } catch (error) {
      print('loi');
    } finally {
      isLoading(false);
    }
    return listHistoryAppointment;
  }
}

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:psychological_counseling/callconsultant/components/bodyCall.dart';
import 'package:psychological_counseling/model/roomslotbooking.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class RoomSlotBookingAppointmentController extends GetxController {
  var isLoading = true.obs;
  late List<RoomSlotBooking> listroomSlotBooking = <RoomSlotBooking>[].obs;
  ClientRole? _role = ClientRole.Broadcaster;
  Future<List<RoomSlotBooking>> getRoomSlotBooking(
    int? id,
    DateTime? timeEnd,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      print('chay Room Slot booking');
      print(id);
      isLoading(true);
      final response = await http.get(
          Uri.parse(
              'https://psycteamv2.azurewebsites.net/api/SlotBookings/getroomslotbooking?id=${id}'),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var roomslotbooking = roomSlotBookingResponseFromJson(jsonString);
        if (roomslotbooking.data != null) {
          listroomSlotBooking = roomslotbooking.data as List<RoomSlotBooking>;
          update();
          print(listroomSlotBooking[0].chanelName);
          Onjoin(listroomSlotBooking[0].chanelName, ClientRole.Broadcaster,
              listroomSlotBooking[0].token, timeEnd, id);
        }
      }
    } catch (error) {
      print('loi room slotBoooking');
    } finally {
      isLoading(false);
    }
    return listroomSlotBooking;
  }

  Future<void> Onjoin(String? chanelName, ClientRole? role, String? token,
      DateTime? timeEnd, int? id) async {
    await _handleCameraandMic(Permission.camera);
    await _handleCameraandMic(Permission.microphone);
    print('chạy join');
    print(timeEnd);
    await Get.to(BodyCall(
      chanelName: chanelName,
      role: role,
      token: token,
      timeEnd: timeEnd,
      id: id,
    ));
  }

  Future<void> _handleCameraandMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}

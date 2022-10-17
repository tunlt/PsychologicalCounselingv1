import 'package:get/get.dart';
import 'package:psychological_counseling/History/history_screen.dart';
import 'package:psychological_counseling/Notification/notification_screen.dart';
import 'package:psychological_counseling/Profile/editprofile_screen.dart';
import 'package:psychological_counseling/Profile/profile_screen.dart';
import 'package:psychological_counseling/Schedule/schedule_screen.dart';
import 'package:psychological_counseling/callconsultant/call_screen.dart';
import 'package:psychological_counseling/callconsultant/components/bodyCall.dart';
import 'package:psychological_counseling/controller/appointment.dart';
import 'package:psychological_counseling/controller/consultant.dart';
import 'package:psychological_counseling/controller/login.dart';
import 'package:psychological_counseling/controller/register_consultant.dart';
import 'package:psychological_counseling/controller/roomslotbooking.dart';
import 'package:psychological_counseling/controller/slot.dart';
import 'package:psychological_counseling/controller/verifyemail.dart';

class Binding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
    Get.lazyPut(() => VerifyEmailController());
    Get.lazyPut(() => ProfileConsultantScreen());
    Get.lazyPut(() => EditProfileConsultantScreen());
    Get.lazyPut(() => CallScreen());
    Get.lazyPut(() => BodyCall());
    Get.lazyPut(() => ConsultantController());
    Get.lazyPut(() => ScheduleScreen());
    Get.lazyPut(() => HistoryScreen());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => SlotbookingController());
    Get.lazyPut(() => AppointmentController());
    Get.lazyPut(() => NotificationScreen());
    Get.lazyPut(() => RoomSlotBookingAppointmentController());
  }
}

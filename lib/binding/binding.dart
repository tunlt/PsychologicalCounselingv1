import 'package:get/get.dart';
import 'package:psychological_counseling/Appointment/detail_screen.dart';
import 'package:psychological_counseling/Changepass/changepass_screen.dart';
import 'package:psychological_counseling/History/history_screen.dart';
import 'package:psychological_counseling/History/historydetail_screen.dart';
import 'package:psychological_counseling/Live.dart/live_screen.dart';
import 'package:psychological_counseling/Notification/notification_screen.dart';
import 'package:psychological_counseling/Profile/editprofile_screen.dart';
import 'package:psychological_counseling/Profile/profile_screen.dart';
import 'package:psychological_counseling/Schedule/schedule_screen.dart';
import 'package:psychological_counseling/Withdrawal/components/body.dart';
import 'package:psychological_counseling/Withdrawal/historywithdrawal_screen.dart';
import 'package:psychological_counseling/Withdrawal/withdrawal_screen.dart';
import 'package:psychological_counseling/callconsultant/call_screen.dart';
import 'package:psychological_counseling/callconsultant/components/bodyCall.dart';
import 'package:psychological_counseling/controller/appointment.dart';
import 'package:psychological_counseling/controller/bank.dart';
import 'package:psychological_counseling/controller/bottom_navigation.dart';
import 'package:psychological_counseling/controller/checkpasswallet.dart';
import 'package:psychological_counseling/controller/consultant.dart';
import 'package:psychological_counseling/controller/dashboard.dart';
import 'package:psychological_counseling/controller/login.dart';
import 'package:psychological_counseling/controller/notification.dart';
import 'package:psychological_counseling/controller/register_consultant.dart';
import 'package:psychological_counseling/controller/roomslotbooking.dart';
import 'package:psychological_counseling/controller/roomslotlive.dart';
import 'package:psychological_counseling/controller/slot.dart';
import 'package:psychological_counseling/controller/slotlive.dart';
import 'package:psychological_counseling/controller/verifyemail.dart';
import 'package:psychological_counseling/controller/wallet.dart';
import 'package:psychological_counseling/controller/withdrawal.dart';
import 'package:psychological_counseling/model/dashboard.dart';

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
    Get.lazyPut(() => NotificationController());
    Get.lazyPut(() => LiveScreen());
    Get.lazyPut(() => SlotLiveController());
    Get.lazyPut(() => RoomSlotLiveController());
    Get.lazyPut(() => WithdrawalScreen());
    Get.lazyPut(() => WithdrawalController());
    Get.lazyPut(() => ChangepassScreen());
    Get.lazyPut(() => CheckpassWalletController());
    Get.lazyPut(() => DetailUpcomingScreen());
    Get.lazyPut(() => DetailHistoryScreen());
    Get.lazyPut(() => HistoryWithdrawalScreen());
    Get.lazyPut(() => WithdrawalController());
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => BankController());
    Get.lazyPut(() => WalletController());
    Get.lazyPut(() => BottomNavigationController());
  }
}

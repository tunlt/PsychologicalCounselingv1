import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:psychological_counseling/Appointment/detail_screen.dart';
import 'package:psychological_counseling/Changepass/changepass_screen.dart';
import 'package:psychological_counseling/History/history_screen.dart';
import 'package:psychological_counseling/History/historydetail_screen.dart';
import 'package:psychological_counseling/Live.dart/live_screen.dart';
import 'package:psychological_counseling/Login/login_screen.dart';
import 'package:psychological_counseling/Notification/notification_screen.dart';
import 'package:psychological_counseling/Profile/editprofile_screen.dart';
import 'package:psychological_counseling/Profile/profile_screen.dart';
import 'package:psychological_counseling/Register/register_screen.dart';
import 'package:psychological_counseling/Register/veriify_email.dart';
import 'package:psychological_counseling/Schedule/schedule_screen.dart';
import 'package:psychological_counseling/Withdrawal/withdrawal_screen.dart';
import 'package:psychological_counseling/binding/binding.dart';
import 'package:get/get.dart';
import 'package:psychological_counseling/callconsultant/call_screen.dart';
import 'package:psychological_counseling/callconsultant/components/bodyCall.dart';

import 'Home/home_screen.dart';
import 'package:flutter/material.dart';

Future<void> _firebaseMessagingBackgroundHandler(message) async {
  await Firebase.initializeApp();
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

// String? mtoken;
// void getToken() async {
//   await FirebaseMessaging.instance.getToken().then((token) {
//     saveToken(token!);
//   });
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Binding().dependencies();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: Binding(),
      // home: RegisterScreen(),
      initialRoute: "/login_screen",
      getPages: [
        GetPage(
          name: '/register_screen',
          page: () => RegisterScreen(),
          binding: Binding(),
        ),
        GetPage(
            name: '/home_screen',
            page: () => HomeScreenConsultant(),
            binding: Binding()),
        GetPage(
            name: '/verify_email',
            page: () => VerifyEmailScreen(),
            binding: Binding()),
        GetPage(
            name: '/profile_screen',
            page: () => ProfileConsultantScreen(),
            binding: Binding()),
        GetPage(
            name: '/editprofile_screen',
            page: () => EditProfileConsultantScreen(),
            binding: Binding()),
        GetPage(
            name: '/call_screen', page: () => CallScreen(), binding: Binding()),
        GetPage(name: '/bodyCall', page: () => BodyCall(), binding: Binding()),
        GetPage(
            name: '/schedule_screen',
            page: () => ScheduleScreen(),
            binding: Binding()),
        GetPage(
            name: '/history_screen',
            page: () => HistoryScreen(),
            binding: Binding()),
        GetPage(
            name: '/login_screen',
            page: () => LoginScreen(),
            binding: Binding()),
        GetPage(
            name: '/notification_screen',
            page: () => NotificationScreen(),
            binding: Binding()),
        GetPage(
            name: '/live_screen', page: () => LiveScreen(), binding: Binding()),
        GetPage(
            name: '/withdrawal_screen',
            page: () => WithdrawalScreen(),
            binding: Binding()),
        GetPage(
            name: '/changpass_screen',
            page: () => ChangepassScreen(),
            binding: Binding()),
        GetPage(
            name: '/detail_screen',
            page: () => DetailUpcomingScreen(),
            binding: Binding()),
        GetPage(
            name: '/historydetail_screen',
            page: () => DetailHistoryScreen(),
            binding: Binding()),
      ],
    ),
  );
}

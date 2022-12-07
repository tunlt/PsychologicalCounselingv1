import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psychological_counseling/History/history_screen.dart';
import 'package:psychological_counseling/Home/home_screen.dart';
import 'package:psychological_counseling/Live.dart/live_screen.dart';
import 'package:psychological_counseling/Profile/profile_screen.dart';
import 'package:psychological_counseling/Schedule/schedule_screen.dart';
import 'package:psychological_counseling/controller/bottom_navigation.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final controller = Get.put(BottomNavigationController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavigationController>(builder: (context) {
      return Scaffold(
        body: IndexedStack(
          index: controller.tabIndex,
          children: const [
            HomeScreenConsultant(),
            LiveScreen(),
            ScheduleScreen(),
            HistoryScreen(),
            ProfileConsultantScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.tabIndex,
            type: BottomNavigationBarType.shifting,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white38,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            onTap: controller.changeTabIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Trang chủ",
                  backgroundColor: Color(0xff4f0080)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.live_tv),
                  label: "Live",
                  backgroundColor: Color(0xff4f0080)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month),
                  label: "Tạo lịch",
                  backgroundColor: Color(0xff4f0080)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.history_rounded),
                  label: "Lịch sử",
                  backgroundColor: Color(0xff4f0080)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people),
                  label: "Tài khoản",
                  backgroundColor: Color(0xff4f0080)),
            ]),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psychological_counseling/Appointment/appointment_screen.dart';
import 'package:psychological_counseling/History/history_screen.dart';
import 'package:psychological_counseling/Home/home_screen.dart';
import 'package:psychological_counseling/Profile/conponents/body.dart';
import 'package:psychological_counseling/Profile/profile_screen.dart';
import 'package:psychological_counseling/controller/consultant.dart';

class BottomBarPsycApp extends StatelessWidget {
  String selected = "";
  Color colorSelected = Colors.white;
  Color colorNormal = Color.fromRGBO(87, 79, 79, 1);
  BottomBarPsycApp({required this.selected});
  final _consultant = Get.find<ConsultantController>();
  // final AppointmentController appointmentController =
  //     Get.find<AppointmentController>();
  // final ConsultantController spaController = Get.find<ConsultantController>();
  // final LoginController loginController = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: 0, bottom: 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(1), topLeft: Radius.circular(1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (selected == "home")
              GestureDetector(
                onTap: () {
                  Get.to(HomeScreenConsultant());
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.home))
                  ],
                ),
              )
            else
              GestureDetector(
                // onTap: () => spaController.getSpa(),
                onTap: () {},
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.to(HomeScreenConsultant());
                        },
                        icon: Icon(Icons.home))
                  ],
                ),
              ),
            //=============================================================APPOINTMENT
            if (selected == "appointment")
              GestureDetector(
                onTap: () {
                  Get.to(AppointmentScreen());
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.calendar_month))
                  ],
                ),
              )
            else
              GestureDetector(
                // onTap: () => appointmentController.getBookingServices(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.to(AppointmentScreen());
                        },
                        icon: Icon(Icons.calendar_month)),
                    // Text(
                    //   "Appointment",
                    //   style: TextStyle(fontSize: 12, color: Colors.black45),
                    // )
                  ],
                ),
              ),
            //=============================================================SEARCH
            if (selected == "history")
              GestureDetector(
                onTap: () {
                  Get.to(HistoryScreen());
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.history))
                  ],
                ),
              )
            else
              GestureDetector(
                // onTap: () => spaController.getSpa(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.to(HistoryScreen());
                        },
                        icon: Icon(Icons.history))
                  ],
                ),
              ),
            if (selected == "profile")
              GestureDetector(
                onTap: () {
                  _consultant.getConsultantDetail(false);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.manage_accounts_outlined))
                  ],
                ),
              )
            else
              GestureDetector(
                // onTap: () => spaController.getSpa(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.to(ProfileConsultantScreen());
                        },
                        icon: Icon(Icons.manage_accounts_outlined))
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:psychological_counseling/Appointment/components/body_dart.dart';

import '../components/bottombar_consultant.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  // _AppointmentScreenState createState() => _AppointmentScreenState();
  _AppontmentScreenState createState() => _AppontmentScreenState();
}

class _AppontmentScreenState extends State<AppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      // bottomNavigationBar: BottomBarPsycApp(selected: "appointment"),
    );
  }
}

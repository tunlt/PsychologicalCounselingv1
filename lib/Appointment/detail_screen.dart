import 'package:flutter/material.dart';
import 'package:psychological_counseling/Appointment/components/detail_upcoming.dart';

class DetailUpcomingScreen extends StatefulWidget {
  const DetailUpcomingScreen({Key? key}) : super(key: key);

  @override
  // _AppointmentScreenState createState() => _AppointmentScreenState();
  _DetailUpcomingScreenState createState() => _DetailUpcomingScreenState();
}

class _DetailUpcomingScreenState extends State<DetailUpcomingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DetailUpcomming(),
    );
  }
}

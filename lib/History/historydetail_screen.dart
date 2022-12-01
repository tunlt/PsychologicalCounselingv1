import 'package:flutter/material.dart';
import 'package:psychological_counseling/History/components/detail_History.dart';

class DetailHistoryScreen extends StatefulWidget {
  const DetailHistoryScreen({Key? key}) : super(key: key);

  @override
  // _AppointmentScreenState createState() => _AppointmentScreenState();
  _DetailHistoryScreenState createState() => _DetailHistoryScreenState();
}

class _DetailHistoryScreenState extends State<DetailHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DetailHistory(),
    );
  }
}

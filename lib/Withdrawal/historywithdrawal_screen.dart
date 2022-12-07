import 'package:flutter/material.dart';
import 'package:psychological_counseling/Withdrawal/components/historywithdrawal.dart';

class HistoryWithdrawalScreen extends StatefulWidget {
  const HistoryWithdrawalScreen({Key? key}) : super(key: key);

  @override
  // _AppointmentScreenState createState() => _AppointmentScreenState();
  _HistoryWithdrawalScreenState createState() =>
      _HistoryWithdrawalScreenState();
}

class _HistoryWithdrawalScreenState extends State<HistoryWithdrawalScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BodyHistoryWithdrawal(),
    );
  }
}

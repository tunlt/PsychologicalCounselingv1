import 'package:flutter/material.dart';
import 'package:psychological_counseling/History/components/body.dart';
import 'package:psychological_counseling/components/bottombar_consultant.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  // _HistoryScreenState createState() => _HistoryScreenState();
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomNavigationBar: BottomBarPsycApp(selected: "History"),
    );
  }
}

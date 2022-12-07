import 'package:flutter/material.dart';
import 'package:psychological_counseling/Home/components/body.dart';
import 'package:psychological_counseling/components/bottombar_consultant.dart';

class HomeScreenConsultant extends StatefulWidget {
  const HomeScreenConsultant({Key? key}) : super(key: key);

  @override
  _HomeScreenConsultantState createState() => _HomeScreenConsultantState();
}

class _HomeScreenConsultantState extends State<HomeScreenConsultant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      // bottomNavigationBar: BottomBarPsycApp(selected: "home"),
    );
  }
}

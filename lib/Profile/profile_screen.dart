import 'package:flutter/material.dart';
import 'package:psychological_counseling/Profile/conponents/body.dart';
import 'package:psychological_counseling/components/bottombar_consultant.dart';

class ProfileConsultantScreen extends StatefulWidget {
  const ProfileConsultantScreen({super.key});

  @override
  State<ProfileConsultantScreen> createState() =>
      _ProfileConsultantScreenState();
}

class _ProfileConsultantScreenState extends State<ProfileConsultantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfileConsultant(),
      bottomNavigationBar: BottomBarPsycApp(selected: "profile"),
    );
  }
}

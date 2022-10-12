import 'package:flutter/material.dart';
import 'package:psychological_counseling/Profile/conponents/editprofile.dart';

class EditProfileConsultantScreen extends StatefulWidget {
  const EditProfileConsultantScreen({super.key});

  @override
  State<EditProfileConsultantScreen> createState() =>
      _EditProfileConsultantScreenState();
}

class _EditProfileConsultantScreenState
    extends State<EditProfileConsultantScreen> {
  @override
  Widget build(BuildContext context) {
    return EditProfileConsultant();
  }
}

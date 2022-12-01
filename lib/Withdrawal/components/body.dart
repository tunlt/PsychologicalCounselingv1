import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:psychological_counseling/Register/register_screen.dart';
import 'package:psychological_counseling/controller/login.dart';
import 'package:psychological_counseling/controller/withdrawal.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

final withdrawalController = Get.find<WithdrawalController>();

TextEditingController bankname = TextEditingController();
TextEditingController banknumber = TextEditingController();
TextEditingController amount = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController fullname = TextEditingController();

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                top: 200,
                left: -100,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: const BoxDecoration(
                    color: Color(0x304599ff),
                    borderRadius: BorderRadius.all(
                      Radius.circular(150),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: -10,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    color: Color(0x30cc33ff),
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                ),
              ),
              Positioned(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 80,
                    sigmaY: 80,
                  ),
                  child: Container(),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      // _logo(),
                      const SizedBox(
                        height: 50,
                      ),
                      _loginLabel(),
                      const SizedBox(
                        height: 50,
                      ),
                      _labelTextInput("Tên tài khoản", "Tên chủ tài khoản",
                          false, fullname),
                      const SizedBox(
                        height: 3,
                      ),
                      _labelTextInput(
                          "Tên ngân hàng", "tên ngân hàng", false, bankname),
                      const SizedBox(
                        height: 3,
                      ),
                      _labelTextInput(
                          "Số tài khoản", "Số tài khoản", false, banknumber),
                      const SizedBox(
                        height: 3,
                      ),
                      _labelTextInput(
                          "Số Gem cần rút", "1 Gem = 1000 VND", false, amount),
                      const SizedBox(
                        height: 3,
                      ),
                      _labelTextInput("Mật khẩu", "Nhập mật khẩu rút tiền",
                          false, password),
                      const SizedBox(
                        height: 10,
                      ),
                      _loginBtn(),
                      const SizedBox(
                        height: 50,
                      ),
                      _signUpLabel(
                          "Bạn chưa có mật khẩu?", const Color(0xff909090)),
                      const SizedBox(
                        height: 10,
                      ),
                      _signUpButton("tạo mới", const Color(0xff164276)),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _signUpLabel(String label, Color textColor) {
  return Text(
    label,
    style: GoogleFonts.josefinSans(
      textStyle: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w800,
        fontSize: 18,
      ),
    ),
  );
}

Widget _signUpButton(String label, Color textColor) {
  return TextButton(
      onPressed: () {
        // Get.to(RegisterScreen());
      },
      child: Text(
        "tạo mới mật khẩu",
        style: GoogleFonts.josefinSans(
          textStyle: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      ));
}

Widget _loginBtn() {
  return Container(
    width: 240,
    height: 40,
    decoration: const BoxDecoration(
      color: Color.fromARGB(255, 101, 24, 104),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    child: TextButton(
      onPressed: () {
        withdrawalController.WithdrawalConsultant(
            bankname, password, amount, banknumber, fullname);
      },
      child: Text(
        "Yêu cầu rút tiền",
        style: GoogleFonts.josefinSans(
          textStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
      ),
    ),
  );
}

Widget _labelTextInput(String label, String hintText, bool isPassword,
    TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: GoogleFonts.josefinSans(
          textStyle: const TextStyle(
            color: Color(0xff8fa1b6),
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      TextField(
        controller: controller,
        obscureText: isPassword,
        cursorColor: Colors.red,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.josefinSans(
            textStyle: const TextStyle(
              color: Color(0xffc5d2e1),
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffdfe8f3)),
          ),
        ),
      ),
    ],
  );
}

Widget _loginLabel() {
  return Center(
    child: Text(
      "Số dư: 500 cua",
      style: GoogleFonts.josefinSans(
        textStyle: const TextStyle(
          color: Color.fromARGB(255, 77, 7, 95),
          fontWeight: FontWeight.w900,
          fontSize: 34,
        ),
      ),
    ),
  );
}

// Widget _logo() {
//   return Center(
//     child: SizedBox(
//       height: 80,
//       child: Image.asset('assets/logo/logo.png'),
//     ),
//   );
// }

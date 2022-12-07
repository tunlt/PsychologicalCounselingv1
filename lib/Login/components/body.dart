import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:psychological_counseling/Register/register_screen.dart';
import 'package:psychological_counseling/controller/login.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

final loginController = Get.find<LoginController>();

TextEditingController username = TextEditingController();
TextEditingController password = TextEditingController();

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    password = TextEditingController();
    FirebaseMessaging.instance
        .getToken()
        .then((value) => loginController.setTokenDevice(value!));
  }

  final _formKey = GlobalKey<FormState>();

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Thông Báo?'),
            content: new Text('Bạn có chắc muốn thoát'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('Không'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: new Text('Có'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 70,
                          ),
                          _logo(),
                          const SizedBox(
                            height: 50,
                          ),
                          _loginLabel(),
                          const SizedBox(
                            height: 50,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Tài Khoản",
                                style: GoogleFonts.josefinSans(
                                  textStyle: const TextStyle(
                                    color: Color(0xff8fa1b6),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              TextFormField(
                                controller: username,
                                obscureText: false,
                                cursorColor: Colors.red,
                                decoration: InputDecoration(
                                  hintText: "Tên đăng nhập",
                                  hintStyle: GoogleFonts.josefinSans(
                                    textStyle: const TextStyle(
                                      color: Color(0xffc5d2e1),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20,
                                    ),
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xffdfe8f3)),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Vui lòng nhập tên đăng nhập';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Mật khẩu",
                                style: GoogleFonts.josefinSans(
                                  textStyle: const TextStyle(
                                    color: Color(0xff8fa1b6),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              TextFormField(
                                controller: password,
                                obscureText: true,
                                cursorColor: Colors.red,
                                decoration: InputDecoration(
                                  hintText: "Nhập mật khẩu",
                                  hintStyle: GoogleFonts.josefinSans(
                                    textStyle: const TextStyle(
                                      color: Color(0xffc5d2e1),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20,
                                    ),
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xffdfe8f3)),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Vui lòng nhập mật khẩu';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          _forgetPass(),
                          const SizedBox(
                            height: 30,
                          ),
                          _loading(),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            height: 60,
                            decoration: const BoxDecoration(
                              color: Color(0xff008fff),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: TextButton(
                              onPressed: () => {
                                if (_formKey.currentState!.validate())
                                  {
                                    loginController.LoginConsultant(
                                        username, password)
                                  }
                              },
                              child: Text(
                                "Đăng nhập",
                                style: GoogleFonts.josefinSans(
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          _signUpLabel("Bạn chưa có tài khoản?",
                              const Color(0xff909090)),
                          const SizedBox(
                            height: 10,
                          ),
                          _signUpButton("Đăng kí", const Color(0xff164276)),
                          const SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
        Get.to(RegisterScreen());
      },
      child: Text(
        "Đăng kí",
        style: GoogleFonts.josefinSans(
          textStyle: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      ));
}

Widget _loading() {
  return Padding(
      padding: EdgeInsets.zero,
      child: Obx(() => Center(
          child: loginController.isLoading.isFalse
              ? CircularProgressIndicator()
              : Container())));
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
      "Đăng nhập",
      style: GoogleFonts.josefinSans(
        textStyle: const TextStyle(
          color: Color(0xff164276),
          fontWeight: FontWeight.w900,
          fontSize: 34,
        ),
      ),
    ),
  );
}

Widget _forgetPass() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      TextButton(
        onPressed: () {},
        child: Text('Quên mật khẩu?'),
      )
    ],
  );
}

Widget _logo() {
  return Center(
    child: SizedBox(
      height: 80,
      child: Image.asset('assets/logo/logo.png'),
    ),
  );
}

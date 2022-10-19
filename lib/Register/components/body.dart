import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:psychological_counseling/Login/login_screen.dart';
import 'package:psychological_counseling/common/themhelper.dart';
import 'package:psychological_counseling/controller/register_consultant.dart';
import 'package:psychological_counseling/utils/settings.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  DateTime selectedDate = DateTime.now();
  final format = DateFormat("yyyy-MM-dd");
  TextEditingController emailController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? avatarURL = avatarfemale;
  String? gender;

  // var genderController = "male";

  final RegisterController _controller = Get.find<RegisterController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: const BoxConstraints.expand(),
        color: Colors.purple[200],
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 5),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/zodiac/logo.png",
                          ),
                          fit: BoxFit.contain)),
                  height: MediaQuery.of(context).size.height * .15,
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Text(
                  "Tạo mới một chuyên viên tư vấn!",
                  style: TextStyle(
                      color: Color.fromARGB(255, 92, 4, 107),
                      fontSize: 24,
                      fontStyle: FontStyle.normal),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: TextField(
                  controller: emailController,
                  decoration: ThemeHelper()
                      .textInputDecoration("Email", "Nhập vào email... "),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: TextField(
                  controller: fullnameController,
                  decoration: ThemeHelper()
                      .textInputDecoration("Họ và Tên", "Nhập họ và tên... "),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: TextField(
                  controller: usernameController,
                  decoration: ThemeHelper().textInputDecoration(
                      "Tên tài khoản", "Nhập tên tài khoản... "),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: TextField(
                  controller: passwordController,
                  decoration: ThemeHelper().textInputPasswordDecoration(
                      "Mật Khẩu", "Nhập vào mật khẩu"),
                  obscureText: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: TextField(
                  controller: addressController,
                  decoration: ThemeHelper()
                      .textInputDecoration("Địa Chỉ", "Nhập vào địa chỉ... "),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: TextField(
                  controller: phoneController,
                  decoration: ThemeHelper().textInputDecoration(
                      "Số điện thoại", "Nhập vào số điện thoại... "),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Column(children: <Widget>[
                  Text('Ngày Sinh (${format.pattern})'),
                  DateTimeField(
                    controller: dobController,
                    format: format,
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100));
                    },
                  ),
                ]),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 200,
                      child: RadioListTile<String>(
                        title: const Text('Nam'),
                        value: "Male",
                        groupValue: gender,
                        onChanged: (String? value) {
                          setState(() {
                            gender = value!;
                            print(gender);
                          });
                        },
                      ),
                    ),

                    Container(
                      width: 200,
                      child: RadioListTile<String>(
                        title: const Text('Nữ'),
                        value: "Female",
                        groupValue: gender,
                        onChanged: (String? value) {
                          setState(() {
                            gender = value!;
                            print(gender);
                          });
                        },
                      ),
                    ),
                    // Icon(
                    //   Icons.calendar_month_sharp,
                    //   color: Colors.purple,
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(130, 0, 0, 0),
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.pink[800]),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(
                            color: Colors.white,
                            width: 0.5,
                          ),
                        ),
                      ),
                    ),
                    child: Text('Tạo tài khoản'),
                    onPressed: () {
                      if (gender == 'Male') {
                        avatarURL = avatarmale;
                      }
                      _controller.addRegister(
                          emailController,
                          fullnameController,
                          usernameController,
                          passwordController,
                          addressController,
                          genderController,
                          dobController,
                          phoneController,
                          avatarURL);
                    }),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Container(
                    height: 130,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 10, 0, 30),
                          child: Text.rich(TextSpan(children: [
                            const TextSpan(
                                text: "Bạn đã có tài khoản!? ",
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16)),
                            TextSpan(
                                text: "Đăng nhập ngay!",
                                style: const TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.to(LoginScreen());
                                  }),
                          ])),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

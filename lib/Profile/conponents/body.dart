import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:psychological_counseling/Changepass/changepass_screen.dart';
import 'package:psychological_counseling/Withdrawal/withdrawal_screen.dart';
import 'package:psychological_counseling/controller/checkpasswallet.dart';
import 'package:psychological_counseling/controller/consultant.dart';
import 'package:psychological_counseling/controller/login.dart';
import 'package:psychological_counseling/controller/notification.dart';
import 'package:badges/badges.dart';

class ProfileConsultant extends StatefulWidget {
  const ProfileConsultant({super.key});

  @override
  State<ProfileConsultant> createState() => _ProfileConsultantState();
}

final ConsultantController consultantController =
    Get.find<ConsultantController>();
final logoutController = Get.find<LoginController>();
final notificationController = Get.find<NotificationController>();
final checkpasswallerController = Get.find<CheckpassWalletController>();
TextEditingController passwordAccount = TextEditingController();
TextEditingController passwordWallet = TextEditingController();
TextEditingController confirmPasswordWaller = TextEditingController();
int? countnoti;

Timer? _timer;

class _ProfileConsultantState extends State<ProfileConsultant> {
  void initState() {
    super.initState();
    notificationController.CountNewNotification();
    countnoti = notificationController.countNotification.value;
    checkpasswallerController.Checkpass();
    print(checkpasswallerController.checkpass);
    timeStart();
  }

  void timeStart() {
    _timer = Timer(Duration(milliseconds: 3000), () {
      notificationController.CountNewNotification();
      print(notificationController.countNotification.value);
      countnoti = notificationController.countNotification.value;
      timeStart();
    });
  }

  void dispose() {
    super.dispose();
    _timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Container(
                height: 115,
                width: 115,
                child: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          "${consultantController.consultantdetail[0].imageUrl}"),
                    )
                  ],
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RatingBarIndicator(
                      rating: consultantController.consultantdetail[0].rating!,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 20.0,
                      direction: Axis.horizontal,
                    ),
                    Text.rich(
                      TextSpan(children: [
                        TextSpan(
                            text:
                                "| Cấp ${consultantController.consultantdetail[0].experience}"),
                        TextSpan(text: " | 500 "),
                        TextSpan(text: "Gem"),
                      ]),
                    )
                  ],
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.purple,
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: Color(0xFFF5F6F9),
                ),
                onPressed: () {
                  consultantController.getConsultantDetail(true);
                },
                child: Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: 20),
                    Expanded(child: Text("Thông tin của tôi")),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.purple,
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: Color(0xFFF5F6F9),
                ),
                onPressed: () {
                  notificationController.getLitsNotification(true);
                },
                child: Row(
                  children: [
                    Container(
                        child: Obx(
                      () => Badge(
                        badgeContent: Text(
                            '${notificationController.countNotification.value}'),
                        child: Icon(Icons.notifications),
                        showBadge:
                            notificationController.countNotification.value > 0
                                ? true
                                : false,
                        animationType: BadgeAnimationType.scale,
                      ),
                    )),
                    SizedBox(width: 20),
                    Expanded(child: Text("Thông báo")),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.purple,
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: Color(0xFFF5F6F9),
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(Icons.history),
                    SizedBox(width: 20),
                    Expanded(child: Text("Lịch sử rút tiền")),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.purple,
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: Color(0xFFF5F6F9),
                ),
                onPressed: () {
                  checkpasswallerController.Checkpass();
                  print(checkpasswallerController.checkpass);
                  if (checkpasswallerController.checkpass == false) {
                    Get.to(WithdrawalScreen());
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Center(
                                  child: const Text(
                                      "Bạn cần tạo mật khẩu rút tiền!")),
                              actions: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 19),
                                  child: Row(
                                    children: [
                                      Text(
                                        '*',
                                        style: TextStyle(color: Colors.red),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Container(
                                    height: 60,
                                    width: 400,
                                    child: TextField(
                                      controller: passwordWallet,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.purple[20],
                                        border: OutlineInputBorder(),
                                        labelText: 'Mật khẩu rút tiền ',
                                        hintText: 'Nhập mật khẩu... ',
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 19),
                                  child: Row(
                                    children: [
                                      Text(
                                        '*',
                                        style: TextStyle(color: Colors.red),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Container(
                                    height: 60,
                                    width: 400,
                                    child: TextField(
                                      controller: confirmPasswordWaller,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.purple[20],
                                        border: OutlineInputBorder(),
                                        labelText:
                                            'Nhập lại mật khẩu rút tiền ',
                                        hintText: 'Nhập mật khẩu... ',
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      child: Container(
                                        child: Center(
                                          child: ElevatedButton.icon(
                                            icon: Icon(
                                              Icons.save,
                                              color: Colors.white,
                                            ),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.purple),
                                            ),
                                            label: Text('Lưu'),
                                            onPressed: () {
                                              showDialog<void>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title:
                                                        const Text('Thông báo'),
                                                    content: const Text(
                                                        'Bạn có chắc tạo mật khẩu rút tiền? '),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                          textStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .labelLarge,
                                                        ),
                                                        child:
                                                            const Text('Không'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                      TextButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                          textStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .labelLarge,
                                                        ),
                                                        child: const Text('Có'),
                                                        onPressed: () {
                                                          print(passwordAccount
                                                              .text);
                                                          print(passwordWallet);
                                                          if (passwordWallet
                                                                  .text ==
                                                              confirmPasswordWaller
                                                                  .text) {
                                                            checkpasswallerController
                                                                .CreatePassWallet(
                                                                    passwordWallet);

                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          } else {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "mật khẩu nhập lại không đúng",
                                                                toastLength: Toast
                                                                    .LENGTH_SHORT,
                                                                gravity:
                                                                    ToastGravity
                                                                        .BOTTOM,
                                                                timeInSecForIosWeb:
                                                                    1,
                                                                backgroundColor:
                                                                    Color
                                                                        .fromARGB(
                                                                            255,
                                                                            43,
                                                                            204,
                                                                            22),
                                                                textColor:
                                                                    Colors
                                                                        .black,
                                                                fontSize: 16.0);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          }
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Container(
                                        child: Center(
                                          child: ElevatedButton.icon(
                                            icon: Icon(
                                              Icons.cancel,
                                              color: Colors.white,
                                            ),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.purple),
                                            ),
                                            label: Text('Hủy'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ));
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.payment),
                    SizedBox(width: 20),
                    Expanded(child: Text("Rút tiền")),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.purple,
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: Color(0xFFF5F6F9),
                ),
                onPressed: () {
                  Get.to(ChangepassScreen());
                },
                child: Row(
                  children: [
                    Icon(Icons.change_circle_sharp),
                    SizedBox(width: 20),
                    Expanded(child: Text("Đổi mật khẩu")),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.purple,
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: Color(0xFFF5F6F9),
                ),
                onPressed: () {
                  logoutController.logout();
                },
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 20),
                    Expanded(child: Text("Đăng xuất")),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

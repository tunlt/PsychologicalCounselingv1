import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:psychological_counseling/Changepass/changepass_screen.dart';
import 'package:psychological_counseling/Withdrawal/components/body.dart';
import 'package:psychological_counseling/controller/bank.dart';
import 'package:psychological_counseling/controller/checkpasswallet.dart';
import 'package:psychological_counseling/controller/consultant.dart';
import 'package:psychological_counseling/controller/login.dart';
import 'package:psychological_counseling/controller/notification.dart';
import 'package:badges/badges.dart';
import 'package:psychological_counseling/controller/wallet.dart';
import 'package:psychological_counseling/controller/withdrawal.dart';
import 'package:skeletons/skeletons.dart';
import 'package:url_launcher/url_launcher.dart';

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
final histoyWithdrawalController = Get.find<WithdrawalController>();
final _bankController = Get.find<BankController>();
final _walletController = Get.find<WalletController>();
TextEditingController passwordAccount = TextEditingController();
TextEditingController passwordWallet = TextEditingController();
TextEditingController confirmPasswordWaller = TextEditingController();
int? countnoti;

Timer? _timer;

class _ProfileConsultantState extends State<ProfileConsultant> {
  void initState() {
    super.initState();
    consultantController.getConsultantDetail(false);
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
        body: Obx(
      () => SingleChildScrollView(
        child: consultantController.isLoading == true &&
                checkpassWalletController.isLoading == true
            ? SkeletonItem(
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
                          children: [CircleAvatar()],
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(bottom: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [],
                        )),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.purple,
                          padding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          backgroundColor: Color(0xFFF5F6F9),
                        ),
                        onPressed: () {},
                        child: Row(),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.purple,
                          padding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          backgroundColor: Color(0xFFF5F6F9),
                        ),
                        onPressed: () {
                          withdrawalController.getListwithdrawalInfo();
                        },
                        child: Row(
                          children: [],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                            Icon(Icons.payment),
                            SizedBox(width: 20),
                            Expanded(child: Text("R??t ti???n")),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                          children: [],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                            Icon(Icons.contact_phone),
                            SizedBox(width: 20),
                            Expanded(child: Text("Li??n h??? v???i admin")),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                          children: [],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Column(
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
                          consultantController.consultantdetail[0].rating ==
                                  null
                              ? RatingBarIndicator(
                                  rating: 0,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 20.0,
                                  direction: Axis.horizontal,
                                )
                              : RatingBarIndicator(
                                  rating: consultantController
                                      .consultantdetail[0].rating!,
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
                                      "| C???p ${consultantController.consultantdetail[0].experience}"),
                              // TextSpan(text: " | 500 "),
                              // TextSpan(text: "Gem"),
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
                          Expanded(child: Text("Th??ng tin c???a t??i")),
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
                              showBadge: notificationController
                                          .countNotification.value >
                                      0
                                  ? true
                                  : false,
                              animationType: BadgeAnimationType.scale,
                            ),
                          )),
                          SizedBox(width: 20),
                          Expanded(child: Text("Th??ng b??o")),
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
                        withdrawalController.getListwithdrawalInfo();
                      },
                      child: Row(
                        children: [
                          Icon(Icons.history),
                          SizedBox(width: 20),
                          Expanded(child: Text("L???ch s??? r??t ti???n")),
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
                          _walletController.getWallet();
                          _bankController.getListBank();
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Center(
                                        child: const Text(
                                            "B???n c???n t???o m???t kh???u r??t ti???n!")),
                                    actions: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 19),
                                        child: Row(
                                          children: [
                                            Text(
                                              '*',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
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
                                              labelText: 'M???t kh???u r??t ti???n ',
                                              hintText: 'Nh???p m???t kh???u... ',
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 19),
                                        child: Row(
                                          children: [
                                            Text(
                                              '*',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
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
                                                  'Nh???p l???i m???t kh???u r??t ti???n ',
                                              hintText: 'Nh???p m???t kh???u... ',
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                                        MaterialStateProperty
                                                            .all(Colors.purple),
                                                  ),
                                                  label: Text('L??u'),
                                                  onPressed: () {
                                                    showDialog<void>(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              'Th??ng b??o'),
                                                          content: const Text(
                                                              'B???n c?? ch???c t???o m???t kh???u r??t ti???n? '),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              style: TextButton
                                                                  .styleFrom(
                                                                textStyle: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .labelLarge,
                                                              ),
                                                              child: const Text(
                                                                  'Kh??ng'),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                            TextButton(
                                                              style: TextButton
                                                                  .styleFrom(
                                                                textStyle: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .labelLarge,
                                                              ),
                                                              child: const Text(
                                                                  'C??'),
                                                              onPressed: () {
                                                                print(
                                                                    passwordAccount
                                                                        .text);
                                                                print(
                                                                    passwordWallet);
                                                                if (passwordWallet
                                                                        .text ==
                                                                    confirmPasswordWaller
                                                                        .text) {
                                                                  checkpasswallerController
                                                                      .CreatePassWallet(
                                                                          passwordWallet);
                                                                  _walletController
                                                                      .getWallet();
                                                                  _bankController
                                                                      .getListBank();
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                } else {
                                                                  Fluttertoast.showToast(
                                                                      msg:
                                                                          "m???t kh???u nh???p l???i kh??ng ????ng",
                                                                      toastLength:
                                                                          Toast
                                                                              .LENGTH_SHORT,
                                                                      gravity: ToastGravity
                                                                          .BOTTOM,
                                                                      timeInSecForIosWeb:
                                                                          1,
                                                                      backgroundColor: Color.fromARGB(
                                                                          255,
                                                                          214,
                                                                          63,
                                                                          18),
                                                                      textColor:
                                                                          Colors
                                                                              .black,
                                                                      fontSize:
                                                                          16.0);
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
                                                        MaterialStateProperty
                                                            .all(Colors.purple),
                                                  ),
                                                  label: Text('H???y'),
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
                          Expanded(child: Text("V?? c???a t??i ")),
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
                          Expanded(child: Text("?????i m???t kh???u")),
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
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Center(
                                      child: const Text(
                                          "Ch???n c??ch li??n l???c c???a b???n?")),
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        TextButton(
                                            child: Center(
                                              child: Text(
                                                'Zalo',
                                              ),
                                            ),
                                            onPressed: () async {
                                              final url =
                                                  'https://zalo.me/0394705508';
                                              if (await canLaunch(url)) {
                                                await launch(url);
                                              }
                                              ;
                                            }),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        TextButton(
                                          child: Center(
                                            child: Text(
                                              '   G???i ??i???n tho???i tr???c ti???p',
                                            ),
                                          ),
                                          onPressed: () async {
                                            final url = 'tel:0394705508';
                                            if (await canLaunch(url)) {
                                              await launch(url);
                                            }
                                            ;
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ));
                      },
                      child: Row(
                        children: [
                          Icon(Icons.contact_phone),
                          SizedBox(width: 20),
                          Expanded(child: Text("Li??n h??? v???i admin")),
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
                          Expanded(child: Text("????ng xu???t")),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    ));
  }
}

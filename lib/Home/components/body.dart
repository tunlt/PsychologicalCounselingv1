import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:psychological_counseling/Home/components/block_appointment.dart';
import 'package:psychological_counseling/Live.dart/live_screen.dart';
import 'package:psychological_counseling/Profile/conponents/body.dart';
import 'package:psychological_counseling/Schedule/schedule_screen.dart';
import 'package:psychological_counseling/Withdrawal/withdrawal_screen.dart';
import 'package:psychological_counseling/controller/appointment.dart';
import 'package:psychological_counseling/controller/bank.dart';
import 'package:psychological_counseling/controller/consultant.dart';
import 'package:psychological_counseling/controller/dashboard.dart';
import 'package:psychological_counseling/controller/login.dart';
import 'package:psychological_counseling/controller/notification.dart';
import 'package:psychological_counseling/controller/slot.dart';
import 'package:psychological_counseling/controller/slotlive.dart';
import 'package:psychological_counseling/controller/wallet.dart';
import 'package:skeletons/skeletons.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

final scheduleController = Get.find<SlotbookingController>();
final slotLiveController = Get.find<SlotLiveController>();
final _consultant = Get.find<ConsultantController>();
final _countNotify = Get.find<NotificationController>();
final _dashboard = Get.find<DashboardController>();
final _appointment = Get.find<AppointmentController>();
final _consultantController = Get.find<ConsultantController>();
final _bankController = Get.find<BankController>();
final _walletController = Get.find<WalletController>();
final _logoutController = Get.find<LoginController>();

class _BodyState extends State<Body> {
  void initState() {
    super.initState();
    _dashboard.getDashboard();
    _appointment.getListUpcommingAppointment(format.format(DateTime.now()));
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          // ignore: unnecessary_new
          builder: (context) => new AlertDialog(
            // ignore: prefer_const_constructors
            title: Text('Thông Báo?'),
            content: Text('Bạn có chắc muốn đăng xuất'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Không'),
              ),
              TextButton(
                onPressed: () {
                  _logoutController.logout();
                  Navigator.of(context).pop(true);
                },
                child: Text('Có'),
              ),
            ],
          ),
        )) ??
        false;
  }

  final format = new DateFormat("yyyy-MM-dd");
  DateTime currentdate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          backgroundColor: Color(0xffF0F1F3),
          body: Obx(
            () => SafeArea(
                child:
                    //skeleton
                    _dashboard.isLoading == true
                        ? SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 40,
                                            child: SkeletonAvatar(
                                              style: SkeletonAvatarStyle(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              100))),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          SkeletonLine(
                                            style:
                                                SkeletonLineStyle(width: 200),
                                          ),
                                        ],
                                      ),
                                      SkeletonAvatar(
                                        style: SkeletonAvatarStyle(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100))),
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 400,
                                      // color: Colors.brown[200],
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          color: Colors.brown[100]),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                  height: 121,
                                                  width: 121,
                                                  child: SkeletonAvatar(
                                                    style: SkeletonAvatarStyle(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    22))),
                                                  )),
                                              Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Container(
                                                          height: 40,
                                                          width: 40,
                                                          decoration: BoxDecoration(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      202,
                                                                      189,
                                                                      207),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          8))),
                                                          child: SkeletonItem(
                                                            child: Icon(
                                                                Icons.star),
                                                          )),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      SkeletonLine(
                                                        style:
                                                            SkeletonLineStyle(
                                                                width: 30,
                                                                height: 30),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      SkeletonLine(
                                                        style:
                                                            SkeletonLineStyle(
                                                                width: 50,
                                                                height: 40),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      SkeletonItem(
                                                          child: Container(
                                                        height: 60,
                                                        width: 160,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        22)),
                                                      ))
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 35,
                                              ),
                                              SkeletonLine(
                                                style: SkeletonLineStyle(
                                                    height: 30, width: 100),
                                              ),
                                              SizedBox(
                                                width: 90,
                                              ),
                                              SkeletonLine(
                                                style: SkeletonLineStyle(
                                                    height: 30, width: 150),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                SkeletonItem(
                                    child: Container(
                                  height: 60,
                                  width: 400,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(22))),
                                )),
                                SizedBox(height: 10),
                                Container(
                                  height: 330,
                                  width: 400,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(22)),
                                    color: Colors.brown[100],
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child:
                                              GetBuilder<AppointmentController>(
                                            builder: (controller) => (controller
                                                    .isLoading.isTrue)
                                                ? Center(
                                                    child: SkeletonItem(
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(6.0),
                                                          child: SkeletonLine(
                                                            style: SkeletonLineStyle(
                                                                height: 48,
                                                                width: 400,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(6.0),
                                                          child: SkeletonLine(
                                                            style: SkeletonLineStyle(
                                                                height: 48,
                                                                width: 400,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(6.0),
                                                          child: SkeletonLine(
                                                            style: SkeletonLineStyle(
                                                                height: 48,
                                                                width: 400,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(6.0),
                                                          child: SkeletonLine(
                                                            style: SkeletonLineStyle(
                                                                height: 48,
                                                                width: 400,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: SkeletonLine(
                                                            style: SkeletonLineStyle(
                                                                height: 48,
                                                                width: 400,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ))
                                                : controller
                                                        .listUpcommingAppointment
                                                        .isEmpty
                                                    ? const Center(
                                                        child: Text(
                                                            'Bạn không có slot nào được đặt cho ngày này !'))
                                                    : ListView.builder(
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemBuilder: (ctx, i) =>
                                                            BlockAppointmentUpcoming(
                                                                controller
                                                                    .listUpcommingAppointment[i]),
                                                        itemCount: controller
                                                            .listUpcommingAppointment
                                                            .length,
                                                      ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        :
                        //code chạy
                        SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 40,
                                            child: Image(
                                                image: AssetImage(
                                                    'assets/logo/logo1.png')),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Psychological Counseling',
                                            style: GoogleFonts.asap(
                                                textStyle: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff4f0080))),
                                          ),
                                        ],
                                      ),
                                      // Container(
                                      //   child: Icon(
                                      //     Icons.notifications,
                                      //     color: Color(0xff4f0080),
                                      //     size: 35,
                                      //   ),
                                      // ),
                                      InkWell(
                                        onTap: (() {
                                          notificationController
                                              .getLitsNotification(true);
                                        }),
                                        child: Container(
                                            child: Obx(
                                          () => Badge(
                                            badgeContent: Text(
                                                '${notificationController.countNotification.value}'),
                                            child: Icon(
                                              Icons.notifications,
                                              color: Color(0xff4f0080),
                                              size: 35,
                                            ),
                                            showBadge: notificationController
                                                        .countNotification
                                                        .value >
                                                    0
                                                ? true
                                                : false,
                                            animationType:
                                                BadgeAnimationType.scale,
                                          ),
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 400,
                                      // color: Colors.brown[200],
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: Colors.white70),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    _consultant
                                                        .getConsultantDetail(
                                                            true);
                                                    // notificationController
                                                    //     .CountNewNotification();
                                                  },
                                                  style: TextButton.styleFrom(
                                                    primary: Color(0xff4f0080),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        22)),
                                                    backgroundColor:
                                                        Color(0xff4f0080),
                                                  ),
                                                  child: Container(
                                                    height: 121,
                                                    width: 111,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xff4f0080),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    22))),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 0,
                                                              left: 0,
                                                              top: 1,
                                                              bottom: 1),
                                                      child: CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(
                                                                '${_dashboard.listDasBoard[0].imageUrl}'),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    248,
                                                                    248,
                                                                    248),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8))),
                                                        child: Icon(
                                                          Icons.star,
                                                          color: Colors.yellow,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text(
                                                        '${_dashboard.listDasBoard[0].rating}',
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Column(
                                                        // ignore: prefer_const_literals_to_create_immutables
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        // ignore: prefer_const_literals_to_create_immutables
                                                        children: [
                                                          Text(
                                                            '${_dashboard.listDasBoard[0].feedback}',
                                                            // '',
                                                            style: GoogleFonts.asap(
                                                                textStyle: TextStyle(
                                                                    // fontWeight: FontWeight.w600,
                                                                    color: Colors.blueGrey,
                                                                    fontStyle: FontStyle.italic)),
                                                          ),
                                                          SizedBox(height: 5),
                                                          // ignore: prefer_const_constructors
                                                          Text(
                                                            'đánh giá',
                                                            style: GoogleFonts.asap(
                                                                textStyle: TextStyle(
                                                                    // fontWeight: FontWeight.w600,
                                                                    color: Colors.blueGrey,
                                                                    fontStyle: FontStyle.italic)),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        height: 60,
                                                        width: 160,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            17)),
                                                            color: Color(
                                                                0xff4f0080)),
                                                        child: ElevatedButton(
                                                          onPressed: (() {
                                                            _walletController
                                                                .getWallet();
                                                            _bankController
                                                                .getListBank();
                                                          }),
                                                          style: TextButton
                                                              .styleFrom(
                                                            primary: Color(
                                                                0xff4f0080),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            22)),
                                                            backgroundColor:
                                                                Color(
                                                                    0xff4f0080),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 3,
                                                                    bottom: 3),
                                                            child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .wallet,
                                                                    size: 50,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            246,
                                                                            8,
                                                                            224,
                                                                            15),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 8,
                                                                  ),
                                                                  Column(
                                                                    // ignore: prefer_const_literals_to_create_immutables
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Flexible(
                                                                        child:
                                                                            Text(
                                                                          'Ví',
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style:
                                                                              GoogleFonts.asap(textStyle: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontStyle: FontStyle.italic)),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              5),
                                                                      // ignore: prefer_const_constructors
                                                                      Text(
                                                                        '${_dashboard.listDasBoard[0].amountWallet} Gem',
                                                                        style: GoogleFonts.asap(
                                                                            textStyle: TextStyle(
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.w600,
                                                                                fontStyle: FontStyle.italic)),
                                                                      )
                                                                    ],
                                                                  )
                                                                ]),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 35,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  '${_dashboard.listDasBoard[0].fullName}',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 90,
                                              ),
                                              Flexible(
                                                child: Text(
                                                    '${_dashboard.listDasBoard[0].specialization}',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.asap(
                                                        textStyle: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Container(
                                  height: 60,
                                  width: 400,
                                  decoration: BoxDecoration(
                                      color: Color(0xff4f0080),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Row(children: [
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 24),
                                      child: IconButton(
                                        onPressed: () async {
                                          DateTime? changedate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: currentdate,
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime.now()
                                                .add(Duration(days: 7)),
                                            fieldLabelText: 'Lịch ngày',
                                            fieldHintText: 'mm/dd/yyyy',
                                            errorFormatText:
                                                'Bạn chỉ được chọn thời gian trong 7 ngày và theo định dạng mm/dd/yyyy',
                                            errorInvalidText:
                                                'Khoảng thời gian không được cho phép',
                                          );
                                          if (changedate == null ||
                                              changedate == currentdate) {
                                            changedate = currentdate;
                                          }
                                          setState(() {
                                            if (currentdate != changedate) {
                                              currentdate = changedate!;

                                              _appointment
                                                  .getListUpcommingAppointment(
                                                      format
                                                          .format(currentdate));
                                            }
                                          });
                                          // locale: Locale('vi'));
                                        },
                                        focusColor: Color(0xff4f0080),
                                        icon: Icon(
                                          Icons.calendar_month_outlined,
                                          color: Colors.black,
                                          size: 50,
                                        ),
                                      ),
                                    ),
                                    // ElevatedButton.icon(
                                    //   icon: Icon(
                                    //     Icons.calendar_month_outlined,
                                    //     color: Colors.black,
                                    //     size: 50,
                                    //   ),
                                    //   onPressed: (() {}),
                                    //   style: TextButton.styleFrom(
                                    //     primary: Colors.purple,
                                    //     backgroundColor: Colors.purple,
                                    //   ),
                                    //   label: Text(''),
                                    // ),
                                    SizedBox(
                                      width: 45,
                                    ),

                                    currentdate.compareTo(DateTime.now()) == -1
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Hôm Nay',
                                                style: GoogleFonts.asap(
                                                    textStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 17,
                                                        color: Colors.white,
                                                        fontStyle:
                                                            FontStyle.italic)),
                                              ),
                                              SizedBox(height: 3),
                                              // ignore: prefer_const_constructors
                                              Text(
                                                'Ngày ${currentdate.day}, tháng ${currentdate.month}, năm ${currentdate.year}',
                                                style: GoogleFonts.asap(
                                                    textStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white,
                                                        fontStyle:
                                                            FontStyle.italic)),
                                              )
                                            ],
                                          )
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(height: 3),
                                              // ignore: prefer_const_constructors
                                              Text(
                                                'Ngày ${currentdate.day}, tháng ${currentdate.month}, năm ${currentdate.year}',
                                                style: GoogleFonts.asap(
                                                    textStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white,
                                                        fontStyle:
                                                            FontStyle.italic)),
                                              )
                                            ],
                                          )
                                  ]),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  height: 330,
                                  width: 400,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white70,
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child:
                                              GetBuilder<AppointmentController>(
                                            builder: (controller) => (controller
                                                    .isLoading.isTrue)
                                                ? Center(
                                                    child: SkeletonItem(
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(6.0),
                                                          child: SkeletonLine(
                                                            style: SkeletonLineStyle(
                                                                height: 48,
                                                                width: 400,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(6.0),
                                                          child: SkeletonLine(
                                                            style: SkeletonLineStyle(
                                                                height: 48,
                                                                width: 400,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(6.0),
                                                          child: SkeletonLine(
                                                            style: SkeletonLineStyle(
                                                                height: 48,
                                                                width: 400,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(6.0),
                                                          child: SkeletonLine(
                                                            style: SkeletonLineStyle(
                                                                height: 48,
                                                                width: 400,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: SkeletonLine(
                                                            style: SkeletonLineStyle(
                                                                height: 48,
                                                                width: 400,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ))
                                                : controller
                                                        .listUpcommingAppointment
                                                        .isEmpty
                                                    ? Center(
                                                        child: Text(
                                                        'Bạn chưa có slot nào được đặt cho ngày này !',
                                                        style:
                                                            GoogleFonts.asap(),
                                                      ))
                                                    : ListView.builder(
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemBuilder: (ctx, i) =>
                                                            BlockAppointmentUpcoming(
                                                                controller
                                                                    .listUpcommingAppointment[i]),
                                                        itemCount: controller
                                                            .listUpcommingAppointment
                                                            .length,
                                                      ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
          )),
    );
  }
}

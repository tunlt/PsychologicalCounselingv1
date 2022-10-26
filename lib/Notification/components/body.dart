// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psychological_counseling/Notification/components/block_notification.dart';
import 'package:psychological_counseling/controller/notification.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final notificationController = Get.find<NotificationController>();
  Timer? _timer;
  void timeStart() {
    _timer = Timer(Duration(milliseconds: 3000), () {
      notificationController.getLitsNotification(false);
      _blockNoti();
    });
  }

  void dispose() {
    super.dispose();
    notificationController.RefreshCountNotification();
    notificationController.CountNewNotification();
    _timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
        title: Text("Thông báo"),
        backgroundColor: Colors.purple[200],
      ),
      body: SingleChildScrollView(
        child: Column(children: [_blockNoti()]),
      ),
    );
  }

  Container _blockNoti() {
    print('chạy lại đi');
    timeStart();
    return Container(
      // padding: const EdgeInsets.all(5.0),
      // child: GetBuilder<NotificationController>(
      //   builder: (controller) => (controller.isLoading.isTrue)
      //       ? const Center(child: CircularProgressIndicator())
      //       : controller.listNotification.isEmpty
      //           ? const Center(child: Text('Bạn chưa có thông báo nào !'))
      //           : ListView.builder(
      //               shrinkWrap: true,
      //               scrollDirection: Axis.vertical,
      //               itemBuilder: (ctx, i) =>
      //                   BlockNotification(controller.listNotification[i]),
      //               itemCount: controller.listNotification.length,
      //             ),
      // ),
      padding: const EdgeInsets.all(5.0),
      child: GetBuilder<NotificationController>(
        builder: (controller) => (controller.isLoading.isTrue)
            ? const Center(child: CircularProgressIndicator())
            : controller.listNotification.isEmpty
                ? const Center(child: Text('Bạn chưa có thông báo nào !'))
                : ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (ctx, i) =>
                        BlockNotification(controller.listNotification[i]),
                    itemCount: controller.listNotification.length,
                  ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:psychological_counseling/controller/notification.dart';
import 'package:psychological_counseling/model/notification.dart';

class BlockNotification extends StatelessWidget {
  BlockNotification(this.notification, {super.key});
  Notifications notification;

  DateFormat format = DateFormat('yyyy-MM-dd HH:mm');
  String? status;
  final notificationController = Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        notificationController.SeenNotification(notification.id!);
      },
      onLongPress: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 100,
              color: Colors.blueGrey[100],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ElevatedButton(
                            child: const Text('Xóa thông báo này'),
                            onPressed: () {
                              notificationController.RemoveNotification(
                                  notification.id!);
                              Navigator.pop(context);
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.pink[50],
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 10, 10, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 60,
                width: 80,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey.shade300),
                child: Icon(
                  Icons.notifications,
                  size: 25,
                  color: Colors.grey.shade700,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Text(
                      '${notification.description}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                  Row(
                    children: [
                      Text(
                        format.format(notification.dateCreate!),
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  )
                ],
              ),
              Container(
                height: 10,
                width: 10,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: notification.status! == "notseen"
                        ? Colors.blueAccent
                        : Colors.grey.shade300),
              )
            ],
          ),
        ),
      ),
    );
  }
}

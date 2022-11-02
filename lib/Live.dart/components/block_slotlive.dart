import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:psychological_counseling/Live.dart/components/Body.dart';
import 'package:psychological_counseling/controller/roomslotlive.dart';
import 'package:psychological_counseling/controller/slotlive.dart';
import 'package:psychological_counseling/model/slotbooking.dart';
import 'package:psychological_counseling/model/slotlivestream.dart';

// ignore: must_be_immutable
class BlockSlotLive extends StatelessWidget {
  BlockSlotLive(this.slotLive);
  final SlotLive slotLive;
  String status = "active";
  @override
  Widget build(BuildContext context) {
    DateTime? timeStart = _convertStringToDateTime(slotLive.timeStart!);
    DateTime? timeEnd = _convertStringToDateTime(slotLive.timeEnd!);
    TextEditingController? reason = TextEditingController();
    final _reasonKey = GlobalKey<FormState>();
    final slotLiveController = Get.find<SlotLiveController>();

    final roomSlotLiveController = Get.find<RoomSlotLiveController>();
    final format = new DateFormat("HH:mm");
    var formatdate = DateFormat('yyyy-MM-dd');
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          height: 80,
          width: 450,
          child: Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 10, 5),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: status == "active"
                    ? Colors.blueGrey[100]
                    : Colors.blueGrey[500],
              ),
              child: Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 40, bottom: 2, top: 5),
                              child: Row(
                                children: [
                                  RichText(
                                    maxLines: 4,
                                    text: TextSpan(
                                        text: 'Trạng Thái: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 16),

                                        // ignore: unnecessary_const
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: 'chuẩn bị bắt đầu',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 15)),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 65, bottom: 2, top: 2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                        text: 'Thời gian bắt đầu: ',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 16),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: format.format(timeStart!),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 15)),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 50, top: 2),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  RichText(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                        text: 'Nội dung buổi live: ',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 16),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: '${slotLive.description}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 15)),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4, right: 10),
                            child: SizedBox(
                              width: 100,
                              height: 20,
                              child: ElevatedButton(
                                onPressed: () {
                                  roomSlotLiveController.getRoomSlotLive(
                                      slotLive.id, timeEnd);
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color.fromARGB(
                                            255, 109, 14, 96))),
                                child: const Text(
                                  "Bắt đầu Live",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2, right: 10),
                            child: SizedBox(
                              width: 100,
                              height: 20,
                              child: ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title: const Text('Thông báo'),
                                            content: Text(
                                                'Bạn có chắc muốn hủy buổi live này'),
                                            actions: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 3),
                                                    child: ElevatedButton(
                                                        onPressed: () {
                                                          slotLiveController
                                                              .CancelSlotLive(
                                                                  slotLive.id!,
                                                                  formatdate.format(
                                                                      slotLive
                                                                          .dateSlot!));
                                                          Navigator.pop(context,
                                                              'Xác nhận');
                                                        },
                                                        child: const Text(
                                                            'Xác nhận')),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 3),
                                                    child: ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context, 'Hủy');
                                                        },
                                                        child:
                                                            const Text('Hủy')),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ));
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color.fromARGB(255, 110, 105, 108))),
                                child: const Text(
                                  "Hủy",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Column(
                      //   children: [
                      //     RichText(
                      //       text: const TextSpan(children: [
                      //         TextSpan(text: '  '),
                      //         WidgetSpan(
                      //             child: Padding(
                      //           padding: EdgeInsets.symmetric(horizontal: 2.0),
                      //           child: Icon(
                      //             Icons.access_time_rounded,
                      //             color: Colors.blueAccent,
                      //           ),
                      //         ))
                      //       ]),
                      //     ),
                      //   ],
                      // ),
                      // Center(
                      //   child: Text(
                      //     'thời gian bắt đầu: ' +
                      //         '${format.format(timeStart!)}',
                      //     style: TextStyle(
                      //         fontSize: 20,
                      //         color: Colors.blueAccent,
                      //         fontWeight: FontWeight.bold),
                      //   ),
                      // ),
                      // Center(
                      //   child: Text(
                      //     'Status ' + '${format.format(timeStart!)}',
                      //     style: TextStyle(
                      //         fontSize: 20,
                      //         color: Colors.blueAccent,
                      //         fontWeight: FontWeight.bold),
                      //   ),
                      // ),
                      // Text.rich(
                      //   TextSpan(
                      //     children: [
                      //       TextSpan(
                      //         text: '${slotLive.price}' + ' cua' + '   ',
                      //         style: TextStyle(
                      //             fontSize: 18, color: Colors.red[300]),
                      //       ),
                      //       // WidgetSpan(child: Icon(Icons.attach_money_rounded)),
                      //     ],
                      //   ),
                      // ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  DateTime? _convertStringToDateTime(String time) {
    DateTime? _dateTime;
    try {
      _dateTime = new DateFormat("hh:mm").parse(time);
    } catch (e) {}
    return _dateTime;
  }
}

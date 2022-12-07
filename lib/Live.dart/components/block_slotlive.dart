import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:psychological_counseling/controller/roomslotlive.dart';
import 'package:psychological_counseling/controller/slotlive.dart';
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
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Container(
        height: 180,
        width: 343,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color:
              status == "active" ? Colors.blueGrey[100] : Colors.blueGrey[500],
        ),
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Trạng thái: ',
                  style: GoogleFonts.asap(
                      textStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                Text('Chuẩn bị bắt đầu',
                    style: GoogleFonts.asap(textStyle: TextStyle(fontSize: 15)))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Thời gian bắt đầu: ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text('${format.format(timeStart!)}',
                    style: GoogleFonts.asap(textStyle: TextStyle(fontSize: 15)))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Text('Nội dung: ',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Flexible(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        Text('${slotLive.description}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.asap(
                                textStyle: TextStyle(fontSize: 15))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 28,
            ),
            Row(
              children: [
                SizedBox(
                  width: 80,
                ),
                Container(
                  width: 122,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      roomSlotLiveController.getRoomSlotLive(
                          slotLive.id, timeEnd);
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff4f0080))),
                    child: const Text(
                      "Bắt đầu Live",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    width: 122,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
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
                                              const EdgeInsets.only(right: 3),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                slotLiveController
                                                    .CancelSlotLive(
                                                        true,
                                                        slotLive.id!,
                                                        formatdate.format(
                                                            slotLive
                                                                .dateSlot!));
                                                Navigator.pop(
                                                    context, 'Xác nhận');
                                              },
                                              child: const Text('Xác nhận')),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 3),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context, 'Hủy');
                                              },
                                              child: const Text('Hủy')),
                                        ),
                                      ],
                                    ),
                                  ],
                                ));
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.pink)),
                      child: const Text(
                        "Hủy",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
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

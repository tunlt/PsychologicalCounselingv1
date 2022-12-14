import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:psychological_counseling/controller/slot.dart';
import 'package:table_calendar/table_calendar.dart';

import 'block_slot.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

final slotBookingController = Get.find<SlotbookingController>();

class _BodyState extends State<Body> {
  // String? timeConver;
  TimeOfDay? time;
  TextEditingController price = TextEditingController();
  TextEditingController timeStartController = TextEditingController();
  TimeOfDay timeStart =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  // void _selectTime() async {
  //   final TimeOfDay? timeStart = await showTimePicker(
  //     context: context,
  //     initialTime: _time,
  //     initialEntryMode: TimePickerEntryMode.input,
  //   );
  //   if (timeStart != null) {
  //     setState(() {
  //       _time = timeStart;
  //     });
  //   }
  // }
  bool checkTime(TimeOfDay startTime, TimeOfDay? time) {
    bool result = false;
    int startTimeInt = (startTime.hour * 60 + startTime.minute) * 60;
    int EndTimeInt = (time!.hour * 60 + time.minute) * 60;

    if (EndTimeInt >= startTimeInt) {
      result = true;
    } else {
      result = false;
    }
    return result;
  }

  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime _focusedDay = DateTime.now();
  // final dateFormat = DateFormat('EEEE yyyy-MMMM-dd');
  //  final dateFormat = DateFormat('EEEE yyyy-MMMM-dd'); theo tiếng anh monday...
  // final dateFormat = DateFormat.yMd();
  // formatDate(DateTime(1989, 02, 21), [yyyy, '-', mm, '-', dd])
  final format = new DateFormat("yyyy-MM-dd");
  DateTime? _selectedDay;

  void initState() {
    slotBookingController.getListSlotBooking(format.format(_focusedDay));
    super.initState();
    print(_focusedDay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 20),
            child: Card(
              child: TableCalendar(
                // locale: 'us',
                focusedDay: DateTime.now(),
                firstDay: DateTime.now(),
                // firstDay: DateTime.now().subtract(Duration(days: 7)),
                lastDay: DateTime.now().add(Duration(days: 30)),
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    slotBookingController.getListSlotBooking(format.format(
                        _focusedDay)); // update `_focusedDay` here as well
                    print(format.format(_focusedDay));
                  });
                },
                calendarFormat: _calendarFormat,
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: GetBuilder<SlotbookingController>(
                builder: (controller) => (controller.isLoading.isTrue)
                    ? const Center(child: CircularProgressIndicator())
                    : controller.listSlotBooking.isEmpty
                        ? const Center(
                            child: Text('Bạn chưa có lịch cho ngày này !'))
                        : ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (ctx, i) =>
                                BlockSlot(controller.listSlotBooking[i]),
                            itemCount: controller.listSlotBooking.length,
                          ),
              ),
            ),
          )
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            showDialog(
                context: context,
                builder: (context) => Container(
                      height: 1000,
                      width: 500,
                      child: AlertDialog(
                        title: Center(
                            child: const Text(
                                "Nhập thời gian bạn muốn tạo slot? (mỗi slot là 30 phút)")),
                        actions: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Builder(
                                        builder: (context) => TextButton.icon(
                                          icon: Icon(Icons.alarm_sharp),
                                          onPressed: () async {
                                            time = await showTimePicker(
                                              context: context,
                                              initialTime: timeStart,
                                              initialEntryMode:
                                                  TimePickerEntryMode.input,
                                            );
                                            if (time == null) {
                                              return;
                                            }
                                            setState(() {
                                              timeStart = time!;
                                            });
                                          },
                                          label: Text(
                                              '${timeStart.hour.toString().padLeft(2, '0')}:${timeStart.minute.toString().padLeft(2, '0')}'),
                                          // label:
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 60,
                                width: 150,
                                child: Center(
                                  child: Builder(
                                    builder: (context) => ElevatedButton.icon(
                                      icon: Icon(Icons.add_alarm),
                                      onPressed: () {
                                        // if (checkTime(timeStart, time)) {
                                        //   print(timeConver);
                                        slotBookingController.addSlotBooking(
                                            format.format(_focusedDay),
                                            '${timeStart.hour.toString().padLeft(2, '0')}:${timeStart.minute.toString().padLeft(2, '0')}');
                                        Navigator.of(context).pop();
                                        // } else {
                                        //     Fluttertoast.showToast(
                                        //         msg:
                                        //             "Thời gian bắt đầu phải lớn hơn thời gian hiện tại ",
                                        //         toastLength: Toast.LENGTH_SHORT,
                                        //         gravity: ToastGravity.BOTTOM,
                                        //         timeInSecForIosWeb: 1,
                                        //         backgroundColor:
                                        //             Colors.red.shade200,
                                        //         textColor: Colors.black,
                                        //         fontSize: 16.0);
                                        //   }
                                      },
                                      label: Text(
                                        'Thêm Slot',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )).then((value) => exitCode);
          },
          child: Icon(Icons.add),
        ));
  }

  // Future<void> _openTimePicker(BuildContext) async {
  //   final TimeOfDay? currentTime =
  //       await showTimePicker(context: context, initialTime: TimeOfDay.now());
  //   if (currentTime != null) {
  //     setState(() {
  //       timeStart = currentTime.format(context) as TimeOfDay;
  //     });
  //   }
  // }
}

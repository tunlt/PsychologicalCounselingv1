import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:psychological_counseling/Live.dart/components/block_slotlive.dart';
import 'package:psychological_counseling/controller/slot.dart';
import 'package:psychological_counseling/controller/slotlive.dart';
import 'package:psychological_counseling/model/slotlivestream.dart';
import 'package:table_calendar/table_calendar.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

final slotLiveController = Get.find<SlotLiveController>();

class _BodyState extends State<Body> {
  TimeOfDay timeStart =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  // String? timeConver;
  TimeOfDay? time;
  TextEditingController price = TextEditingController();
  TextEditingController timeStartController = TextEditingController();
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
    slotLiveController.getListSlotLive(format.format(_focusedDay));
    super.initState();
    print(_focusedDay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Card(
              child: TableCalendar(
                // locale: 'us',
                focusedDay: DateTime.now(),
                firstDay: DateTime.now(),
                // firstDay: DateTime.now().subtract(Duration(days: 7)),
                lastDay: DateTime.now().add(Duration(days: 7)),
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    slotLiveController.getListSlotLive(format.format(
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
            child: GetBuilder<SlotLiveController>(
              builder: (controller) => (controller.isLoading.isTrue)
                  ? const Center(child: CircularProgressIndicator())
                  : controller.listSlotLive.isEmpty
                      ? const Center(
                          child: Text('Bạn chưa có lịch cho ngày này !'))
                      : ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (ctx, i) =>
                              BlockSlotLive(controller.listSlotLive[i]),
                          itemCount: controller.listSlotLive.length,
                        ),
            ),
          )
        ]),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pink,
          onPressed: () async {
            showDialog(
                context: context,
                builder: (context) => Container(
                      height: 1000,
                      width: 500,
                      child: AlertDialog(
                        title: Center(
                            child: const Text(
                                "Nhập thời gian bạn muốn bắt đầu live? (mỗi buổi live giới hạn là 120 phút)")),
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
                                                '${timeStart.hour.toString().padLeft(2, '0')}:${timeStart.minute.toString().padLeft(2, '0')}')),
                                      ),
                                    ),
                                  ),
                                  //                              Container(
                                  //       padding: EdgeInsets.all(15),
                                  //       height:150,
                                  //       child:Center(
                                  //          child:TextField(
                                  //             controller: timeStartController, //editing controller of this TextField
                                  //             decoration: InputDecoration(
                                  //                icon: Icon(Icons.timer), //icon of text field
                                  //                labelText: "Enter Time" //label text of field
                                  //             ),
                                  //             readOnly: true,  //set it true, so that user will not able to edit text
                                  //             onTap: () async {
                                  //               TimeOfDay? pickedTime =  await showTimePicker(
                                  //                       initialTime: timeStart,
                                  //                       context: context,
                                  //                   );

                                  //               if(pickedTime != null ){
                                  //                   print(pickedTime.format(context));   //output 10:51 PM
                                  //                   DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                  //                   //converting to DateTime so that we can further format on different pattern.
                                  //                   print(parsedTime); //output 1970-01-01 22:53:00.000
                                  //                   String formattedTime = DateFormat('HH:mm').format(parsedTime);
                                  //                   print(formattedTime); //output 14:59:00
                                  //                   //DateFormat() is from intl package, you can format the time on any pattern you need.

                                  //                   setState(() {
                                  //                     timeStartController.text = formattedTime; //set the value of text field.
                                  //                   });
                                  //               }else{
                                  //                   print("Time is not selected");
                                  //               }
                                  //             },
                                  //          )
                                  //       )
                                  //     )
                                  // );
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.attach_money_rounded,
                                    color: Colors.blue,
                                  ),
                                  Expanded(
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: price,
                                      decoration: InputDecoration(
                                        hintText: "Nhập mô tả cho buổi live",
                                      ),
                                    ),
                                  )
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
                                        if (checkTime(timeStart, time)) {
                                          slotLiveController.addSlotLive(
                                              format.format(_focusedDay),
                                              '${timeStart.hour.toString().padLeft(2, '0')}:${timeStart.minute.toString().padLeft(2, '0')}',
                                              price);
                                          Navigator.of(context).pop();
                                        } else {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Thời gian bắt đầu phải lớn hơn thời gian hiện tại ",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor:
                                                  Colors.red.shade200,
                                              textColor: Colors.black,
                                              fontSize: 16.0);
                                        }
                                      },
                                      label: Text(
                                        'Thêm Slot',
                                        style: GoogleFonts.asap(),
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
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:psychological_counseling/History/components/block_history.dart';
import 'package:psychological_counseling/controller/appointment.dart';
import 'package:table_calendar/table_calendar.dart';
// import 'package:spa_booking/Screens/Appointment/components/history.dart';
// import 'package:spa_booking/Screens/Appointment/components/upcoming.dart';
// import 'package:spa_booking/controller/appointment.dart';
// import 'package:spa_booking/models/appointment.dart';

// import 'package:get/get.dart';
class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _Body();
  }
}

final AppointmentController appointmentController =
    Get.find<AppointmentController>();

class _Body extends State<Body> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final format = new DateFormat("yyyy-MM-dd");

  void initState() {
    super.initState();
    appointmentController.getListHistoryAppointment(format.format(_focusedDay));
    print("có chạy hihi ");
  }

  @override
  Widget build(BuildContext context) {
    // Service service=list.allService[0];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Lịch sử cuộc hẹn"),
          backgroundColor: Colors.purple,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Card(
                child: TableCalendar(
                  focusedDay: DateTime.now(),
                  firstDay: DateTime.now().subtract(Duration(days: 30)),
                  // firstDay: DateTime.now().subtract(Duration(days: 7)),
                  lastDay: DateTime.now(),
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekendStyle: TextStyle(color: Colors.red),
                  ),

                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay =
                          focusedDay; // update `_focusedDay` here as well
                      print(_focusedDay);
                      appointmentController.getListHistoryAppointment(
                          format.format(_focusedDay));
                    });
                  },
                  calendarFormat: _calendarFormat,
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  onPageChanged: (focusedDay) {
                    focusedDay = _focusedDay;
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: GetBuilder<AppointmentController>(
                  builder: (controller) => (controller.isLoading.isTrue)
                      ? const Center(child: CircularProgressIndicator())
                      : controller.listHistoryAppointment.isEmpty
                          ? const Center(
                              child: Text('Bạn chưa có lịch cho ngày này !'))
                          : ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (ctx, i) => BlockHistory(
                                  controller.listHistoryAppointment[i]),
                              itemCount:
                                  controller.listHistoryAppointment.length,
                            ),
                ),
              ),
            )
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:psychological_counseling/Appointment/components/block_upcoming.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../controller/appointment.dart';
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
  void initState() {
    super.initState();
    print(_focusedDay);
    appointmentController
        .getListUpcommingAppointment(format.format(_focusedDay));
  }

  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final format = new DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Cuộc hẹn sắp tới"),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Card(
                child: TableCalendar(
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
                      _focusedDay =
                          focusedDay; // update `_focusedDay` here as well
                      appointmentController.getListUpcommingAppointment(
                          format.format(_focusedDay));
                      print(_focusedDay);
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
                    print(_focusedDay);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: GetBuilder<AppointmentController>(
                builder: (controller) => (controller.isLoading.isTrue)
                    ? const Center(child: CircularProgressIndicator())
                    : controller.listUpcommingAppointment.isEmpty
                        ? const Center(
                            child: Text(
                                'Bạn không có slot nào được đặt cho ngày này !'))
                        : ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (ctx, i) => BlockUpcoming(
                                controller.listUpcommingAppointment[i]),
                            itemCount:
                                controller.listUpcommingAppointment.length,
                          ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:psychological_counseling/controller/slot.dart';
import 'package:psychological_counseling/model/appointment.dart';
import 'package:psychological_counseling/model/slotbooking.dart';

// import 'package:spa_booking/models/appointment.dart';
// import 'package:spa_booking/utils/constants.dart';
class BlockAppointmentUpcoming extends StatelessWidget {
  // UpcomingServiceBox(this.bookingService);
  BlockAppointmentUpcoming(this.appointment);
  final Appointment appointment;
  // BookingService bookingService;
  final slotBookingController = Get.find<SlotbookingController>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime? timeStart = _convertStringToDateTime(
        appointment.timeStart! + '${appointment.dateSlot!}');
    DateTime? timeEnd = _convertStringToDateTime(appointment.timeEnd!);
    final format = new DateFormat("HH:mm");
    var formatdate = DateFormat('yyyy-MM-dd');
    TextEditingController? reason = TextEditingController();
    final _reasonKey = GlobalKey<FormState>();
    return
        // onTap: () => _spaController.getSpaDetail(spa.id),
        Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: Color(0xFFF5F6F9),
                ),
                onPressed: () {
                  slotBookingController.CustomerDetailBooking(appointment.id);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "${appointment.customerName}",
                        style: GoogleFonts.asap(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.purple)),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      "${format.format(timeStart!)}" +
                          " - " +
                          "${format.format(timeEnd!)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DateTime? _convertStringToDateTime(String time) {
    DateTime? _dateTime;
    try {
      _dateTime = new DateFormat('HH:mm').parse(time);
      // print(appointment.dateSlot);
      // print("chạy date time");
      // print(_dateTime);
    } catch (e) {}
    return _dateTime;
  }

  // convert yyyy-MM-dd HH:mm
  DateTime? _convertStringToDateTime2(String time) {
    DateTime? _dateTime;
    try {
      _dateTime = new DateFormat('yyyy-MM-dd HH:mm').parse(time);
      print(_dateTime);
    } catch (e) {}
    return _dateTime;
  }
}

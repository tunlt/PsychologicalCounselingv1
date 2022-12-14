import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:psychological_counseling/History/components/body.dart';
import 'package:psychological_counseling/Schedule/components/body.dart';
import 'package:psychological_counseling/controller/roomslotbooking.dart';
import 'package:psychological_counseling/model/appointment.dart';

// import 'package:spa_booking/models/appointment.dart';
// import 'package:spa_booking/utils/constants.dart';
class BlockUpcoming extends StatelessWidget {
  // UpcomingServiceBox(this.bookingService);
  BlockUpcoming(this.appointment);
  final Appointment appointment;
  // BookingService bookingService;

  final roomslotbookingcontroller =
      Get.find<RoomSlotBookingAppointmentController>();
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
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              height: 190,
              width: 400,
              decoration: BoxDecoration(
                  color: Colors.deepPurple[50],
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 219, 193, 224),
                            ),
                            width: size.width * 0.35,
                            height: size.width * 0.35,
                            child: Container(
                              width: size.width * 0.35,
                              height: size.width * 0.35,
                              child: Image.network('${appointment.imageUrl}'),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            width: size.width * 0.45,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${appointment.customerName}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  // "Address: " + service.spa.address,
                                  "Th???i gian: " +
                                      "${format.format(timeStart!)}" +
                                      " - " +
                                      "${format.format(timeEnd!)}",
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  // "Date: " + service.spa.address,
                                  "Gi??: " + "${appointment.price}" + " Gem",
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Container(
                                    width: 120,
                                    height: 22,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_convertStringToDateTime2(
                                                formatdate.format(
                                                        appointment.dateSlot!) +
                                                    ' ' +
                                                    appointment.timeStart!)!
                                            .subtract(Duration(minutes: 5))
                                            .isBefore(DateTime.now())) {
                                          roomslotbookingcontroller
                                              .getRoomSlotBooking(
                                                  appointment.id,
                                                  _convertStringToDateTime2(
                                                      formatdate.format(
                                                              appointment
                                                                  .dateSlot!) +
                                                          ' ' +
                                                          appointment
                                                              .timeEnd!));
                                        } else {
                                          // ignore: prefer_const_constructors
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                    title:
                                                        const Text('Th??ng b??o'),
                                                    content: Text(
                                                        'B???n ch??? ???????c tham gia ph??ng tr?????c 5 ph??t( th???i gian c?? th??? b???t ?????u v??o ph??ng: ${format.format(timeStart.subtract(Duration(minutes: 5)))})'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context,
                                                                  '?????ng ??'),
                                                          child: const Text(
                                                              '?????ng ??'))
                                                    ],
                                                  ));
                                        }
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  const Color.fromARGB(
                                                      255, 109, 14, 96))),
                                      child: const Text(
                                        "G???i video",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Container(
                                    width: 120,
                                    height: 22,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        slotBookingController
                                            .CustomerDetailBooking(
                                                appointment.id);
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color.fromARGB(
                                                      255, 17, 109, 14))),
                                      child: const Text(
                                        "Chi Ti???t",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Container(
                                    width: 120,
                                    height: 22,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                                  title:
                                                      const Text('Th??ng b??o'),
                                                  content: Text(
                                                      'B???n c?? ch???c mu???n h???y l???ch h???n c???a Slot n??y'),
                                                  actions: <Widget>[
                                                    Form(
                                                      key: _reasonKey,
                                                      child: TextFormField(
                                                        controller: reason,
                                                        decoration: InputDecoration(
                                                            hintText:
                                                                'Nh???p l?? do h???y c???a b???n...'),
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return 'Vui l??ng nh???p l?? do...';
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 3),
                                                          child: ElevatedButton(
                                                              onPressed: () {
                                                                if (_reasonKey
                                                                    .currentState!
                                                                    .validate()) {
                                                                  appointmentController.CancelBookingSlot(
                                                                      reason,
                                                                      appointment
                                                                          .id!,
                                                                      formatdate
                                                                          .format(
                                                                              appointment.dateSlot!));
                                                                  Navigator.pop(
                                                                      context,
                                                                      'X??c nh???n');
                                                                }
                                                              },
                                                              child: const Text(
                                                                  'X??c nh???n')),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 3),
                                                          child: ElevatedButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context,
                                                                    'H???y');
                                                              },
                                                              child: const Text(
                                                                  'H???y')),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ));
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  const Color.fromARGB(
                                                      255, 110, 105, 108))),
                                      child: const Text(
                                        "H???y",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ]),
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
      // print("ch???y date time");
      // print(_dateTime);
    } catch (e) {}
    return _dateTime;
  }

  // convert yyyy-MM-dd HH:mm
  DateTime? _convertStringToDateTime2(String time) {
    DateTime? _dateTime;
    try {
      _dateTime = new DateFormat('yyyy-MM-dd HH:mm').parse(time);
      // print(_dateTime);
    } catch (e) {}
    return _dateTime;
  }
}

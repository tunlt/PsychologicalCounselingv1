import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:psychological_counseling/model/appointment.dart';

// import 'package:spa_booking/models/appointment.dart';
// import 'package:spa_booking/utils/constants.dart';
class BlockUpcoming extends StatelessWidget {
  // UpcomingServiceBox(this.bookingService);
  BlockUpcoming(this.appointment);
  final Appointment appointment;
  // BookingService bookingService;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime? timeStart = _convertStringToDateTime(appointment.timeStart!);
    DateTime? timeEnd = _convertStringToDateTime(appointment.timeEnd!);
    final format = new DateFormat("HH:mm");
    return GestureDetector(
      // onTap: () => _spaController.getSpaDetail(spa.id),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: EdgeInsets.all(10),
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
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: size.width * 0.30,
                              height: size.width * 0.35,
                              child: Image.network('${appointment.imageUrl}'),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              width: size.width * 0.45,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${appointment.customerName}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    // "Address: " + service.spa.address,
                                    "Thời gian: " +
                                        "${format.format(timeStart!)}" +
                                        " - " +
                                        "${format.format(timeEnd!)}",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    // "Date: " + service.spa.address,
                                    "Giá: " + "${appointment.price}" + " cua",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    width: 120,
                                    height: 22,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color.fromARGB(
                                                      255, 109, 14, 96))),
                                      child: Text(
                                        "Gọi video",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 120,
                                    height: 22,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color.fromARGB(
                                                      255, 110, 105, 108))),
                                      child: Text(
                                        "Hủy",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
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

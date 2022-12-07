import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:psychological_counseling/controller/slot.dart';
import 'package:psychological_counseling/model/appointment.dart';

// import 'package:spa_booking/models/appointment.dart';
// import 'package:spa_booking/utils/constants.dart';
// ignore: must_be_immutable
class BlockHistory extends StatelessWidget {
  BlockHistory(this.historyAppointment);
  Appointment historyAppointment;
  final detailHistoryController = Get.find<SlotbookingController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime? timeStart = _convertStringToDateTime(
        historyAppointment.timeStart! + '${historyAppointment.dateSlot!}');
    DateTime? timeEnd = _convertStringToDateTime(historyAppointment.timeEnd!);
    final format = new DateFormat("HH:mm");
    return
        // onTap: () => _spaController.getSpaDetail(spa.id),

        Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 159,
            width: 393,
            decoration: BoxDecoration(
                border: historyAppointment.status == "cancel"
                    ? Border.all(color: Colors.red)
                    : Border.all(color: Colors.green),
                color: historyAppointment.status == "overdue"
                    ? Color.fromARGB(255, 243, 65, 11)
                    : Colors.deepPurple[50],
                borderRadius: BorderRadius.circular(24)),
            child: Column(children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 219, 193, 224),
                          borderRadius: BorderRadius.all(Radius.circular(28))),
                      width: 130,
                      height: 120,
                      child: Image.network(
                        '${historyAppointment.imageUrl}',
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "${historyAppointment.customerName}",
                              maxLines: 1,
                              style: GoogleFonts.asap(
                                  textStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Text(
                              "Thời gian: ",
                              style: GoogleFonts.asap(
                                  textStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "${format.format(timeStart!)}" +
                                  " - " +
                                  "${format.format(timeEnd!)}",
                              style: GoogleFonts.asap(
                                  textStyle: TextStyle(
                                fontSize: 16,
                              )),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Text(
                              "Giá: ",
                              style: GoogleFonts.asap(
                                  textStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "${historyAppointment.price}",
                              style: GoogleFonts.asap(
                                  textStyle: TextStyle(fontSize: 16)),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              " Gem",
                              style: GoogleFonts.asap(
                                  textStyle: TextStyle(fontSize: 16)),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Container(
                            width: 122,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {
                                detailHistoryController.CustomerDetailHistory(
                                    historyAppointment.id);
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.pink[400])),
                              child: Text(
                                "Chi Tiết",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
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
}

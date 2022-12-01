import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      padding: EdgeInsets.fromLTRB(0, 0, 0, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            height: 190,
            width: 400,
            decoration: BoxDecoration(
                border: historyAppointment.status == "cancel"
                    ? Border.all(color: Colors.red)
                    : Border.all(color: Colors.green),
                color: historyAppointment.status == "overdue"
                    ? Color.fromARGB(255, 243, 65, 11)
                    : Colors.deepPurple[50],
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
                        // Container(
                        //   width: size.width * 0.30,
                        //   height: size.width * 0.35,
                        //   decoration: BoxDecoration(
                        //     color: Color.fromARGB(255, 219, 193, 224),
                        //   ),
                        //   child: Container(
                        //     width: size.width * 0.30,
                        //     height: size.width * 0.35,
                        //     child: Image.network(
                        //         '${historyAppointment.imageUrl}'),
                        //   ),
                        // ),
                        // SizedBox(
                        //   width: 8,
                        // ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 219, 193, 224),
                          ),
                          width: size.width * 0.35,
                          height: size.width * 0.35,
                          child: Container(
                            width: size.width * 0.35,
                            height: size.width * 0.35,
                            child:
                                Image.network('${historyAppointment.imageUrl}'),
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
                                "${historyAppointment.customerName}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              // Text(
                              //   // "Address: " + service.spa.address,
                              //   "Tên: " + "${hi}",
                              //   overflow: TextOverflow.ellipsis,
                              // ),
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
                                "Giá: " +
                                    "${historyAppointment.price}" +
                                    " Gem",
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Container(
                                  width: 120,
                                  height: 22,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      detailHistoryController
                                          .CustomerDetailHistory(
                                              historyAppointment.id);
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Color.fromARGB(
                                                    255, 165, 8, 170))),
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
                        )
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

import 'package:flutter/material.dart';
import 'package:psychological_counseling/model/appointment.dart';

// import 'package:spa_booking/models/appointment.dart';
// import 'package:spa_booking/utils/constants.dart';
// ignore: must_be_immutable
class BlockHistory extends StatelessWidget {
  BlockHistory(this.historyAppointment);
  Appointment historyAppointment;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      // onTap: () => _spaController.getSpaDetail(spa.id),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                              child: CircleAvatar(
                                child: Image.network(
                                    '${historyAppointment.imageUrl}'),
                              ),
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
                                        "${historyAppointment.timeStart}" +
                                        " - " +
                                        "${historyAppointment.timeEnd}",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    // "Date: " + service.spa.address,
                                    "Giá: " +
                                        "${historyAppointment.price}" +
                                        "VND",
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
                                        onPressed: () {},
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
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Container(
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
                                          "Xóa",
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
        ),
      ),
    );
  }
}

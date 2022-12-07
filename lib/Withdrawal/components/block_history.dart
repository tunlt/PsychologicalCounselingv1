import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:psychological_counseling/controller/roomslotbooking.dart';
import 'package:psychological_counseling/model/withdrawal.dart';

// import 'package:spa_booking/models/appointment.dart';
// import 'package:spa_booking/utils/constants.dart';
class BlockHistoryWithdrawal extends StatelessWidget {
  // UpcomingServiceBox(this.bookingService);
  BlockHistoryWithdrawal(this.withdrawalinfo);
  final Withdrawalinfo withdrawalinfo;
  // BookingService bookingService;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // DateTime? timeStart = _convertStringToDateTime(
    //     appointment.timeStart! + '${appointment.dateSlot!}');
    // DateTime? timeEnd = _convertStringToDateTime(appointment.timeEnd!);
    final format = new DateFormat("HH:mm");
    var formatdate = DateFormat('yyyy-MM-dd HH:mm');
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
              padding: const EdgeInsets.only(top: 16),
              height: 160,
              width: 373,
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Thời gian: ",
                                      style: GoogleFonts.asap(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "${formatdate.format(withdrawalinfo.dateCreate!)}",
                                      style: GoogleFonts.asap(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                withdrawalinfo.status == "success"
                                    ? Row(
                                        children: [
                                          Text("Trạng Thái: ",
                                              style: GoogleFonts.asap(
                                                textStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              )),
                                          Text(
                                            "Rút tiền thành công ",
                                            style: GoogleFonts.asap(
                                              textStyle: TextStyle(),
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      )
                                    : withdrawalinfo.status == "fail"
                                        ? Row(
                                            children: [
                                              Text(
                                                "Trạng Thái: ",
                                                style: GoogleFonts.asap(
                                                  textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                "Rút tiền thất bại",
                                                style: GoogleFonts.asap(
                                                  textStyle: TextStyle(),
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          )
                                        : Row(
                                            children: [
                                              Text(
                                                "Trạng Thái: ",
                                                style: GoogleFonts.asap(
                                                  textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                "Đang chờ",
                                                style: GoogleFonts.asap(
                                                  textStyle: TextStyle(),
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Số Gem: ",
                                      style: GoogleFonts.asap(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      '${withdrawalinfo.requestAmount}',
                                      style: GoogleFonts.asap(
                                        textStyle: TextStyle(),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
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
}

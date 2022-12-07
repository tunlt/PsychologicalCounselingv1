import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:psychological_counseling/controller/appointment.dart';
import 'package:psychological_counseling/controller/roomslotbooking.dart';
import 'package:psychological_counseling/controller/slot.dart';
import 'package:psychological_counseling/model/roomslotbooking.dart';

class DetailUpcomming extends StatefulWidget {
  const DetailUpcomming({super.key});

  @override
  State<DetailUpcomming> createState() => _DetailUpcommingState();
}

final roomslotbookingcontroller =
    Get.find<RoomSlotBookingAppointmentController>();
final AppointmentController appointmentController =
    Get.find<AppointmentController>();
final SlotbookingController detailController =
    Get.find<SlotbookingController>();
final _reasonKey = GlobalKey<FormState>();

final format = new DateFormat("HH:mm");
var formatdate = DateFormat('yyyy-MM-dd');
TextEditingController? reason = TextEditingController();

class _DetailUpcommingState extends State<DetailUpcomming> {
  @override
  Widget build(BuildContext context) {
    DateTime? timeStart = _convertStringToDateTime(
        detailController.listbookingDetail[0].timeStart! +
            '${detailController.listbookingDetail[0].dateOfSlot!}');
    DateTime? timeEnd = _convertStringToDateTime(
        detailController.listbookingDetail[0].timeEnd!);
    final format = new DateFormat("HH:mm");
    return Scaffold(
      appBar: AppBar(
          title: Text("Chi tiết cuộc hẹn"), backgroundColor: Color(0xff4f0080)),
      body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Container(
              height: 96,
              width: 96,
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "${detailController.listbookingDetail[0].urlImageCustomer}"),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: TextButton(
            style: TextButton.styleFrom(
              primary: Colors.purple,
              padding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              backgroundColor: Color(0xFFF5F6F9),
            ),
            onPressed: () {},
            child: Container(
              child: Row(
                children: [
                  SizedBox(width: 15),
                  Expanded(
                      child: Text(
                    "Họ và Tên:             ${detailController.listbookingDetail[0].customerName}",
                    maxLines: 1,
                  )),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: TextButton(
            style: TextButton.styleFrom(
              primary: Colors.purple,
              padding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              backgroundColor: Color(0xFFF5F6F9),
            ),
            onPressed: () {},
            child: Row(
              children: [
                SizedBox(width: 15),
                Expanded(
                    child: Text(
                  "Thời Gian:              ${format.format(timeStart!)} - ${format.format(timeEnd!)}",
                  maxLines: 1,
                )),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: TextButton(
            style: TextButton.styleFrom(
              primary: Colors.purple,
              padding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              backgroundColor: Color(0xFFF5F6F9),
            ),
            onPressed: () {},
            child: Row(
              children: [
                SizedBox(width: 15),
                Expanded(
                    child: Text(
                  "Giá:                         ${detailController.listbookingDetail[0].price} Gem",
                  maxLines: 1,
                )),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text('Kết quả khảo sát (DISC): '),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(),
          child: TextButton(
            style: TextButton.styleFrom(
              primary: Color.fromARGB(255, 20, 20, 20),
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              backgroundColor: Color(0xFFF5F6F9),
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text('Kết quả khảo sát'),
                        content: Text(
                          '${detailController.listbookingDetail[0].resultSurvey}',
                        ),
                        actions: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 3),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.pink[400]),
                                    onPressed: () {
                                      Navigator.pop(context, 'Quay lại');
                                    },
                                    child: const Text('Quay lại')),
                              ),
                            ],
                          ),
                        ],
                      ));
            },
            child: Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                        '${detailController.listbookingDetail[0].resultSurvey}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontStyle: FontStyle.italic)),
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text('Bản đồ sao: '),
            ),
          ],
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Container(
              height: 180,
              width: 180,
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "${detailController.listbookingDetail[0].urlBirthChart}"),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 12, 4, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 122,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text('Thông báo'),
                              content: Text(
                                  'Bạn có chắc muốn hủy lịch hẹn của Slot này'),
                              actions: <Widget>[
                                Form(
                                  key: _reasonKey,
                                  child: TextFormField(
                                    controller: reason,
                                    decoration: InputDecoration(
                                        hintText: 'Nhập lý do hủy của bạn...'),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Vui lòng nhập lý do...';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 3),
                                      child: ElevatedButton(
                                          onPressed: () {
                                            if (_reasonKey.currentState!
                                                .validate()) {
                                              appointmentController
                                                  .CancelBookingSlot(
                                                      reason!,
                                                      detailController
                                                          .listbookingDetail[0]
                                                          .slotId!,
                                                      formatdate.format(
                                                          detailController
                                                              .listbookingDetail[
                                                                  0]
                                                              .dateOfSlot!));
                                              Navigator.pop(
                                                  context, 'Xác nhận');
                                              Navigator.pop(context);
                                            }
                                          },
                                          child: const Text('Xác nhận')),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 3),
                                      child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context, 'Hủy');
                                          },
                                          child: const Text('Hủy')),
                                    ),
                                  ],
                                ),
                              ],
                            ));
                  },
                  child: Text('Hủy'),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    backgroundColor: Color(0xffC77398),
                  ),
                ),
              ),
              SizedBox(
                width: 3,
              ),
              Container(
                height: 40,
                width: 122,
                child: ElevatedButton(
                  onPressed: () {
                    print(timeStart);
                    print(timeEnd);
                    // if (_convertStringToDateTime2(formatdate.format(
                    //             detailController
                    //                 .listbookingDetail[0].dateOfSlot!) +
                    //         ' ' +
                    //         detailController.listbookingDetail[0].timeStart!)!
                    //     .subtract(Duration(minutes: 5))
                    //     .isBefore(DateTime.now())) {
                    //   roomslotbookingcontroller.getRoomSlotBooking(
                    //       detailController.listbookingDetail[0].slotId,
                    //       _convertStringToDateTime2(formatdate.format(
                    //               detailController
                    //                   .listbookingDetail[0].dateOfSlot!) +
                    //           ' ' +
                    //           detailController.listbookingDetail[0].timeEnd!));
                    // } else {
                    //   // ignore: prefer_const_constructors
                    //   showDialog(
                    //       context: context,
                    //       builder: (BuildContext context) => AlertDialog(
                    //             title: const Text('Thông báo'),
                    //             content: Text(
                    //                 'Bạn chỉ được tham gia phòng hợp trước 5 phút( thời gian có thể bắt đầu vào phòng: ${format.format(timeStart.subtract(Duration(minutes: 5)))})'),
                    //             actions: <Widget>[
                    //               TextButton(
                    //                   onPressed: () =>
                    //                       Navigator.pop(context, 'Đồng ý'),
                    //                   child: const Text('Đồng ý'))
                    //             ],
                    //           ));
                    // }
                    roomslotbookingcontroller.getRoomSlotBooking(
                        detailController.listbookingDetail[0].slotId,
                        _convertStringToDateTime2(formatdate.format(
                                detailController
                                    .listbookingDetail[0].dateOfSlot!) +
                            ' ' +
                            detailController.listbookingDetail[0].timeEnd!));
                  },
                  child: Text('Tham gia gọi'),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22)),
                    backgroundColor: Color(0xff4f0080),
                  ),
                ),
              )
            ],
          ),
        ),
      ])),
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

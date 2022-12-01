import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:psychological_counseling/controller/slot.dart';

class DetailUpcomming extends StatefulWidget {
  const DetailUpcomming({super.key});

  @override
  State<DetailUpcomming> createState() => _DetailUpcommingState();
}

final SlotbookingController detailController =
    Get.find<SlotbookingController>();

class _DetailUpcommingState extends State<DetailUpcomming> {
  final format = new DateFormat("HH:mm");
  @override
  Widget build(BuildContext context) {
    final format = new DateFormat("HH:mm");
    DateTime? timeStart = _convertStringToDateTime(
        detailController.listbookingDetail[0].timeStart!);
    DateTime? timeEnd = _convertStringToDateTime(
        detailController.listbookingDetail[0].timeEnd!);
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết cuộc hẹn"),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Container(
              height: 115,
              width: 115,
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
                                        backgroundColor: Colors.purple),
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
              child: Text('Bảng đồ sao: '),
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
}

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:psychological_counseling/controller/slot.dart';

class DetailHistory extends StatefulWidget {
  const DetailHistory({super.key});

  @override
  State<DetailHistory> createState() => _DetailHistoryState();
}

final SlotbookingController detailController =
    Get.find<SlotbookingController>();

class _DetailHistoryState extends State<DetailHistory> {
  final format = new DateFormat("HH:mm");
  int rate = detailController.listhistoryDetail[0].rate;
  @override
  Widget build(BuildContext context) {
    final format = new DateFormat("HH:mm");
    DateTime? timeStart = _convertStringToDateTime(
        detailController.listhistoryDetail[0].timeStart!);
    DateTime? timeEnd = _convertStringToDateTime(
        detailController.listhistoryDetail[0].timeEnd!);
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết cuộc hẹn đã kết thúc"),
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
                        "${detailController.listhistoryDetail[0].imageUrlCustomer}"),
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
                  "Họ và Tên:             ${detailController.listhistoryDetail[0].customerName}",
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
                  "Giá:                         ${detailController.listhistoryDetail[0].price} Gem",
                  maxLines: 1,
                )),
              ],
            ),
          ),
        ),
        detailController.listhistoryDetail[0].status == "success"
            ? Padding(
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
                        "Trạng Thái:            Thành công",
                        maxLines: 1,
                      )),
                    ],
                  ),
                ),
              )
            : Padding(
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
                          child: detailController.listhistoryDetail[0].status ==
                                  "overdue"
                              ? Text(
                                  "Trạng Thái:            Đã quá hạn",
                                  maxLines: 1,
                                )
                              : Text(
                                  "Trạng Thái:            Đã hủy",
                                  maxLines: 1,
                                )),
                    ],
                  ),
                ),
              ),
        detailController.listhistoryDetail[0].status == "success" ||
                detailController.listhistoryDetail[0].status == "cancel"
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child:
                        detailController.listhistoryDetail[0].status == "cancel"
                            ? Text(
                                'Lý do hủy: ',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold),
                              )
                            : Text(
                                'Đánh giá của khách hàng: ',
                                style: TextStyle(fontSize: 20),
                              ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 40),
                    child: Text(
                      'Bạn đã bỏ lỡ buổi hẹn! ',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
        detailController.listhistoryDetail[0].status == "success"
            ? detailController.listhistoryDetail[0].rate == 0
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 25),
                              child: Text(
                                  'Chưa có bình luận từ ${detailController.listhistoryDetail[0].customerName}',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontSize: 20,
                                      color: Colors.brown))),
                        ],
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Row(
                          children: [
                            Text('Đánh giá: '),
                            RatingBarIndicator(
                              rating: rate.toDouble(),
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 20.0,
                              direction: Axis.horizontal,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: Row(
                          children: [
                            Text(
                                'Bình luận: ${detailController.listhistoryDetail[0].feedback}',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontStyle: FontStyle.italic, fontSize: 15)),
                          ],
                        ),
                      ),
                    ],
                  )
            : detailController.listhistoryDetail[0].status == "cancel"
                ? Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: detailController
                                    .listhistoryDetail[0].reasonConsultant ==
                                null
                            ? Row(
                                children: [
                                  Text(
                                    '${detailController.listhistoryDetail[0].reasonCustomer}',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Text(
                                    '${detailController.listhistoryDetail[0].reasonConsultant}',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Row(
                          children: [
                            Text(''),
                          ],
                        ),
                      ),
                    ],
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

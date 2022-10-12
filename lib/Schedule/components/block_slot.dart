import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:psychological_counseling/model/slotbooking.dart';

// ignore: must_be_immutable
class BlockSlot extends StatelessWidget {
  BlockSlot(this.slotBooking);
  final SlotBooking slotBooking;
  String status = "active";
  @override
  Widget build(BuildContext context) {
    DateTime? timeStart = _convertStringToDateTime(slotBooking.timeStart!);
    DateTime? timeEnd = _convertStringToDateTime(slotBooking.timeEnd!);
    final format = new DateFormat("HH:mm");
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          height: 50,
          width: 350,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: status == "active"
                    ? Colors.blueGrey[200]
                    : Colors.blueGrey[500],
              ),
              child: TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.access_time_rounded),
                label: Center(
                  child: Text(
                    '${format.format(timeStart!)} - ${format.format(timeEnd!)}',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
            ),
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

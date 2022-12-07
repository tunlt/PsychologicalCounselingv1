import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:psychological_counseling/Withdrawal/components/block_history.dart';
import 'package:psychological_counseling/components/bottombar_consultant.dart';
import 'package:psychological_counseling/controller/withdrawal.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../controller/appointment.dart';

class BodyHistoryWithdrawal extends StatefulWidget {
  const BodyHistoryWithdrawal({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _BodyHistoryWithdrawal();
  }
}

final AppointmentController appointmentController =
    Get.find<AppointmentController>();

class _BodyHistoryWithdrawal extends State<BodyHistoryWithdrawal> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final format = new DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Lịch sử giao dịch"),
        backgroundColor: Color(0xff4f0080),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (() => Get.to(NavigationPage())),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 24),
              child: GetBuilder<WithdrawalController>(
                builder: (controller) => (controller.isLoading.isTrue)
                    ? const Center(child: CircularProgressIndicator())
                    : controller.listWithdrawalHistory.isEmpty
                        ? const Center(
                            child: Text('Bạn chưa có lịch sử rút tiền nào !'))
                        : ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (ctx, i) => BlockHistoryWithdrawal(
                                controller.listWithdrawalHistory[i]),
                            itemCount: controller.listWithdrawalHistory.length,
                          ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

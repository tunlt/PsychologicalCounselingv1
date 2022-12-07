import 'package:get/get.dart';
import 'package:psychological_counseling/Withdrawal/withdrawal_screen.dart';
import 'package:psychological_counseling/model/bank.dart';
import 'package:psychological_counseling/model/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class BankController extends GetxController {
  var isLoading = true.obs;
  late List<Bank> listBank = <Bank>[].obs;
  late List<String> listNameBank = <String>[].obs;
  Future<List<Bank>> getListBank() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int? id = prefs.getInt('id');
    try {
      print('chạy Bank Controller');
      isLoading(true);
      final response = await http.get(
        Uri.parse('https://api.vietqr.io/v2/banks'),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var bank = bankResponseFromJson(jsonString);
        if (bank.data != null) {
          listBank = bank.data as List<Bank>;

          for (var x in listBank) {
            listNameBank.add(x.shortName! + ' ' + x.name!);
            print(listNameBank);
          }
          Get.to(WithdrawalScreen());
          update();
        }
      }
    } catch (error) {
      print('lỗi Bank controller 2');
      error.printError();
    } finally {
      isLoading(false);
    }
    return listBank;
  }
}

import 'package:get/get.dart';
import 'package:psychological_counseling/model/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class DashboardController extends GetxController {
  var isLoading = true.obs;
  late List<Dashboard> listDasBoard = <Dashboard>[].obs;
  Future<List<Dashboard>> getDashboard() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int? id = prefs.getInt('id');
    try {
      print('chay Dashboard');
      print(id);
      isLoading(true);
      final response = await http.get(
          Uri.parse(
              'https://psycteamv2.azurewebsites.net/api/ReportDashboard/DashboardConsultant?id=${id}'),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var dashboard = dashboardResponseFromJson(jsonString);
        if (dashboard.data != null) {
          listDasBoard = dashboard.data as List<Dashboard>;
          update();
        }
      }
    } catch (error) {
      print('chạy dashboard');
    } finally {
      isLoading(false);
    }
    return listDasBoard;
  }
}

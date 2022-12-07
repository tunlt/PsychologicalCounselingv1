import 'package:get/get.dart';
import 'package:psychological_counseling/model/wallet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class WalletController extends GetxController {
  var isLoading = true.obs;
  late List<Wallet> listWallet = <Wallet>[].obs;
  Future<List<Wallet>> getWallet() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int? id = prefs.getInt('id');
    try {
      print('chay wallet');
      print(id);
      isLoading(true);
      final response = await http.get(
          Uri.parse(
              'https://psycteamv2.azurewebsites.net/api/Wallets/getbyconsultantid?id=${id}'),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var wallet = walletResponseFromJson(jsonString);
        if (wallet.data != null) {
          listWallet = wallet.data as List<Wallet>;
          update();
        }
      }
    } catch (error) {
      print('chạy dashboard');
    } finally {
      isLoading(false);
    }
    return listWallet;
  }
}

import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  var tabIndex = 0;
  var currentdate = DateTime.now().obs;
  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }
}

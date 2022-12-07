import 'package:get/get.dart';
import 'package:psychological_counseling/Home/home_screen.dart';
import 'package:psychological_counseling/Live.dart/live_screen.dart';
import 'package:psychological_counseling/Profile/profile_screen.dart';
import 'package:psychological_counseling/components/bottombar_consultant.dart';

class AppPage {
  static List<GetPage> router = [
    GetPage(name: home, page: () => const HomeScreenConsultant()),
    GetPage(name: navbar, page: () => NavigationPage()),
    GetPage(name: profile, page: () => const ProfileConsultantScreen()),
    GetPage(name: live, page: () => const LiveScreen()),
  ];

  static getnavbar() => navbar;
  static gethome() => home;
  static getlive() => live;
  static getprofile() => profile;

  static String navbar = '/';
  static String home = '/home_screen';
  static String profile = 'profile_screen';
  static String live = 'live_screen';
}

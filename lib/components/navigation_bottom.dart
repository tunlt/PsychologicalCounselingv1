
// import 'package:flutter/material.dart';
// import 'package:psychological_counseling/Appointment/appointment_screen.dart';
// import 'package:psychological_counseling/Home/home_screen.dart';

// class BottomBarConsultant extends StatefulWidget {
//   const BottomBarConsultant({super.key});

//   @override
//   State<BottomBarConsultant> createState() => _BottomBarConsultant();
// }

// class _BottomBarConsultant extends State<BottomBarConsultant> {
//   int _selectedIndex = 0;
//   static const TextStyle optionStyle =
//       TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
//   List pages = [
//     HomeScreenConsultant(),
//     AppointmentScreen(),
//     AppointmentScreen(),
//     AppointmentScreen(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // body: ,
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.business),
//             label: 'Business',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.school),
//             label: 'School',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.amber[800],
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

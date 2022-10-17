// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'dart:developer';
// import 'package:agora_rtc_engine/rtc_engine.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:psychological_counseling/callconsultant/components/bodyCall.dart';

// class Body extends StatefulWidget {
//   const Body({super.key});

//   @override
//   State<Body> createState() => _BodyState();
// }

// class _BodyState extends State<Body> {
//   final _chanelController = TextEditingController();
//   bool _validateError = false;
//   ClientRole? _role = ClientRole.Broadcaster;
//   @override
//   void dispose() {
//     _chanelController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Video call"),
//       ),
//       body: SingleChildScrollView(
//           child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           children: <Widget>[
//             const SizedBox(height: 20),
//             TextField(
//               controller: _chanelController,
//               decoration: InputDecoration(
//                   errorText:
//                       _validateError ? "ChanelName is mandatory: " : null),
//             ),
//             RadioListTile(
//               title: Text("Broad caster"),
//               onChanged: (ClientRole? value) {
//                 setState(() {
//                   _role = value;
//                 });
//               },
//               value: ClientRole.Broadcaster,
//               groupValue: _role,
//             ),
//             RadioListTile(
//               title: Text("Client caster"),
//               onChanged: (ClientRole? value) {
//                 setState(() {
//                   _role = value;
//                 });
//               },
//               value: ClientRole.Audience,
//               groupValue: _role,
//             ),
//             ElevatedButton(
//               onPressed: Onjoin,
//               child: const Text("join"),
//               style: ElevatedButton.styleFrom(
//                   minimumSize: const Size(double.infinity, 40)),
//             )
//           ],
//         ),
//       )),
//     );
//   }

//   Future<void> Onjoin() async {
//     setState(() {
//       _chanelController.text.isEmpty
//           ? _validateError = true
//           : _validateError = false;
//     });
//     if (_chanelController.text.isNotEmpty) {
//       await _handleCameraandMic(Permission.camera);
//       await _handleCameraandMic(Permission.microphone);
//       await Get.to(BodyCall(
//         chanelName: _chanelController.text,
//         role: _role,
//       ));
//     }
//   }
//   // Future<void> Onjoin(
//   //   String? chanelName,
//   //   ClientRole? role,
//   // ) async {
//   //   if (chanelName!.isEmpty) {
//   //     await _handleCameraandMic(Permission.camera);
//   //     await _handleCameraandMic(Permission.microphone);
//   //     await Get.to(BodyCall(
//   //       chanelName: chanelName,
//   //       role: role,
//   //     ));
//   //   }
//   // }

//   // Future<void> _handleCameraandMic(Permission permission) async {
//   //   final status = await permission.request();
//   //   print(status);
//   // }
//   Future<void> _handleCameraandMic(Permission permission) async {
//     final status = await permission.request();
//     log(status.toString());
//   }
// }

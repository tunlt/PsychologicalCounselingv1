// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
        title: Text("Thông báo"),
        backgroundColor: Colors.purple[200],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
              children: [
                Container(
                    // child: ,
                    ),
              ],
            ),
          ),
        ]),
      ),
    );

    //   Scaffold(
    //     appBar: appBar(),
    //     body: Listview(),
    //   );
    // }

    // PreferredSizeWidget appBar() {
    //   return AppBar(
    //     title: Text("Thông báo"),
    //   );
    // }

    // // ignore: non_constant_identifier_names
    // Widget Listview() {
    //   return ListView.separated(
    //       itemBuilder: (context, index) {
    //         return listViewItem(index);
    //       },
    //       separatorBuilder: (context, index) {
    //         return Divider(
    //           height: 0,
    //         );
    //       },
    //       itemCount: 15);
    // }

    // Widget prefixIcon() {
    //   return Container(
    //     height: 50,
    //     width: 50,
    //     padding: EdgeInsets.all(10),
    //     decoration:
    //         BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade300),
    //     child: Icon(
    //       Icons.notifications,
    //       size: 25,
    //       color: Colors.grey.shade700,
    //     ),
    //   );
    // }

    // Widget listViewItem(int index) {
    //   return Container(
    //     margin: EdgeInsets.only(left: 10),
    //     child: Row(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         prefixIcon(),
    //         Expanded(
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               message(index),
    //               timeAndDate(index),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    // Widget message(int index) {
    //   double textSize = 14;
    //   return Container(
    //     child: RichText(
    //       maxLines: 3,
    //       overflow: TextOverflow.ellipsis,
    //       text: TextSpan(
    //         text: 'Message',
    //         style: TextStyle(
    //             fontSize: textSize,
    //             color: Colors.black,
    //             fontWeight: FontWeight.bold),
    //       ),
    //     ),
    //   );
    // }

    // Widget timeAndDate(int index) {
    //   return Container(
    //     margin: EdgeInsets.only(top: 5),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Text('2022-01-23', style: TextStyle(fontSize: 10)),
    //         Text('07:10', style: TextStyle(fontSize: 10))
    //       ],
    //     ),
    //   );
  }
}

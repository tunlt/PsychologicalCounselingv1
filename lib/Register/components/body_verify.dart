import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psychological_counseling/controller/verifyemail.dart';

class BodyVerify extends StatefulWidget {
  BodyVerify({Key? key}) : super(key: key);

  @override
  _BodyVerifyState createState() => _BodyVerifyState();
}

class _BodyVerifyState extends State<BodyVerify> {
  @override
  TextEditingController num1 = TextEditingController();
  TextEditingController num2 = TextEditingController();
  TextEditingController num3 = TextEditingController();
  TextEditingController num4 = TextEditingController();

  final VerifyEmailController _controller = Get.find<VerifyEmailController>();
  Widget build(BuildContext context) {
    void changevalue(bool? last, first, String value) {
      if (value.length == 1 && last == false) {
        FocusScope.of(context).nextFocus();
      }
      if (value.length == 0 && first == false) {
        FocusScope.of(context).previousFocus();
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                width: 200,
                height: 200,
                // decoration: BoxDecoration(
                //   color: Colors.deepPurple.shade50,
                // ),
                child: Image.asset(
                  'assets/logo/logo.png',
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'Xác Minh Danh Tính',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Nhập mã code của bạn",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 28,
              ),
              Container(
                width: 600,
                padding: EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 65,
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: TextField(
                              autofocus: true,
                              onChanged: (value) {
                                changevalue(true, false, value);
                              },
                              controller: num1,
                              showCursor: false,
                              readOnly: false,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              decoration: InputDecoration(
                                counter: Offstage(),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5, color: Colors.black12),
                                    borderRadius: BorderRadius.circular(12)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5, color: Colors.purple),
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 65,
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: TextField(
                              autofocus: true,
                              onChanged: (value) {
                                changevalue(false, false, value);
                              },
                              controller: num2,
                              showCursor: false,
                              readOnly: false,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              decoration: InputDecoration(
                                counter: Offstage(),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5, color: Colors.black12),
                                    borderRadius: BorderRadius.circular(12)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5, color: Colors.purple),
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 65,
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: TextField(
                              autofocus: true,
                              onChanged: (value) {
                                changevalue(false, false, value);
                              },
                              controller: num3,
                              showCursor: false,
                              readOnly: false,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              decoration: InputDecoration(
                                counter: Offstage(),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5, color: Colors.black12),
                                    borderRadius: BorderRadius.circular(12)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5, color: Colors.purple),
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 65,
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: TextField(
                              autofocus: true,
                              onChanged: (value) {
                                changevalue(false, true, value);
                              },
                              controller: num4,
                              showCursor: false,
                              readOnly: false,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              decoration: InputDecoration(
                                counter: Offstage(),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5, color: Colors.black12),
                                    borderRadius: BorderRadius.circular(12)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5, color: Colors.purple),
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () =>
                            _controller.verifyEmail(num1, num2, num3, num4),
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.purple),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Gửi',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                "Bạn chưa nhận được mã code",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                "Gửi lại",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldNum({bool? first, last}) {
    return Container(
      height: 65,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1.5, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1.5, color: Colors.purple),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
  // return Scaffold(
  //     backgroundColor: Colors.purple,
  //     body: Container(
  //       child: Center(
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           mainAxisSize: MainAxisSize.max,
  //           children: [
  //             Container(
  //               height: 60,
  //               width: 60,
  //               child: TextField(
  //                 decoration: InputDecoration(
  //                     border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(20),
  //                 )),
  //               ),
  //             ),
  //             Container(
  //               height: 60,
  //               width: 60,
  //               child: TextField(
  //                 decoration: InputDecoration(
  //                   border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(20)),
  //                 ),
  //               ),
  //             ),
  //             Container(
  //               height: 60,
  //               width: 60,
  //               child: TextField(
  //                 decoration: InputDecoration(
  //                   border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(20)),
  //                 ),
  //               ),
  //             ),
  //             Container(
  //               height: 60,
  //               width: 60,
  //               child: TextField(
  //                 decoration: InputDecoration(
  //                   border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(20)),
  //                 ),
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ));
}

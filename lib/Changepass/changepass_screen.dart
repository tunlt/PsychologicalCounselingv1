import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:psychological_counseling/controller/checkpasswallet.dart';

class ChangepassScreen extends StatefulWidget {
  const ChangepassScreen({Key? key}) : super(key: key);

  @override
  _ChangepassScreenState createState() => _ChangepassScreenState();
}

final checkpassWalletController = Get.find<CheckpassWalletController>();

class _ChangepassScreenState extends State<ChangepassScreen> {
  TextEditingController oldPassAcc = TextEditingController();
  TextEditingController newPassAcc = TextEditingController();
  TextEditingController oldPassAccWallet = TextEditingController();
  TextEditingController newPassWallet = TextEditingController();
  TextEditingController confirmPassAcc = TextEditingController();
  TextEditingController confirmPassWallet = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff4f0080),
            bottom: TabBar(
              tabs: [
                Tab(
                  text: 'Đổi mật khẩu đăng nhập',
                ),
                Tab(text: 'Đổi mật khẩu rút tiền'),
              ],
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            title: Text('Tài Khoản của tôi'),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 19),
                        child: Row(
                          children: [
                            Text(
                              '*',
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                        child: Container(
                          height: 60,
                          width: 400,
                          child: TextField(
                            obscureText: true,
                            controller: oldPassAcc,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.purple[20],
                              border: OutlineInputBorder(),
                              labelText: 'Mật khẩu hiện tại',
                              hintText: 'Nhập mật khẩu... ',
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.blueGrey, //color of divider
                        height: 2, //height spacing of divider
                        thickness: 2, //thickness of divier line
                        indent: 15, //spacing at the start of divider
                        endIndent: 15, //spacing at the end of divider
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 19),
                        child: Row(
                          children: [
                            Text(
                              '*',
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          height: 60,
                          width: 400,
                          child: TextField(
                            controller: newPassAcc,
                            obscureText: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.purple[20],
                              border: OutlineInputBorder(),
                              labelText: 'Mật khẩu mới',
                              hintText: 'Nhập mật khẩu... ',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 19),
                        child: Row(
                          children: [
                            Text(
                              '*',
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          height: 60,
                          width: 400,
                          child: TextField(
                            obscureText: true,
                            controller: confirmPassAcc,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.purple[20],
                              border: OutlineInputBorder(),
                              labelText: 'Nhập lại mật khẩu mới',
                              hintText: 'Nhập mật khẩu... ',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Container(
                          child: Center(
                            child: ElevatedButton.icon(
                              icon: Icon(
                                Icons.save,
                                color: Colors.white,
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.purple),
                              ),
                              label: Text('Lưu'),
                              onPressed: () {
                                showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Thông báo'),
                                      content: const Text(
                                          'Bạn có chắc chắn muốn đổi mật khẩu mới'),
                                      actions: <Widget>[
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                          ),
                                          child: const Text('Không'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                          ),
                                          child: const Text('Có'),
                                          onPressed: () {
                                            if (newPassAcc.text ==
                                                confirmPassAcc.text) {
                                              checkpassWalletController
                                                  .ChangePassAccount(
                                                      oldPassAcc, newPassAcc);

                                              Navigator.of(context).pop();
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "mật khẩu nhập lại không đúng",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 43, 204, 22),
                                                  textColor: Colors.black,
                                                  fontSize: 16.0);
                                              Navigator.of(context).pop();
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 19),
                        child: Row(
                          children: [
                            Text(
                              '*',
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                        child: Container(
                          height: 60,
                          width: 400,
                          child: TextField(
                            obscureText: true,
                            controller: oldPassAccWallet,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.purple[20],
                              border: OutlineInputBorder(),
                              labelText: 'Mật khẩu đăng nhập hiện tại',
                              hintText: 'Nhập mật khẩu... ',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 19),
                        child: Row(
                          children: [
                            Text(
                              '*',
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          height: 60,
                          width: 400,
                          child: TextField(
                            obscureText: true,
                            controller: newPassWallet,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.purple[20],
                              border: OutlineInputBorder(),
                              labelText: 'Mật khẩu rút tiền mới',
                              hintText: 'Nhập mật khẩu... ',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 19),
                        child: Row(
                          children: [
                            Text(
                              '*',
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          height: 60,
                          width: 400,
                          child: TextField(
                            obscureText: true,
                            controller: confirmPassWallet,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.purple[20],
                              border: OutlineInputBorder(),
                              labelText: 'Nhập lại mật khẩu rút tiền mới',
                              hintText: 'Nhập mật khẩu... ',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Container(
                          child: Center(
                            child: ElevatedButton.icon(
                              icon: Icon(
                                Icons.save,
                                color: Colors.white,
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.purple),
                              ),
                              label: Text('Lưu'),
                              onPressed: () {
                                showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Thông báo'),
                                      content: const Text(
                                          'Bạn có chắc chắn muốn đổi mật khẩu rút tiền? '),
                                      actions: <Widget>[
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                          ),
                                          child: const Text('Không'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                          ),
                                          child: const Text('Có'),
                                          onPressed: () {
                                            print(newPassWallet.text);
                                            print(confirmPassWallet);
                                            if (newPassWallet.text ==
                                                confirmPassWallet.text) {
                                              checkpassWalletController
                                                  .ChangePassWallet(
                                                      oldPassAccWallet,
                                                      newPassWallet);

                                              Navigator.of(context).pop();
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "mật khẩu nhập lại không đúng",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 43, 204, 22),
                                                  textColor: Colors.black,
                                                  fontSize: 16.0);
                                              Navigator.of(context).pop();
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

import 'dart:ui';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:psychological_counseling/controller/bank.dart';
import 'package:psychological_counseling/controller/wallet.dart';
import 'package:psychological_counseling/controller/withdrawal.dart';
import 'package:psychological_counseling/model/bank.dart';
import 'package:skeletons/skeletons.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

List<String> items = [
  "VietinBank Ngân hàng TMCP Công thương Việt Nam",
  "Vietcombank Ngân hàng TMCP Ngoại Thương Việt Nam, "
];

final withdrawalController = Get.find<WithdrawalController>();

TextEditingController bankname = TextEditingController();
TextEditingController banknumber = TextEditingController();
TextEditingController amount = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController fullname = TextEditingController();

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  final listbank = Get.find<BankController>();
  final listwallet = Get.find<WalletController>();
  void initState() {
    super.initState();
    items = listbank.listNameBank;
    print(items);
  }

  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ví của tôi'),
          backgroundColor: Color(0xff4f0080),
        ),
        body: Obx(
          () => SafeArea(
              child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    listwallet.isLoading == true
                        ? SkeletonItem(
                            child: Container(
                              height: 120,
                              width: 400,
                              decoration: BoxDecoration(
                                  color: Color(0xff4f0080),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(22))),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.wallet_outlined,
                                      size: 90,
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(height: 25),
                                        Row(
                                          children: [
                                            Text(
                                              "SỐ DƯ",
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  color: Colors.amber[200]),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "10000 Gem",
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  color: Color.fromARGB(
                                                      255, 21, 122, 25)),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ]),
                            ),
                          )
                        : Container(
                            height: 120,
                            width: 400,
                            decoration: BoxDecoration(
                                color: Color(0xff4f0080),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(22))),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.wallet_outlined,
                                    size: 90,
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(height: 25),
                                      Row(
                                        children: [
                                          Text(
                                            "SỐ DƯ",
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.amber[200]),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${listwallet.listWallet[0].gem} Gem",
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Color.fromARGB(
                                                    255, 21, 122, 25)),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ]),
                          ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),

                //Skeleton
                listbank.isLoading == true
                    ? SkeletonItem(
                        child: Container(
                          height: 500,
                          width: 400,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 187, 183, 183),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22))),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(7),
                                child: Text(
                                  'Yêu cầu rút tiền',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.zero,
                                child: Container(
                                  height: 420,
                                  width: 350,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 226, 224, 216),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Column(children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 30, left: 30, right: 30),
                                      child: Row(
                                        children: [
                                          Text(
                                            '*',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          Text(
                                            'Tên chủ tài khoản: ',
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(0),
                                      child: Container(
                                        width: 300,
                                        height: 40,
                                        child: TextField(
                                          decoration: InputDecoration(
                                              hintText:
                                                  'Nhập tên chủ tài khoản...',
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20))),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 3, left: 30, right: 30),
                                      child: Row(
                                        children: [
                                          Text(
                                            '*',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          Text(
                                            'Số tài khoản: ',
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(0),
                                      child: Container(
                                        width: 300,
                                        height: 40,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              hintText: 'Nhập số tài khoản...',
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20)))),
                                          validator: (value) {
                                            if (value!.isEmpty) {}
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 3, left: 30, right: 30),
                                      child: Row(
                                        children: [
                                          Text(
                                            '*',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          Text(
                                            'Tên ngân hàng: ',
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(0),
                                      child: Container(
                                        width: 300,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton2(
                                            isExpanded: true,
                                            hint: Text(
                                              '  Chọn ngân hàng ',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color:
                                                    Theme.of(context).hintColor,
                                              ),
                                            ),
                                            items: items
                                                .map((item) =>
                                                    DropdownMenuItem<String>(
                                                      value: item,
                                                      child: Flexible(
                                                        child: Text(
                                                          '  ' + item,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ),
                                                    ))
                                                .toList(),
                                            value: selectedValue,
                                            onChanged: (value) {
                                              setState(() {
                                                selectedValue = value as String;
                                              });
                                            },
                                            buttonHeight: 40,
                                            buttonWidth: 200,
                                            itemHeight: 40,
                                            dropdownMaxHeight: 200,
                                            searchController:
                                                textEditingController,
                                            searchInnerWidget: Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8,
                                                bottom: 4,
                                                right: 8,
                                                left: 8,
                                              ),
                                              child: TextFormField(
                                                controller:
                                                    textEditingController,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    horizontal: 10,
                                                    vertical: 8,
                                                  ),
                                                  hintText:
                                                      'Nhập tên ngân hàng...',
                                                  hintStyle: const TextStyle(
                                                      fontSize: 12),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            searchMatchFn: (item, searchValue) {
                                              return (item.value
                                                  .toString()
                                                  .contains(searchValue));
                                            },
                                            //This to clear the search value when you close the menu
                                            onMenuStateChange: (isOpen) {
                                              if (!isOpen) {
                                                textEditingController.clear();
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 3, left: 30, right: 30),
                                      child: Row(
                                        children: [
                                          Text(
                                            '*',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          Text(
                                            'Số Gem cần rút: ',
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(0),
                                      child: Container(
                                        width: 300,
                                        height: 40,
                                        child: TextField(
                                          decoration: InputDecoration(
                                              hintText: '1 Gem = 1000 VND',
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20)))),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 5, left: 30, right: 30),
                                      child: Row(
                                        children: [
                                          Text(
                                            '* Số Gem mỗi lần rút từ 50 - 200 Gem',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.pink)),
                                            onPressed: () {},
                                            child: Text(
                                              'Gửi yêu cầu',
                                              style: TextStyle(fontSize: 25),
                                            ))
                                      ],
                                    ),
                                  ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Form(
                        key: _formKey,
                        child: Container(
                          height: 500,
                          width: 400,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 187, 183, 183),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22))),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(7),
                                  child: Text(
                                    'Yêu cầu rút tiền',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(6),
                                  child: Container(
                                    height: 420,
                                    width: 350,
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 226, 224, 216),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Column(children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 30, right: 30),
                                        child: Row(
                                          children: [
                                            Text(
                                              '*',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                            Text(
                                              'Tên chủ tài khoản: ',
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(0),
                                        child: Container(
                                          width: 300,
                                          height: 40,
                                          child: TextFormField(
                                            controller: fullname,
                                            decoration: InputDecoration(
                                                hintText:
                                                    'Nhập tên chủ tài khoản...',
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20))),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Vui lòng nhập tên tài khoản';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 3, left: 30, right: 30),
                                        child: Row(
                                          children: [
                                            Text(
                                              '*',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                            Text(
                                              'Số tài khoản: ',
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(0),
                                        child: Container(
                                          width: 300,
                                          height: 40,
                                          child: TextFormField(
                                            controller: banknumber,
                                            decoration: InputDecoration(
                                                hintText:
                                                    'Nhập số tài khoản...',
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20)))),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Vui lòng nhập số tài khoản';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 3, left: 30, right: 30),
                                        child: Row(
                                          children: [
                                            Text(
                                              '*',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                            Text(
                                              'Tên ngân hàng: ',
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.all(0),
                                          child: Container(
                                            width: 300,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                border: Border.all(width: 1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton2(
                                                isExpanded: true,
                                                hint: Text(
                                                  '  Chọn ngân hàng ',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                  ),
                                                ),
                                                items: items
                                                    .map((item) =>
                                                        DropdownMenuItem<
                                                            String>(
                                                          value: item,
                                                          child: Text(
                                                            '  ' + item,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ))
                                                    .toList(),
                                                value: selectedValue,
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedValue =
                                                        value as String;
                                                    bankname.text =
                                                        selectedValue!;
                                                  });
                                                },
                                                buttonHeight: 40,
                                                buttonWidth: 200,
                                                itemHeight: 40,
                                                dropdownMaxHeight: 200,
                                                searchController:
                                                    textEditingController,
                                                searchInnerWidget: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 8,
                                                    bottom: 4,
                                                    right: 8,
                                                    left: 8,
                                                  ),
                                                  child: TextFormField(
                                                    controller:
                                                        textEditingController,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                        horizontal: 10,
                                                        vertical: 8,
                                                      ),
                                                      hintText:
                                                          'Nhập tên ngân hàng...',
                                                      hintStyle:
                                                          const TextStyle(
                                                              fontSize: 12),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    ),
                                                    validator: (value) {
                                                      if (value ==
                                                          '  Chọn ngân hàng ') {
                                                        return 'Vui lòng chọn ngân hàng';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                searchMatchFn:
                                                    (item, searchValue) {
                                                  return (item.value
                                                      .toString()
                                                      .contains(searchValue));
                                                },
                                                //This to clear the search value when you close the menu
                                                // onMenuStateChange: (isOpen) {
                                                //   if (!isOpen) {
                                                //     textEditingController.clear();
                                                //   }
                                                // },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 3, left: 30, right: 30),
                                        child: Row(
                                          children: [
                                            Text(
                                              '*',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                            Text(
                                              'Số Gem cần rút: ',
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(0),
                                        child: Container(
                                          width: 300,
                                          height: 40,
                                          // ignore: prefer_const_constructors
                                          child: TextFormField(
                                            controller: amount,
                                            decoration: const InputDecoration(
                                                hintText: '1 Gem = 1000 VND',
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20)))),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Vui lòng nhập số Gem';
                                              } else {
                                                if (int.parse(value) > 2000 ||
                                                    int.parse(value) < 50) {
                                                  print("chạy check Gem ");
                                                  return 'Số Gem từ 50 - 2000';
                                                } else {
                                                  return null;
                                                }
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 3, left: 30, right: 30),
                                        child: Row(
                                          children: [
                                            Text(
                                              '*',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                            Text(
                                              'Mật khẩu rút tiền ',
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(0),
                                        child: Container(
                                          width: 300,
                                          height: 40,
                                          // ignore: prefer_const_constructors
                                          child: TextFormField(
                                            controller: password,
                                            obscureText: true,
                                            decoration: const InputDecoration(
                                                hintText:
                                                    'Nhập mật khẩu rút tiền',
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20)))),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Vui lòng nhập mật khẩu';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 5, left: 30, right: 30),
                                        child: Row(
                                          children: [
                                            Text(
                                              '* ',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                            Text(
                                              'là không được để trống ',
                                              style: TextStyle(
                                                  color: Colors.blue[300]),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 5, left: 30, right: 30),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Lưu ý: Số Gem mỗi lần rút từ 50 - 200 Gem',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.pink[400])),
                                              onPressed: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  withdrawalController
                                                      .WithdrawalConsultant(
                                                          bankname,
                                                          password,
                                                          amount,
                                                          banknumber,
                                                          fullname);
                                                  // ignore: unrelated_type_equality_checks
                                                  if (withdrawalController
                                                          .checkrequest ==
                                                      true) {
                                                    withdrawalController
                                                        .getListwithdrawalInfo();
                                                  } else {}
                                                }
                                              },
                                              child: Text(
                                                'Gửi yêu cầu',
                                                style: TextStyle(fontSize: 25),
                                              ))
                                        ],
                                      ),
                                    ]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          )),
        ));
  }
}

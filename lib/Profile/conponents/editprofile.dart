import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:psychological_counseling/Profile/profile_screen.dart';
import 'package:psychological_counseling/controller/consultant.dart';

class EditProfileConsultant extends StatefulWidget {
  const EditProfileConsultant({super.key});

  @override
  State<EditProfileConsultant> createState() => _EditProfileConsultantState();
}

final _consultant = Get.find<ConsultantController>();

class _EditProfileConsultantState extends State<EditProfileConsultant> {
  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();

  // final format = DateFormat("yyyy-MM-dd");
  File? _imageFile;
  String? male;
  String? gender;
  late DateTime dob;
  String? urlImage;
  var inputFormat = DateFormat('yyyy-MM-dd');

  void initState() {
    super.initState();
    _consultant.getConsultantDetail(true);
    // ignore: unrelated_type_equality_checks
    // if (consultantController.isLoading == true) {
    _fullname.text = '${_consultant.consultantdetail[0].fullName}';
    _address.text = '${_consultant.consultantdetail[0].address}';
    dob = _convertStringToDateTime('${_consultant.consultantdetail[0].dob}')!;
    _dob.text = DateFormat("yyyy-MM-dd").format(dob);
    _email.text = '${_consultant.consultantdetail[0].email}';
    gender = '${_consultant.consultantdetail[0].gender}';
    _phone.text = '${_consultant.consultantdetail[0].phone}';
    // } else {}
  }

  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _consultant.loadImageConsultant(_imageFile!);
        urlImage = _consultant.urlImage;
        Navigator.of(context).pop();
      });
    }
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _consultant.loadImageConsultant(_imageFile!);
        urlImage = _consultant.urlImage;
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.to(ProfileConsultantScreen());
            }),
        title: Text("Thông tin của tôi"),
        backgroundColor: Colors.purple[200],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 25),
              child: Container(
                height: 115,
                width: 115,
                child: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                        backgroundImage: _imageFile == null
                            ? NetworkImage(
                                "${_consultant.consultantdetail[0].imageUrl}")
                            : FileImage(_imageFile!) as ImageProvider),
                    Positioned(
                      right: -16,
                      bottom: 0,
                      child: SizedBox(
                        height: 46,
                        width: 46,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: BorderSide(color: Colors.white),
                            ),
                            primary: Colors.purple,
                            backgroundColor: Color(0xFFF5F6F9),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Center(
                                          child:
                                              const Text("Chọn ảnh của bạn?")),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            TextButton.icon(
                                              icon: Icon(
                                                Icons.camera_alt_outlined,
                                                color: Colors.blueGrey[200],
                                              ),
                                              label: Center(
                                                  child: Text(
                                                'Chọn ảnh từ camera',
                                              )),
                                              onPressed: () {
                                                _getFromCamera();
                                              },
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            TextButton.icon(
                                              icon: Icon(
                                                Icons.photo_album_outlined,
                                                color: Colors.blueGrey[200],
                                              ),
                                              label: Center(
                                                child: Text('Chọn ảnh có sẵn'),
                                              ),
                                              onPressed: () {
                                                _getFromGallery();
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    )).then((value) => exitCode);
                          },
                          child: Icon(Icons.edit),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 13),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.purple,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                      child: TextField(
                    controller: _fullname,
                  )),
                ],
              ),
            ),
            SizedBox(height: 13),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
              child: Row(
                children: [
                  Icon(
                    Icons.email,
                    color: Colors.purple,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                      child: TextField(
                    controller: _email,
                    readOnly: true,
                  )),
                ],
              ),
            ),
            SizedBox(height: 13),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
              child: Row(
                children: [
                  Icon(
                    Icons.phone_android_rounded,
                    color: Colors.purple,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                      child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _phone,
                  )),
                ],
              ),
            ),
            SizedBox(height: 13),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.purple,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                      child: TextField(
                    controller: _address,
                  )),
                ],
              ),
            ),
            SizedBox(height: 13),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_month_sharp,
                    color: Colors.purple,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                      child: TextField(
                    controller: _dob, //editing controller of this TextField

                    readOnly:
                        true, //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          helpText: "Ngày sinh của bạn",
                          context: context,
                          initialDate: dob,
                          firstDate: DateTime.now().subtract(const Duration(
                              days: 365 *
                                  150)), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime.now());

                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                        setState(() {
                          dob = _convertStringToDateTime(formattedDate)!;
                          print(dob);
                          _dob.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                  )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 200,
                    child: RadioListTile<String>(
                      title: const Text('Nam'),
                      value: "Male",
                      groupValue: gender,
                      onChanged: (String? value) {
                        setState(() {
                          gender = value!;
                          print(gender);
                        });
                      },
                    ),
                  ),

                  Container(
                    width: 200,
                    child: RadioListTile<String>(
                      title: const Text('Nữ'),
                      value: "Female",
                      groupValue: gender,
                      onChanged: (String? value) {
                        setState(() {
                          gender = value!;
                          print(gender);
                        });
                      },
                    ),
                  ),
                  // Icon(
                  //   Icons.calendar_month_sharp,
                  //   color: Colors.purple,
                  // ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                child: Center(
                  child: ElevatedButton.icon(
                    icon: Icon(
                      Icons.save,
                      color: Colors.white,
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.purple),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(
                            color: Colors.white,
                            width: 0.2,
                          ),
                        ),
                      ),
                    ),
                    label: Text('Lưu'),
                    onPressed: () {
                      print(urlImage);
                      _consultant.UpdateConsultant(_fullname, _address, _email,
                          gender, urlImage, inputFormat.format(dob), _phone);
                      print(urlImage);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DateTime? _convertStringToDateTime(String time) {
    DateTime? _dateTime;
    try {
      _dateTime = new DateFormat("yyyy-MM-dd").parse(time);
    } catch (e) {}
    return _dateTime;
  }
}

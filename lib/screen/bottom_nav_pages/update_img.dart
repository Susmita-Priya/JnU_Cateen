import 'dart:io';

import 'package:bfmh_canteen/constant/Appcolours.dart';
import 'package:bfmh_canteen/screen/bottom_nav_pages/profile.dart';
import 'package:bfmh_canteen/stuff/editfood.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:bfmh_canteen/stuff/home.dart';
import 'package:bfmh_canteen/widgets/custombutton.dart';

class upimg extends StatefulWidget {
  const upimg({super.key});

  @override
  State<upimg> createState() => _upimgState();
}

class _upimgState extends State<upimg> {
  File? _image;
  final imagePicker = ImagePicker();
  late String url;
  String? _fileName;

  Future uploadimg() async {
    Reference ref =
        FirebaseStorage.instance.ref('profile/').child('$_fileName');
    await ref.putFile(_image!);
    url = await ref.getDownloadURL();
    print(url);
  }

  updateData() async {
    Reference ref =
        FirebaseStorage.instance.ref('profile/').child('$_fileName');
    await ref.putFile(_image!);
    url = await ref.getDownloadURL();
    print(url);
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-form-data");
    return _collectionRef
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({
          "img": url,
        })
        .then((value) => {
              Fluttertoast.showToast(msg: "Successfully Updated"),
              //   Navigator.push(
              //       context, MaterialPageRoute(builder: (_) => Profile()))
            })
        .catchError((error) => print("something is wrong. $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.orange,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding:
                    EdgeInsets.only(left: 90, top: 10, right: 30, bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //Container(
                    //   decoration: const BoxDecoration(
                    //       gradient: LinearGradient(colors: [
                    //     Color.fromARGB(255, 59, 59, 59),
                    //     Color(0xFFFF9900),
                    //   ], begin: Alignment.topCenter, end: Alignment.center)),
                    // ),
                    CircleAvatar(
                      backgroundImage: const AssetImage('assets/upimg.png'),
                      radius: MediaQuery.of(context).size.height / 10,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 50,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                'upimg'.tr,
                style: TextStyle(
                    fontSize: 25.sp,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                  padding:
                      EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          width: 170,
                          height: 170,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: _image == null
                                        ? const Center(
                                            child: Text(""),
                                          )
                                        : Image.file(_image!))
                              ],
                            ),
                          )),
                      ElevatedButton(
                        onPressed: () async {
                          final pick = await imagePicker.pickImage(
                              source: ImageSource.gallery);
                          setState(() {
                            if (pick != null) {
                              _image = File(pick.path);
                              _fileName = pick.name;
                              if (_image != null) {
                                uploadimg().whenComplete(() => SnackBar(
                                      content: Text("Picture is selected"),
                                      duration: Duration(milliseconds: 400),
                                    ));
                              }
                            } else {
                              final snackBar = SnackBar(
                                content: Text(""),
                                duration: Duration(milliseconds: 400),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(primary: Colors.grey),
                        child: Text(
                          'slc'.tr,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 50.h,
                      ),

                      // elevated button
                      customButton('update'.tr, () => updateData()),
                    ],
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}

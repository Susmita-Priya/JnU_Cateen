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

class update extends StatefulWidget {
  var data;
  update(this.data);

  @override
  State<update> createState() => _updateState();
}

class _updateState extends State<update> {
  // @override
  // void initState() {
  //   super.initState();
  //   _loadUserData();
  // }

  // File? _image;
  // final imagePicker = ImagePicker();
  // late String url;
  // String? _fileName;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _dobController;
  late TextEditingController _genderController;
  late TextEditingController _ageController;
  late TextEditingController _imgController;
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    String currentUserEmail = FirebaseAuth.instance.currentUser!.email!;
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection("users-form-data")
        .doc(currentUserEmail)
        .get();

    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
    setState(() {
      _nameController = TextEditingController(text: userData["name"]);
      _emailController = TextEditingController(text: userData["email"]);
      _phoneController = TextEditingController(text: userData["phone"]);
      _dobController = TextEditingController(text: userData["dob"]);
      _genderController = TextEditingController(text: userData["gender"]);
      _ageController = TextEditingController(text: userData["age"]);
      _imgController = TextEditingController();
    });
  }

  // Future uploadimg() async {
  //   Reference ref =
  //       FirebaseStorage.instance.ref('profile/').child('$_fileName');
  //   await ref.putFile(_image!);
  //   url = await ref.getDownloadURL();
  //   print(url);
  // }

  updateData() async {
    // Reference ref =
    //     FirebaseStorage.instance.ref('profile/').child('$_fileName');
    // await ref.putFile(_image!);
    // url = await ref.getDownloadURL();
    // print(url);
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-form-data");
    return _collectionRef
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({
          "name": _nameController.text,
          "email": _emailController.text,
          "phone": _phoneController.text,
          "dob": _dobController.text,
          "gender": _genderController.text,
          "age": _ageController.text,
        })
        .then((value) => {
              Fluttertoast.showToast(msg: "Successfully Updated"),
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Profile()))
            })
        .catchError((error) => print("something is wrong. $error"));
  }

  @override
  Widget build(BuildContext context) {
    _loadUserData();
    return Scaffold(
      //backgroundColor: Colors.orange,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'uptitle'.tr,
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
                        backgroundImage: NetworkImage(
                          widget.data["img"],
                          //fit: BoxFit.cover,
                        ),
                        radius: MediaQuery.of(context).size.height / 10,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 50,
                      ),
                    ],
                  ),
                ),

                // Container(
                //     width: 250,
                //     height: 250,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(20),
                //     ),
                //     child: Center(
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Expanded(
                //               child: Image.network(
                //             widget._productt["product-img"],
                //             fit: BoxFit.cover,
                //           )),
                //         ],
                //       ),
                //     )),
                SizedBox(
                  height: 5.h,
                ),
                // myTextField(
                //     "enter your name", TextInputType.text, _nameController),
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_circle),
                    iconColor: Colors.orange,
                    labelText: 'name'.tr,
                    labelStyle: TextStyle(
                      fontSize: 20.sp,
                      color: Appcolours.Orange,
                    ),
                    // hintText: "Enter your name",
                    // hintStyle: TextStyle(
                    //   fontSize: 14.sp,
                    //   color: Colors.grey,
                    // ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                // myTextField("enter your phone number", TextInputType.number,
                //     _phoneController),
                TextFormField(
                  readOnly: true,
                  controller: _emailController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    iconColor: Colors.orange,
                    labelText: 'email'.tr,
                    labelStyle: TextStyle(
                      fontSize: 20.sp,
                      color: Appcolours.Orange,
                    ),
                    // hintText: "Enter your Email again",
                    // hintStyle: TextStyle(
                    //   fontSize: 14.sp,
                    //   color: Colors.grey,
                    // ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    iconColor: Colors.orange,
                    labelText: 'phn'.tr,
                    labelStyle: TextStyle(
                      fontSize: 20.sp,
                      color: Appcolours.Orange,
                    ),
                    // hintText: "Enter your phone number",
                    // hintStyle: TextStyle(
                    //   fontSize: 14.sp,
                    //   color: Colors.grey,
                    // ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  controller: _dobController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    icon: Icon(Icons.baby_changing_station_sharp),
                    iconColor: Colors.orange,
                    labelText: 'dob'.tr,
                    labelStyle: TextStyle(
                      fontSize: 20.sp,
                      color: Appcolours.Orange,
                    ),
                    // hintText: "Enter your date of birth",
                    // hintStyle: TextStyle(
                    //   fontSize: 14.sp,
                    //   color: Colors.grey,
                    // ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  controller: _genderController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    icon: Icon(Icons.woman),
                    iconColor: Colors.orange,
                    // hintText: "choose your gender",
                    // hintStyle: TextStyle(
                    //   fontSize: 14.sp,
                    //   color: Colors.grey,
                    // ),
                    labelText: 'gender'.tr,
                    labelStyle: TextStyle(
                      fontSize: 20.sp,
                      color: Appcolours.Orange,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock_clock),
                    iconColor: Colors.orange,
                    labelText: 'age'.tr,
                    labelStyle: TextStyle(
                      fontSize: 20.sp,
                      color: Appcolours.Orange,
                    ),
                    // hintText: "Enter your age",
                    // hintStyle: TextStyle(
                    //   fontSize: 14.sp,
                    //   color: Colors.grey,
                    // ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                // Container(
                //     width: 50,
                //     height: 50,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(20),
                //     ),
                //     child: Center(
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Expanded(
                //               child: _image == null
                //                   ? const Center(
                //                       child: Text(""),
                //                     )
                //                   : Image.file(_image!))
                //         ],
                //       ),
                //     )),
                // ElevatedButton(
                //   onPressed: () async {
                //     final pick = await imagePicker.pickImage(
                //         source: ImageSource.gallery);
                //     setState(() {
                //       if (pick != null) {
                //         _image = File(pick.path);
                //         _fileName = pick.name;
                //         if (_image != null) {
                //           uploadimg().whenComplete(() => SnackBar(
                //                 content: Text("Picture is selected"),
                //                 duration: Duration(milliseconds: 400),
                //               ));
                //         }
                //       } else {
                //         final snackBar = SnackBar(
                //           content: Text(""),
                //           duration: Duration(milliseconds: 400),
                //         );
                //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
                //       }
                //     });
                //   },
                //   style: ElevatedButton.styleFrom(primary: Colors.grey),
                //   child: Text(
                //     'upimg'.tr,
                //     style: TextStyle(
                //       fontSize: 15,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
                // // myTextField("enter your phone number", TextInputType.number,
                // // //     _phoneController),
                // // Container(
                // //   // flex: 3,
                // // child:

                // // ),
                // // ElevatedButton(
                // //   onPressed: () async {
                // //     final pick = await imagePicker.pickImage(
                // //         source: ImageSource.gallery);
                // //     setState(() {
                // //       if (pick != null) {
                // //         _image = File(pick.path);
                // //         _fileName = pick.name;
                // //         if (_image != null) {
                // //           uploadimg().whenComplete(() => SnackBar(
                // //                 content: Text("Picture is selected"),
                // //                 duration: Duration(milliseconds: 400),
                // //               ));
                // //         }
                // //       } else {
                // //         final snackBar = SnackBar(
                // //           content: Text("No image selected"),
                // //           duration: Duration(milliseconds: 400),
                // //         );
                // //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
                // //       }
                // //     });
                // //   },
                // //   style: ElevatedButton.styleFrom(primary: Colors.grey),
                // //   child: Text(
                // //     "Add Image",
                // //     style: TextStyle(
                // //       fontSize: 15,
                // //       color: Colors.white,
                // //     ),
                // //   ),
                // // ),

                // // TextField(
                // //   controller: _feedbackController,
                // //   keyboardType: TextInputType.multiline,
                // //   maxLines: null,
                // //   minLines: 1,
                // //   decoration: InputDecoration(
                // //     icon: Icon(Icons.feedback),
                // //     iconColor: Colors.orange,
                // //     labelText: 'Feedback',
                // //     labelStyle: TextStyle(
                // //       fontSize: 20.sp,
                // //       color: Colors.orange,
                // //     ),
                // //     hintText: "Give Feedback",
                // //     hintStyle: TextStyle(
                // //       fontSize: 14.sp,
                // //       color: Colors.grey,
                // //     ),
                // //   ),
                // // ),

                SizedBox(
                  height: 50.h,
                ),

                // elevated button
                customButton('update'.tr, () => updateData()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

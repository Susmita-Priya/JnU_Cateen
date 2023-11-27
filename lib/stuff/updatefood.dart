import 'dart:io';

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

class updatefood extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  updatefood(
    this.documentSnapshot,
  );

  @override
  State<updatefood> createState() => _updatefoodState();
}

class _updatefoodState extends State<updatefood> {
  File? _image;
  final imagePicker = ImagePicker();
  String? url;
  String? _fileName;

  late TextEditingController _nameController;
  late TextEditingController _desController;
  late TextEditingController _availController;
  late TextEditingController _imgController;
  late TextEditingController _priceController;
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    // String currentUserEmail = FirebaseAuth.instance.currentUser!.email!;
    // DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
    //     .collection("users-form-data")
    //     .doc(currentUserEmail)
    //     .get();

    // Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
    setState(() {
      _nameController =
          TextEditingController(text: widget.documentSnapshot["product-name"]);
      _desController = TextEditingController(
          text: widget.documentSnapshot["product-description"]);
      _availController = TextEditingController(
          text: widget.documentSnapshot["product-available"]);
      _imgController = TextEditingController();
      _priceController = TextEditingController(
          text: widget.documentSnapshot["product-price"].toString());
    });
  }

  Future uploadimg() async {
    Reference ref =
        FirebaseStorage.instance.ref('product-images/').child('$_fileName');
    await ref.putFile(_image!);
    url = await ref.getDownloadURL();
    print(url);
  }

  updateData() async {
    // Reference ref =
    //     FirebaseStorage.instance.ref('product-images/').child('$_fileName');
    // await ref.putFile(_image!);
    // url = await ref.getDownloadURL();
    // print(url);
    String field1Value = _nameController.text;
    String field2Value = _availController.text;
    String field3Value = _priceController.text;
    if (field1Value.isEmpty || field2Value.isEmpty || field3Value.isEmpty) {
      // Show error message and return without running query
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text('Field cannot be empty'),)):
      Fluttertoast.showToast(msg: 'Field cannot be empty');
      return;
    }
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("products");
    return _collectionRef
        .doc(widget.documentSnapshot.id)
        .update({
          "product-name": _nameController.text,
          "product-description": _desController.text,
          "product-available": _availController.text,
          "product-price": int.parse(_priceController.text),
        })
        .then((value) => {
              Fluttertoast.showToast(msg: "Successfully Updated"),
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (_) => editfood()))
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'uftitle'.tr,
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
                          widget.documentSnapshot["product-img"],
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
                    // border: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(8)),
                    icon: Icon(Icons.fastfood),
                    iconColor: Colors.orange,
                    labelText: 'iname'.tr + "*",
                    labelStyle: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.orange,
                    ),
                    // hintText: "Enter the item name",
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
                  controller: _desController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(8)),
                    icon: Icon(Icons.description),
                    iconColor: Colors.orange,
                    labelText: 'des'.tr,
                    labelStyle: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.orange,
                    ),
                    // hintText: "Enter the item description",
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
                  controller: _availController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(8)),
                    icon: Icon(Icons.event_available_rounded),
                    iconColor: Colors.orange,
                    labelText: 'avail'.tr + "*",
                    labelStyle: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.orange,
                    ),
                    // hintText: "Enter the item availablity",
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
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(8)),
                    icon: Icon(Icons.price_change),
                    iconColor: Colors.orange,
                    labelText: 'iprice'.tr + "*",
                    labelStyle: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.orange,
                    ),
                    // hintText: "Enter the item price",
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
                //           content: Text("No image selected"),
                //           duration: Duration(milliseconds: 400),
                //         );
                //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
                //       }
                //     });
                //   },
                //   style: ElevatedButton.styleFrom(primary: Colors.grey),
                //   child: Text(
                //     "update Image",
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

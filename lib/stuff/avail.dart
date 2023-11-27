import 'package:flutter/cupertino.dart';
import 'package:bfmh_canteen/stuff/trace.dart';
import 'package:bfmh_canteen/stuff/trace1.dart';
import 'package:bfmh_canteen/widgets/fetchfeedback.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class avail extends StatefulWidget {
  const avail({super.key});

  @override
  State<avail> createState() => _availState();
}

class _availState extends State<avail> {
  List _products = [];
  var _firestoreInstance = FirebaseFirestore.instance;

  Widget fetchData(String collectionName) {
    return Container(
      child: Stack(
        children: <Widget>[
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(collectionName)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Something is wrong"),
                );
              }
              return ListView.builder(
                  itemCount:
                      snapshot.data == null ? 0 : snapshot.data!.docs.length,
                  itemBuilder: (_, index) {
                    DocumentSnapshot _documentSnapshot =
                        snapshot.data!.docs[index];
                    return Card(
                      elevation: 5,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(_documentSnapshot['product-img']),
                        ),
                        title: Text(
                          "${_documentSnapshot['product-name']}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 19.h),
                        ),
                        subtitle: Text(
                          "${_documentSnapshot['product-price'].toString()}tK" +
                              "\n(${_documentSnapshot['product-available']})",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange),
                        ),
                        trailing: SizedBox(
                            width: 170,
                            height: 70,
                            child: Row(
                              children: [
                                Text("Available?",
                                    style: TextStyle(
                                        //fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                Row(
                                  children: [
                                    // Text("Return?",
                                    //     style: TextStyle(
                                    //         //fontWeight: FontWeight.bold,
                                    //         color: Colors.black)),
                                    IconButton(
                                        onPressed: (() {
                                          FirebaseFirestore.instance
                                              .collection(collectionName)
                                              .doc(_documentSnapshot.id)
                                              .update({
                                            "product-available": "available",
                                          }).then((value) => {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Successfully updated"),
                                                  });
                                        }),
                                        icon: Icon(Icons.check_circle,
                                            color: Color.fromARGB(
                                                255, 15, 148, 3))),
                                    IconButton(
                                        onPressed: (() {
                                          FirebaseFirestore.instance
                                              .collection(collectionName)
                                              .doc(_documentSnapshot.id)
                                              .update({
                                            "product-available":
                                                "not available",
                                          }).then((value) => {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Successfully updated"),
                                                  });
                                        }),
                                        icon: Icon(
                                            CupertinoIcons.clear_circled_solid,
                                            color: Color.fromARGB(
                                                255, 148, 14, 3))),
                                  ],
                                ),
                              ],
                            )),
                      ),
                    );
                  });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text(
            'foodav'.tr,
          ),
          elevation: 0,
        ),
        body: SafeArea(
          child: fetchData("products"),
        ));
  }
}

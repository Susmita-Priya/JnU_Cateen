import 'package:bfmh_canteen/widgets/fetchfeedback.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class cancel extends StatefulWidget {
  const cancel({super.key});

  @override
  State<cancel> createState() => _cancelState();
}

class _cancelState extends State<cancel> {
  Widget fetchtrace() {
    String? email1 = FirebaseAuth.instance.currentUser!.email;
    return Container(
      child: Stack(
        children: <Widget>[
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("cancel")
                .where('email', isEqualTo: email1)
                //.orderBy('time', descending: true)
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
                          backgroundImage: AssetImage("assets/profile.png"),
                        ),
                        //fit: BoxFit.cover,

                        title: Text(
                          'orderid'.tr + " : ${_documentSnapshot['order_id']}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                              fontSize: 19.h),
                        ),
                        subtitle: Text(
                          "(${_documentSnapshot['time']})"
                          "\n${_documentSnapshot['item']}"
                          " = ${_documentSnapshot['total'].toString()} TK"
                          "\n${_documentSnapshot['status']} "
                          "\n\n${_documentSnapshot['ret']}"
                          "\n\n(Contact with us within 24 hours)",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        // trailing: GestureDetector(
                        //   child: Text("\n\n${_documentSnapshot['ret']}",
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.bold,
                        //           color: Colors.black)),
                        // ),

                        // onTap: () {
                        //   FirebaseFirestore.instance
                        //       .collection(collectionName)
                        //       .doc(_documentSnapshot.id)
                        //       .delete()
                        //       .then((value) => {
                        //             Fluttertoast.showToast(
                        //                 msg: "Successfully Deleted"),
                        //           });
                        // },
                      ),
                    );
                    // );
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
        title: Text(
          'cancelo'.tr,
          style: TextStyle(
            //fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.orange,
        //automaticallyImplyLeading: false,
        //centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SafeArea(
        //     child: Column(
        //   children: [
        //     Text("hghhghj"),
        //     SizedBox(
        //       height: 165,
        //     ),
        //     Container(
        //       child: fetchData("users-cart-items"),
        //     )
        //   ],
        // )
        child: fetchtrace(),
        //customButton("Continue", () => sendUserDataToDB()),
      ),
    );
  }
}

import 'package:bfmh_canteen/stuff/trace.dart';
import 'package:bfmh_canteen/stuff/trace1.dart';
import 'package:bfmh_canteen/widgets/fetchfeedback.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class cancel1 extends StatefulWidget {
  const cancel1({super.key});

  @override
  State<cancel1> createState() => _cancel1State();
}

class _cancel1State extends State<cancel1> {
  Widget trsee(String collectionName) {
    String? email1 = FirebaseAuth.instance.currentUser!.email;
    return Container(
      child: Stack(
        children: <Widget>[
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(collectionName)
                .orderBy("time", descending: true)
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
                            'orderid'.tr +
                                " : ${_documentSnapshot['order_id']}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                                fontSize: 19.h),
                          ),
                          subtitle: Text(
                            "${_documentSnapshot['time']}"
                                    "\n(${_documentSnapshot['item']})"
                                    // "\n${_documentSnapshot['total']} TK"
                                    "\n\n" +
                                'status'.tr +
                                " : ${_documentSnapshot['status']}"
                                    "\n${_documentSnapshot['ret']}",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: SizedBox(
                            width: 100,
                            height: 90,
                            child: Row(
                              children: [
                                Text("Return?",
                                    style: TextStyle(
                                        //fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                IconButton(
                                    onPressed: (() {
                                      FirebaseFirestore.instance
                                          .collection(collectionName)
                                          .doc(_documentSnapshot.id)
                                          .update({
                                        "ret": "Returned Money",
                                      }).then((value) => {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Successfully updated"),
                                              });
                                    }),
                                    icon: Icon(Icons.check_circle,
                                        color:
                                            Color.fromARGB(255, 15, 148, 3))),
                              ],
                            ),
                          ),
                        ));
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
        child: trsee("cancel"),
        //customButton("Continue", () => sendUserDataToDB()),
      ),
    );
  }
}

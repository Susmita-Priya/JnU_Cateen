import 'package:bfmh_canteen/screen/bottom_nav_pages/trace_food.dart';
import 'package:bfmh_canteen/stuff/trace.dart';
import 'package:bfmh_canteen/widgets/fetchfeedback.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class order extends StatefulWidget {
  const order({super.key});

  @override
  State<order> createState() => _orderState();
}

class _orderState extends State<order> {
  Widget orderlist(String collectionName) {
    String? email1 = FirebaseAuth.instance.currentUser!.email;
    return Container(
      child: Stack(
        children: <Widget>[
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(collectionName)
                .orderBy('time', descending: true)
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
                            'orderid'.tr + ": ${_documentSnapshot['order_id']}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                                fontSize: 16.h),
                          ),
                          subtitle: Text(
                            // "\n" +
                            //     _documentSnapshot['email'] +
                            // "\n"
                            "(${_documentSnapshot['time']})"
                            "\n${_documentSnapshot['item_name']}", //+
                            // "\nTotal = ${_documentSnapshot['total'].toString()} TK",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          trailing: SizedBox(
                            width: 50,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => trace(
                                                  _documentSnapshot
                                                  // name: widget._product['product-name'],
                                                  // des: widget._product['product-description'],
                                                  // avail: widget._product['product-available'],
                                                  // price: widget._product['product-price'],

                                                  )));
                                    },
                                    icon: const Icon(
                                      Icons.arrow_circle_right,
                                      color: Color.fromARGB(137, 0, 102, 9),
                                    )),
                              ],
                            ),
                          )),
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
        title: Text(
          'myorder'.tr,
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
        child: orderlist("order"),
        //customButton("Continue", () => sendUserDataToDB()),
      ),
    );
  }
}

import 'package:bfmh_canteen/screen/bottom_nav_controller.dart';
import 'package:bfmh_canteen/screen/bottom_nav_pages/QRcode.dart';
import 'package:bfmh_canteen/screen/bottom_nav_pages/bkash.dart';
import 'package:bfmh_canteen/screen/bottom_nav_pages/payment.dart';
import 'package:bfmh_canteen/utils/style.dart';
import 'package:bfmh_canteen/widgets/custombutton.dart';
import 'package:bfmh_canteen/widgets/fetchProducts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';

import 'dart:developer' as dev;
//import 'package:example/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bkash/flutter_bkash.dart';
import 'package:get/get.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _amountController = TextEditingController();
  num? total = 0;
  String? item;
  List<String> product = [];
  String? qrr;

  // @override
  // void initState() {
  //   Amount();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'mycart'.tr,
            style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
                shadows: [
                  BoxShadow(
                    blurRadius: 15,
                    color: Colors.black,
                    offset: Offset(3, 3),
                  )
                ]),
          ),
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          centerTitle: true,
          // iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: SafeArea(
          child: fetchData("users-cart-items", total),
        ),
        bottomNavigationBar: Container(
            height: 40,
            width: double.infinity,
            padding: const EdgeInsets.only(top: 0, left: 114, right: 114),
            child: TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  backgroundColor: Colors.orange),
              child: Text(
                'checkout'.tr,
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => bkash()));
              },
              // String amount = _amountController.text.trim();
              // String amount = total.toString();
              // String intent = "authorization";

              // if (amount.isEmpty) {
              //   // if the amount is empty then show the snack-bar
              //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              //       content: Text(
              //           "Amount is empty. Without amount you can't pay. Try again")));
              //   return;
              // }

              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => BkashPayment(
              /// depend isSandbox (true/false)
              //   isSandbox: true,

              //   /// amount of your bkash payment
              //   amount: amount,

              //   /// intent would be (sale / authorization)
              //   intent: intent,
              //   // accessToken: '', /// if the user have own access token for verify payment
              //   // currency: 'BDT',
              //   /// bkash url for create payment, when you implement on you project then it be change as your production create url, [when you send it on sandbox mode, send it as empty string '' or anything]
              //   createBKashUrl:
              //       'https://merchantserver.sandbox.bka.sh/api/checkout/v1.2.0-beta/payment/create',

              //   /// bkash url for execute payment, , when you implement on you project then it be change as your production create url, [when you send it on sandbox mode, send it as empty string '' or anything]
              //   executeBKashUrl:
              //       'https://merchantserver.sandbox.bka.sh/api/checkout/v1.2.0-beta/payment/execute',

              //   /// for script url, when you implement on production the set it live script js (https://scripts.pay.bka.sh/versions/1.2.0-beta/checkout/bKash-checkout-pay.js)
              //   scriptUrl:
              //       'https://scripts.sandbox.bka.sh/versions/1.2.0-beta/checkout/bKash-checkout-sandbox.js',

              //   /// the return value from the package
              //   /// status => 'paymentSuccess', 'paymentFailed', 'paymentError', 'paymentClose'
              //   /// data => return value of response
              //   paymentStatus: (status, data) {
              //     dev.log('return status => $status');
              //     dev.log('return data => $data');

              //     /// when payment success
              //     if (status == 'paymentSuccess') {
              //       if (data['transactionStatus'] == 'Completed') {
              //         sendUserDataToDB();
              //         deletee();
              //         Style.basicToast('Payment Success');
              //       }
              //     }

              //     /// when payment failed
              //     else if (status == 'paymentFailed') {
              //       if (data.isEmpty) {
              //         Style.errorToast('Payment Failed');
              //       } else if (data[0]['errorMessage'].toString() !=
              //           'null') {
              //         Style.errorToast(
              //             "Payment Failed ${data[0]['errorMessage']}");
              //       } else {
              //         Style.errorToast("Payment Failed");
              //       }
              //     }

              //     // when payment on error
              //     else if (status == 'paymentError') {
              //       Style.errorToast(
              //           jsonDecode(data['responseText'])['error']);
              //     }

              //     // when payment close on demand closed the windows
              //     else if (status == 'paymentClose') {
              //       if (data == 'closedWindow') {
              //         Style.errorToast(
              //             'Failed to payment, closed screen');
              //       } else if (data == 'scriptLoadedFailed') {
              //         Style.errorToast('Payment screen loading failed');
              //       }
              //     }
              //     // back to screen to pop()
              //     Navigator.of(context).pop();
              //   },
              // )));
              //     },
              //   ),
              // ),
              // BottomNavigationBar(
              //   items: <BottomNavigationBarItem>[
              //     BottomNavigationBarItem(
              //         label: " Payment ",
              //         icon: IconButton(
              //             onPressed: () async {

              //               sendUserDataToDB();
              //             },
              //             icon: Icon(Icons.payment))),
              //     BottomNavigationBarItem(
              //       label: "",
              //       icon: Text("Total = " + total.toString()),
              //       //   icon: IconButton(
              //       //   onPressed: () async {
              //       //   await deletee();
              //       // },
              //       // icon: Icon(Icons.payment)),
              //     ),
              //   ],
              // ),
            )));
  }

  // Amount() async {
  //   QuerySnapshot qn = await FirebaseFirestore.instance
  //       .collection("users-cart-items")
  //       .doc(FirebaseAuth.instance.currentUser!.email)
  //       .collection("items")
  //       .get();
  //   setState(() {
  //     if (total != null) {
  //       for (int i = 0; i < qn.docs.length; i++) {
  //         total = (total! + qn.docs[i]["price"]);
  //         product.add(qn.docs[i]["name"]);
  //       }
  //       print(total.toString());
  //       item = product.join(",");
  //     } else {}
  //   });
  //   print(item);
  //   return total.toString();
  // }

  // deletee() async {
  //   total = null;
  //   FirebaseFirestore.instance
  //       .collection("users-cart-items")
  //       .doc(FirebaseAuth.instance.currentUser!.email)
  //       .collection("items")
  //       .get()
  //       .then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       doc.reference.delete();
  //     });
  //   });
  //   // .doc()
  //   // .delete()
  //   // .then((value) => {});
  // }

  // sendUserDataToDB() async {
  //   final FirebaseAuth _auth = FirebaseAuth.instance;
  //   var currentUser = _auth.currentUser;
  //   String? email = FirebaseAuth.instance.currentUser!.email;
  //   int random =
  //       Random(DateTime.now().millisecondsSinceEpoch).nextInt(900000) + 1;
  //   CollectionReference _collectionRef =
  //       FirebaseFirestore.instance.collection("order");
  //   return _collectionRef
  //       .doc()
  //       .set({
  //         "order_id": random,
  //         "item_name": item,
  //         "total": total,
  //         "email": email,
  //       })
  //       .then((value) => {
  //             // Fluttertoast.showToast(msg: "Thanks For Your Feedback"),
  //             qrr = "Email : $email" +
  //                 "\n" +
  //                 "Item : $item" +
  //                 "\nTotal : " +
  //                 total.toString(),
  //             // Navigator.push(context, MaterialPageRoute(builder: (_) => qr())),
  //             // print(qrr),
  //             qr(),
  //             deletee(),
  //           })
  //       .catchError((error) => print("something is wrong. $error"));
  // }

  // calculateAmount(String amount) {
  //   final calculatedAmout = (int.parse(amount)) * 100;
  //   //return Amount();
  //   return calculatedAmout.toString();
  // }
}

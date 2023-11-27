import 'package:bfmh_canteen/screen/bottom_nav_controller.dart';
import 'package:bfmh_canteen/screen/bottom_nav_pages/QRcode.dart';
import 'package:bfmh_canteen/screen/bottom_nav_pages/home.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class bkash extends StatefulWidget {
  num? total;
  bkash({this.total});

  @override
  State<bkash> createState() => _bkashState();
}

class _bkashState extends State<bkash> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _amountController = TextEditingController();
  num? total = 0;
  String? item;
  List<String> product = [];

  @override
  void initState() {
    Amount();
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    // focusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('payment'.tr)),
      body: SingleChildScrollView(
        //padding: const EdgeInsets.fromLTRB(40, 40, 0, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: _height / 05),
                child: Text(
                  'paymenttitle'.tr,
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 8),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: _height / 30,
                      left: _height / 25,
                      right: _height / 25),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 0,
                      ),
                      infoChild(
                        _width,
                        Icons.paid,
                        'amount'.tr + " :  " + "$total" + " TK",
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      infoChild(
                        _width,
                        Icons.price_change_rounded,
                        'vat'.tr + " :  0.0 TK",
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      infoChild(
                        _width,
                        Icons.add_circle,
                        'extra'.tr + " : 0.0 TK",
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Divider(
                        thickness: 2,
                        color: Colors.orange,
                      ),

                      infoChild(_width, Icons.price_check_rounded,
                          'total'.tr + " : " + "$total" + " TK"),
                      const SizedBox(
                        height: 22,
                      ),

                      // ElevatedButton(
                      //     onPressed: () => const update(),
                      //     child: Text("Update"))
                    ],
                  ),
                )),
            // const SizedBox(height: 40.0),
            // const Divider(),
            // ListTile(
            //   title: const Text('Immediate'),
            //   leading: Radio(
            //     value: Intent.sale,
            //     groupValue: _intent,
            //     onChanged: (value) {
            //       setState(() => _intent = value!);
            //     },
            //   ),
            //   dense: true,
            // ),
            // ListTile(
            //   title: const Text('Auth and Capture'),
            //   leading: Radio(
            //     value: Intent.authorization,
            //     groupValue: _intent,
            //     onChanged: (value) {
            //       setState(() => _intent = value!);
            //     },
            //   ),
            //   dense: true,
            // ),
            // const Divider(),
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    backgroundColor: Colors.orange),
                child: Text(
                  'payment'.tr,
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  // String amount = _amountController.text.trim();
                  String amount = total.toString();
                  String intent = "authorization";

                  if (amount.isEmpty) {
                    // if the amount is empty then show the snack-bar
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "Amount is empty. Without amount you can't pay. Try again")));
                    return;
                  }
                  // remove focus from TextField to hide keyboard
                  // focusNode!.unfocus();
                  // Goto BkashPayment page & pass the params
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BkashPayment(
                            /// depend isSandbox (true/false)
                            isSandbox: true,

                            /// amount of your bkash payment
                            amount: amount,

                            /// intent would be (sale / authorization)
                            intent: intent,
                            // accessToken: '', /// if the user have own access token for verify payment
                            // currency: 'BDT',
                            /// bkash url for create payment, when you implement on you project then it be change as your production create url, [when you send it on sandbox mode, send it as empty string '' or anything]
                            createBKashUrl:
                                'https://merchantserver.sandbox.bka.sh/api/checkout/v1.2.0-beta/payment/create',

                            /// bkash url for execute payment, , when you implement on you project then it be change as your production create url, [when you send it on sandbox mode, send it as empty string '' or anything]
                            executeBKashUrl:
                                'https://merchantserver.sandbox.bka.sh/api/checkout/v1.2.0-beta/payment/execute',

                            /// for script url, when you implement on production the set it live script js (https://scripts.pay.bka.sh/versions/1.2.0-beta/checkout/bKash-checkout-pay.js)
                            scriptUrl:
                                'https://scripts.sandbox.bka.sh/versions/1.2.0-beta/checkout/bKash-checkout-sandbox.js',

                            /// the return value from the package
                            /// status => 'paymentSuccess', 'paymentFailed', 'paymentError', 'paymentClose'
                            /// data => return value of response
                            paymentStatus: (status, data) {
                              dev.log('return status => $status');
                              dev.log('return data => $data');

                              /// when payment success
                              if (status == 'paymentSuccess') {
                                if (data['transactionStatus'] == 'Completed') {
                                  // sendUserDataToDB();
                                  //deletee();
                                  Style.basicToast('Payment Success');
                                }
                              }

                              /// when payment failed
                              else if (status == 'paymentFailed') {
                                if (data.isEmpty) {
                                  Style.errorToast('Payment Failed');
                                } else if (data[0]['errorMessage'].toString() !=
                                    'null') {
                                  Style.errorToast(
                                      "Payment Failed ${data[0]['errorMessage']}");
                                } else {
                                  Style.errorToast("Payment Failed");
                                }
                              }

                              // when payment on error
                              else if (status == 'paymentError') {
                                Style.errorToast(
                                    jsonDecode(data['responseText'])['error']);
                              }

                              // when payment close on demand closed the windows
                              else if (status == 'paymentClose') {
                                if (data == 'closedWindow') {
                                  Style.errorToast(
                                      'Failed to payment, closed screen');
                                } else if (data == 'scriptLoadedFailed') {
                                  Style.errorToast(
                                      'Payment screen loading failed');
                                }
                              }
                              // back to screen to pop()
                              //Navigator.of(context).pop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => bottomnavcontroller()));
                            },
                          )));
                  sendUserDataToDB();
                  deletee();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget infoChild(double width, IconData icon, data) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: InkWell(
          child: Row(
            children: <Widget>[
              SizedBox(
                width: width / 10,
              ),
              Icon(
                icon,
                color: Colors.orange,
                size: 36.0,
              ),
              SizedBox(
                width: width / 20,
              ),
              Text(data,
                  style: TextStyle(
                    fontSize: 15.sp,
                    //  color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ))
            ],
          ),
          onTap: () {
            print('Info Object selected');
          },
        ),
      );
  Amount() async {
    QuerySnapshot qn = await FirebaseFirestore.instance
        .collection("users-cart-items")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("items")
        .get();
    setState(() {
      if (total != null) {
        for (int i = 0; i < qn.docs.length; i++) {
          total = (total! + qn.docs[i]["price"]);
          product.add(qn.docs[i]["name"]);
        }
        print(total.toString());
        item = product.join(",");
      } else {}
    });
    print(item);
    return total.toString();
  }

  deletee() async {
    total = null;
    FirebaseFirestore.instance
        .collection("users-cart-items")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("items")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
    // .doc()
    // .delete()
    // .then((value) => {});
  }

  sendUserDataToDB() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    String? email = FirebaseAuth.instance.currentUser!.email;
    String random =
        (Random(DateTime.now().millisecondsSinceEpoch).nextInt(900000) + 1)
            .toString()
            .padLeft(6, '0');
    String formattedDate =
        DateFormat('yyyy-MM-dd, hh:mm:ss a').format(DateTime.now());
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("order");
    return _collectionRef
        .doc()
        .set({
          "order_id": random,
          "time": formattedDate,
          "item_name": item,
          "total": total,
          "email": email,
        })
        .then((value) => {
              // Fluttertoast.showToast(msg: "Thanks For Your Feedback"),

              deletee(),
            })
        .catchError((error) => print("something is wrong. $error"));
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    //return Amount();
    return calculatedAmout.toString();
  }
}

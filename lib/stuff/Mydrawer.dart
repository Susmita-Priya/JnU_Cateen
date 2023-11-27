import 'package:bfmh_canteen/barchat/dashboard.dart';
import 'package:bfmh_canteen/screen/bottom_nav_controller.dart';
import 'package:bfmh_canteen/screen/bottom_nav_pages/QRcode.dart';
import 'package:bfmh_canteen/screen/bottom_nav_pages/about.dart';
import 'package:bfmh_canteen/screen/bottom_nav_pages/feedback.dart';
import 'package:bfmh_canteen/screen/bottom_nav_pages/home.dart';
import 'package:bfmh_canteen/screen/bottom_nav_pages/profile.dart';
import 'package:bfmh_canteen/screen/feedbacesee.dart';
import 'package:bfmh_canteen/screen/login_screen.dart';
import 'package:bfmh_canteen/screen/welcome_screen.dart';
import 'package:bfmh_canteen/stuff/about.dart';
import 'package:bfmh_canteen/stuff/add_product.dart';
import 'package:bfmh_canteen/stuff/avail.dart';
import 'package:bfmh_canteen/stuff/cancel1.dart';
import 'package:bfmh_canteen/stuff/editfood.dart';
import 'package:bfmh_canteen/stuff/feedback.dart';
import 'package:bfmh_canteen/stuff/help.dart';
import 'package:bfmh_canteen/stuff/home.dart';
import 'package:bfmh_canteen/stuff/loginstaff.dart';
import 'package:bfmh_canteen/stuff/navcontroller.dart';
import 'package:bfmh_canteen/stuff/notifications.dart';
import 'package:bfmh_canteen/stuff/oderlist.dart';
import 'package:bfmh_canteen/pdf/pdf.dart';
import 'package:bfmh_canteen/stuff/qr.dart';
import 'package:bfmh_canteen/stuff/tracesee.dart';
import 'package:bfmh_canteen/translation/language.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  setDataToTextField(data) {
    // final List<SalesData> da = [
    //   SalesData(day: 'mon', amount: 18),
    //   SalesData(day: 'wed', amount: 60),
    //   SalesData(day: 'fri', amount: 30),
    //   SalesData(day: 'sat', amount: 10),
    //   SalesData(day: 'sun', amount: 20),
    // ];
    final _height = MediaQuery.of(context).size.height;
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.all(0),
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.orange,
                ),
                margin: EdgeInsets.all(0),
                accountName: Text('app_name'.tr,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    )),
                accountEmail: Text(" ",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    )),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("assets/Logo.jpeg"),
                  radius: MediaQuery.of(context).size.height / 1,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.home,
                color: Colors.black,
              ),
              title: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const navcontroller(),
                    ),
                  );
                },
                child: Text(
                  'home'.tr,
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Divider(indent: 18, endIndent: 16),
            ListTile(
              leading: Icon(
                Icons.fastfood_sharp,
                color: Colors.black,
              ),
              title: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => addproduct(),
                    ),
                  );
                },
                child: Text(
                  'addfood'.tr,
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Divider(indent: 15, endIndent: 15),
            ListTile(
              leading: Icon(
                CupertinoIcons.pencil,
                color: Colors.black,
              ),
              title: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const editfood(),
                    ),
                  );
                },
                child: Text(
                  'editfood'.tr,
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Divider(indent: 16, endIndent: 16),
            ListTile(
              leading: Icon(
                Icons.check_circle,
                color: Colors.black,
              ),
              title: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => avail(),
                    ),
                  );
                },
                child: Text(
                  'avail'.tr,
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            Divider(indent: 15, endIndent: 15),

            ListTile(
              leading: Icon(
                CupertinoIcons.cart_fill,
                color: Colors.black,
              ),
              title: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const order(),
                    ),
                  );
                },
                child: Text(
                  'conorder'.tr,
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            // Divider(indent: 18, endIndent: 16),
            // ListTile(
            //   leading: Icon(
            //     Icons.restaurant,
            //     color: Colors.black,
            //   ),
            //   title: GestureDetector(
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => addproduct(),
            //         ),
            //       );
            //     },
            //     child: Text(
            //       "delete Status",
            //       textScaleFactor: 1.2,
            //       style: TextStyle(
            //         color: Colors.black,
            //       ),
            //     ),
            //   ),
            // ),
            Divider(indent: 16, endIndent: 16),
            ListTile(
              leading: Icon(
                CupertinoIcons.clear_circled_solid,
                color: Colors.black,
              ),
              title: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => cancel1(),
                    ),
                  );
                },
                child: Text(
                  'cancelo'.tr,
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Divider(indent: 16, endIndent: 16),
            ListTile(
              leading: Icon(
                Icons.restaurant,
                color: Colors.black,
              ),
              title: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => tracesee(),
                    ),
                  );
                },
                child: Text(
                  'orderst'.tr,
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Divider(indent: 16, endIndent: 16),
            ListTile(
              leading: Icon(
                Icons.qr_code_scanner_rounded,
                color: Colors.black,
              ),
              title: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QRViewExample(),
                    ),
                  );
                },
                child: Text(
                  'qrscan'.tr,
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Divider(indent: 16, endIndent: 16),
            ListTile(
              leading: Icon(
                Icons.picture_as_pdf,
                color: Colors.black,
              ),
              title: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => pdf(),
                    ),
                  );
                },
                child: Text(
                  'report'.tr,
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            Divider(indent: 16, endIndent: 16),
            ListTile(
              leading: Icon(
                CupertinoIcons.f_cursive_circle_fill,
                color: Colors.black,
              ),
              title: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const feedback(),
                    ),
                  );
                },
                child: Text(
                  'feedlst'.tr,
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Divider(indent: 16, endIndent: 16),
            ListTile(
              leading: Icon(
                Icons.language,
                color: Colors.black,
              ),
              title: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => lang(),
                    ),
                  );
                },
                child: Text(
                  'lang'.tr,
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Divider(indent: 15, endIndent: 15),
            ListTile(
              leading: Icon(
                CupertinoIcons.question_circle_fill,
                color: Colors.black,
              ),
              title: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => helpc(),
                    ),
                  );
                },
                child: Text(
                  'help'.tr,
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Divider(indent: 16, endIndent: 16),
            ListTile(
              leading: Icon(
                CupertinoIcons.app_badge,
                color: Colors.black,
              ),
              title: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const about(),
                    ),
                  );
                },
                child: Text(
                  'aboutt'.tr,
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Divider(indent: 16, endIndent: 16),
            SizedBox(
              height: 25,
            ),
            ListTile(
              // leading: const Icon(
              //   CupertinoIcons.archivebox_fill,
              //   color: Colors.red,
              // ),
              title: Container(
                color: Colors.orange,
                child: MaterialButton(
                  onPressed: () {
                    logout(context);
                  },
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'logout'.tr,

                    //textAlign: TextAlign.center,
                    style: TextStyle(
                        //backgroundColor: Colors.redAccent,
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      //   child: Padding(
      // padding: const EdgeInsets.all(1),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users-form-data")
            .doc(FirebaseAuth.instance.currentUser!.email)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var data = snapshot.data;
          if (data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return setDataToTextField(data);
        },
      ),
    ));
  }

  //the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const welcomescreen()));
  }
}

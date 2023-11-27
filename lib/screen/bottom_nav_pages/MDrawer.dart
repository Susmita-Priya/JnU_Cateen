import 'package:bfmh_canteen/screen/bottom_nav_controller.dart';
import 'package:bfmh_canteen/screen/bottom_nav_pages/about.dart';
import 'package:bfmh_canteen/screen/bottom_nav_pages/cancel.dart';
import 'package:bfmh_canteen/screen/bottom_nav_pages/feedback.dart';
import 'package:bfmh_canteen/screen/bottom_nav_pages/home.dart';
import 'package:bfmh_canteen/screen/bottom_nav_pages/profile.dart';
import 'package:bfmh_canteen/screen/bottom_nav_pages/trace_food.dart';
import 'package:bfmh_canteen/screen/bottom_nav_pages/tracelist.dart';
import 'package:bfmh_canteen/screen/bottom_nav_pages/traces.dart';
import 'package:bfmh_canteen/screen/feedbacesee.dart';
import 'package:bfmh_canteen/screen/help.dart';
import 'package:bfmh_canteen/screen/login_screen.dart';
import 'package:bfmh_canteen/screen/welcome_screen.dart';
import 'package:bfmh_canteen/translation/language.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MDrawer extends StatefulWidget {
  const MDrawer({super.key});

  @override
  State<MDrawer> createState() => _MDrawerState();
}

class _MDrawerState extends State<MDrawer> {
  setDataToTextField(data) {
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
                accountName: Text(data['name'],
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    )),
                accountEmail: Text(data['email'],
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    )),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                    data["img"],
                  ),
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
                      builder: (context) => const bottomnavcontroller(),
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
                CupertinoIcons.person_crop_circle,
                color: Colors.black,
              ),
              title: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profile(),
                    ),
                  );
                },
                child: Text(
                  'profile'.tr,
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
                      builder: (context) => const traces(),
                    ),
                  );
                },
                child: Text(
                  'que'.tr,
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
                CupertinoIcons.clear_circled_solid,
                color: Colors.black,
              ),
              title: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const cancel(),
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
            Divider(indent: 15, endIndent: 15),
            ListTile(
              leading: Icon(
                Icons.add_reaction_rounded,
                color: Colors.black,
              ),
              title: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FeedBack(),
                    ),
                  );
                },
                child: Text(
                  'feedback'.tr,
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
                CupertinoIcons.f_cursive_circle_fill,
                color: Colors.black,
              ),
              title: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FeedBackSee(),
                    ),
                  );
                },
                child: Text(
                  'feedlist'.tr,
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
                      builder: (context) => help(),
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
                      builder: (context) => const AboutUs(),
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

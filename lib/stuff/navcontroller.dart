import 'package:bfmh_canteen/barchat/dashboard.dart';
import 'package:bfmh_canteen/constant/Appcolours.dart';
import 'package:bfmh_canteen/screen/bottom_nav_pages/MDrawer.dart';
import 'package:bfmh_canteen/screen/bottom_nav_pages/QRcode.dart';
import 'package:bfmh_canteen/screen/bottom_nav_pages/cart.dart';
import 'package:bfmh_canteen/screen/bottom_nav_pages/favourite.dart';
import 'package:bfmh_canteen/screen/bottom_nav_pages/home.dart';
import 'package:bfmh_canteen/screen/bottom_nav_pages/notification.dart';
import 'package:bfmh_canteen/screen/bottom_nav_pages/profile.dart';
import 'package:bfmh_canteen/screen/bottom_nav_pages/tracelist.dart';
import 'package:bfmh_canteen/screen/bottom_nav_pages/update.dart';
import 'package:bfmh_canteen/screen/search_screen.dart';
import 'package:bfmh_canteen/stuff/Mydrawer.dart';
import 'package:bfmh_canteen/stuff/home.dart';
import 'package:bfmh_canteen/stuff/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class navcontroller extends StatefulWidget {
  const navcontroller({super.key});

  @override
  State<navcontroller> createState() => _navcontrollerState();
}

class _navcontrollerState extends State<navcontroller> {
  final _pages = [home(), HomePage()];
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: myDrawer(),
      drawer: const Drawer(child: MyDrawer()),
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: Text(
          'app_name'.tr,
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => search()));
              },
              child: CircleAvatar(
                child: Icon(
                  Icons.search,
                  size: 22.0,
                  color: Colors.black,
                ),
                radius: 20.0,
                backgroundColor: Colors.orange,
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 4.0),
          //   child: GestureDetector(
          //     onTap: () {
          //       Navigator.of(context).push(
          //           MaterialPageRoute(builder: (context) => notificationn()));
          //     },
          //     // child: CircleAvatar(
          //     //   child: Icon(
          //     //     Icons.notifications_active,
          //     //     size: 22.0,
          //     //     color: Colors.black,
          //     //   ),
          //     //   radius: 20.0,
          //     //   backgroundColor: Colors.orange,
          //     // ),
          //   ),
          // ),
        ],
        //centerTitle: true,
        // automaticallyImplyLeading: false,
      ),

      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        selectedItemColor: Appcolours.Orange,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        selectedLabelStyle:
            TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home'.tr,
          ),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.favorite_outline), label: 'fav'.tr),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'dashboard'.tr,
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.fastfood),
          //   label: 'trace'.tr,
          // ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            print(_currentIndex);
          });
        },
      ),
      body: _pages[_currentIndex],
    );
  }
}

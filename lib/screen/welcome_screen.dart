import 'package:bfmh_canteen/screen/login_screen.dart';
import 'package:bfmh_canteen/screen/registration_screen.dart';
import 'package:bfmh_canteen/stuff/loginstaff.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class welcomescreen extends StatefulWidget {
  const welcomescreen({super.key});

  @override
  State<welcomescreen> createState() => _welcomescreenState();
}

class _welcomescreenState extends State<welcomescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/dash2.jpg'), fit: BoxFit.cover),
            ),
          ),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 50, left: 220),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.updateLocale(Locale('bn', 'BD'));
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(45),
                          ),
                          side: BorderSide(color: Colors.orange)),
                      child: Text(
                        'Ban',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        Get.updateLocale(Locale('en', 'US'));
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                          side: BorderSide(color: Colors.orange)),
                      child: Text(
                        'Eng',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.only(top: 170, left: 60),
                  child: Column(
                    children: [
                      Text(
                        'app_name'.tr,
                        //"JnU Canteen",
                        style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              BoxShadow(
                                blurRadius: 5,
                                color: Colors.orange,
                                offset: Offset(3, 3),
                              )
                            ]),
                      ),
                      Text(
                        'app_title'.tr,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[200],
                            shadows: [
                              BoxShadow(
                                blurRadius: 5,
                                color: Colors.orange,
                                offset: Offset(2, 2),
                              )
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      width: double.infinity,
                      padding:
                          const EdgeInsets.only(top: 25, left: 80, right: 24),
                      child: Text(
                        'Where tasteful creations begin',
                        style: GoogleFonts.lobster(
                          fontSize: 18,
                          color: Colors.grey[200],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    // ),
                    // Container(
                    //   height: 80,
                    //   width: double.infinity,
                    //   padding: const EdgeInsets.only(
                    //       top: 8, left: 44, right: 44, bottom: 10),
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       Get.updateLocale(Locale('en', 'US'));
                    //     },
                    //     style: ElevatedButton.styleFrom(
                    //         elevation: 0,
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(35),
                    //         ),
                    //         side: BorderSide(color: Colors.orange)),
                    //     child: Text(
                    //       'english',
                    //       style: TextStyle(
                    //         fontSize: 20,
                    //         fontWeight: FontWeight.bold,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   height: 80,
                    //   width: double.infinity,
                    //   padding: const EdgeInsets.only(
                    //       top: 8, left: 44, right: 44, bottom: 10),
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       Get.updateLocale(Locale('bn', 'BD'));
                    //     },
                    //     style: ElevatedButton.styleFrom(
                    //         elevation: 0,
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(35),
                    //         ),
                    //         side: BorderSide(color: Colors.orange)),
                    //     child: Text(
                    //       'bangla',
                    //       style: TextStyle(
                    //         fontSize: 20,
                    //         fontWeight: FontWeight.bold,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Container(
                      height: 80,
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                          top: 8, left: 44, right: 44, bottom: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => loginscreen()));
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                            side: BorderSide(color: Colors.orange)),
                        child: Text(
                          'student'.tr,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 80,
                      width: double.infinity,
                      padding:
                          const EdgeInsets.only(top: 8, left: 44, right: 44),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => loginscreenstaff()));
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                            side: BorderSide(color: Colors.orange)),
                        child: Text(
                          'canteen'.tr,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

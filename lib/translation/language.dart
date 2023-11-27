import 'package:flutter/material.dart';
import 'package:get/get.dart';

class lang extends StatefulWidget {
  const lang({super.key});

  @override
  State<lang> createState() => _langState();
}

class _langState extends State<lang> {
  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       body: Stack(children: [
  //     Column(children: [
  //       Expanded(
  //         flex: 1,
  //         child: Padding(
  //           padding: const EdgeInsets.only(top: 250, left: 120),
  //           child: Column(
  //             children: [
  //               ElevatedButton(
  //                 onPressed: () {
  //                   Get.updateLocale(Locale('bn', 'BD'));
  //                 },
  //                 style: ElevatedButton.styleFrom(
  //                     elevation: 0,
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(45),
  //                     ),
  //                     side: BorderSide(color: Colors.orange)),
  //                 child: Text(
  //                   'Ban',
  //                   style: TextStyle(
  //                     fontSize: 14,
  //                     fontWeight: FontWeight.bold,
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(width: 10),
  // ElevatedButton(
  //   onPressed: () {
  //     Get.updateLocale(Locale('en', 'US'));
  //   },
  //   style: ElevatedButton.styleFrom(
  //       elevation: 0,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(35),
  //       ),
  //       side: BorderSide(color: Colors.orange)),
  //   child: Text(
  //     'Eng',
  //     style: TextStyle(
  //       fontSize: 14,
  //       fontWeight: FontWeight.bold,
  //       color: Colors.white,
  //     ),
  //   ),
  // ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ]),
  //   ]));
  // }
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      // child: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/vc3.jpeg'), fit: BoxFit.cover),
            ),
          ),
          // Text("Select Your Language "),
          // SizedBox(height: 16),
          Center(
              child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(
                top: 400,
              )),
              Text(
                'selan'.tr,
                style: TextStyle(
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 5,
                        color: Colors.black,
                      ),
                    ],
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Container(
                height: 65,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 8, left: 44, right: 44),
                child: ElevatedButton(
                  onPressed: () {
                    Get.updateLocale(Locale('bn', 'BD'));
                  },
                  style: ElevatedButton.styleFrom(
                      //backgroundColor: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45),
                      ),
                      side: BorderSide(color: Colors.orange)),
                  child: SizedBox(
                    //  width: 320,
                    // height: 40,
                    child: Text(
                      'বাংলা',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                height: 65,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 8, left: 44, right: 44),
                child: ElevatedButton(
                  onPressed: () {
                    Get.updateLocale(Locale('en', 'US'));
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                      side: BorderSide(color: Colors.orange)),
                  child: SizedBox(
                    //  width: 320,
                    child: Text(
                      'English',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
        ],
      ),
    ));
  }
}

import 'package:bfmh_canteen/constant/Appcolours.dart';
import 'package:bfmh_canteen/screen/login_screen.dart';
import 'package:bfmh_canteen/screen/user_form.dart';
import 'package:bfmh_canteen/stuff/loginstaff.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class signupstaff extends StatefulWidget {
  const signupstaff({super.key});

  @override
  State<signupstaff> createState() => _signupstaffState();
}

class _signupstaffState extends State<signupstaff> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  signUp() async {
    try {
      if (_passwordController.text == "111111") {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);
        var authCredential = userCredential.user;
        print(authCredential!.uid);
        if (authCredential.uid.isNotEmpty &&
            _passwordController.text == "111111") {
          Fluttertoast.showToast(msg: "Successfull");
          Navigator.push(
              context, CupertinoPageRoute(builder: (_) => loginscreenstaff()));
        } else {
          Fluttertoast.showToast(msg: "Something is wrong");
        }
      } else {
        Fluttertoast.showToast(msg: "Collect Token First");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: "The account already exists for that email.");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Appcolours.Orange,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            fit: BoxFit.fill,
            image: AssetImage('assets/dash2.jpg'),
            //opacity: 40,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 300.h,
              width: ScreenUtil().screenWidth,
              child: Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.light,
                        color: Colors.transparent,
                      ),
                    ),
                    Text(
                      'signup'.tr,
                      style: TextStyle(fontSize: 22.sp, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: ScreenUtil().screenWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28.r),
                    topRight: Radius.circular(28.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          'create'.tr,
                          style: TextStyle(
                              fontSize: 22.sp, color: Appcolours.Orange),
                        ),
                        // Text(
                        //   "Glad to see you back my buddy.",
                        //   style: TextStyle(
                        //     fontSize: 14.sp,
                        //     color: Color(0xFFBBBBBB),
                        //   ),
                        // ),
                        SizedBox(
                          height: 25.h,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 48.h,
                              width: 41.w,
                              decoration: BoxDecoration(
                                  color: Appcolours.Orange,
                                  borderRadius: BorderRadius.circular(12.r)),
                              child: Center(
                                child: Icon(
                                  Icons.email_outlined,
                                  color: Colors.white,
                                  size: 20.w,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: "abc9954@gmail.com",
                                  hintStyle: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey,
                                  ),
                                  labelText: 'email'.tr,
                                  labelStyle: TextStyle(
                                    fontSize: 15.sp,
                                    color: Appcolours.Orange,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 48.h,
                              width: 41.w,
                              decoration: BoxDecoration(
                                  color: Appcolours.Orange,
                                  borderRadius: BorderRadius.circular(12.r)),
                              child: Center(
                                child: Icon(
                                  Icons.lock_outline,
                                  color: Colors.white,
                                  size: 20.w,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: TextField(
                                controller: _passwordController,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  hintText: "Collect Token from author",
                                  hintStyle: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey,
                                  ),
                                  labelText: 'token'.tr,
                                  labelStyle: TextStyle(
                                    fontSize: 15.sp,
                                    color: Appcolours.Orange,
                                  ),
                                  suffixIcon: _obscureText == true
                                      ? IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _obscureText = false;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.remove_red_eye,
                                            size: 20.w,
                                          ))
                                      : IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _obscureText = true;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.visibility_off,
                                            size: 20.w,
                                          )),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 50.h,
                        ),
                        // elevated button
                        SizedBox(
                          width: 1.sw,
                          height: 56.h,
                          child: ElevatedButton(
                            onPressed: () {
                              signUp();
                            },
                            child: Text(
                              'signup'.tr,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.sp),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Appcolours.Orange,
                              elevation: 3,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Wrap(
                          children: [
                            Text(
                              'already'.tr,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFBBBBBB),
                              ),
                            ),
                            GestureDetector(
                              child: Text(
                                'signin'.tr,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Appcolours.Orange,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            loginscreenstaff()));
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

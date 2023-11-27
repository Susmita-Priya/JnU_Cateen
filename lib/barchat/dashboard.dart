import 'package:bfmh_canteen/barchat/bar.dart';
import 'package:bfmh_canteen/barchat/line.dart';
import 'package:bfmh_canteen/barchat/pie.dart';
import 'package:bfmh_canteen/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("Dashboard"),
        //   centerTitle: true,
        //   backgroundColor: Colors.orange,
        //   brightness: Brightness.dark,
        // ),
        body: Column(
      children: [
        SizedBox(
          height: 15.h,
        ),
        SizedBox(
          height: 20.h,
          child: Text('msa'.tr, style: TextStyle(fontSize: 19)),
        ),
        SizedBox(
          height: 12.h,
          child: Text("(X-axis:Month.Y-axis:Price)",
              style: TextStyle(fontSize: 12)),
        ),
        Expanded(
          // child: Container(
          //   color: Colors.blue,
          //   child: Center(
          //     child: Text('Top Part'),
          //   ),
          // ),
          // child: Text('Top Part'),
          child: bar(),
        ),
        // Expanded(
        //   flex: 1,

        //   child: Text('Monthly Sales Analysis'),

        //   //)
        // ),
        SizedBox(
          height: 15.h,
        ),
        SizedBox(
          height: 20.h,
          child: Text('ysa'.tr, style: TextStyle(fontSize: 19)),
        ),
        SizedBox(
          height: 12.h,
          child: Text("(X-axis:Year.Y-axis:Price)",
              style: TextStyle(fontSize: 12)),
        ),
        Expanded(
          // child: SingleChildScrollView(
          // child: Container(
          //   color: Colors.yellow,
          //   child: Center(
          //     child: Text('Bottom Part'),
          //   ),
          // ),
          child: line(),
        ),
        // SizedBox(
        //   height: 25.h,
        //   child: Text("Yearly Sales Analysis", style: TextStyle(fontSize: 16)),
        // ),
        // ),
      ],
    ));
  }
}

class SalesData {
  final String month;
  final double sales;

  SalesData(this.month, this.sales);
}

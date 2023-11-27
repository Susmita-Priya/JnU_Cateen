// import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ChartPage extends StatefulWidget {
//   @override
//   _ChartPageState createState() => _ChartPageState();
// }

// class _ChartPageState extends State<ChartPage> {
//   late List<charts.Series<Sales, String>> _barChartData;
//   late List<charts.Series<Sales, num>> _lineChartData;
//   late List<charts.Series<Sales, String>> _pieChartData;

//   @override
  // void initState() {
  //   super.initState();
  //   _initializeFirebase();
  // }

  // Future<void> _initializeFirebase() async {
  //   await Firebase.initializeApp();
  //   _fetchDataFromFirestore();
  // }

  // void _fetchDataFromFirestore() async {
  //   var data = await FirebaseFirestore.instance.collection('trace').get();
  //   var salesList = data.docs.map((doc) {
  //     return Sales(doc.get('time'), doc.get('total'));
  //   }).toList();

  //   _barChartData = [
  //     charts.Series(
  //       id: 'Sales',
  //       data: salesList,
  //       domainFn: (Sales sales, _) => sales.date,
  //       measureFn: (Sales sales, _) => sales.totalPrice,
  //       colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
  //     ),
  //   ];

    // _lineChartData = [
    //   charts.Series(
    //     id: 'Sales',
    //     data: salesList,
    //     domainFn: (Sales sales, _) => num.parse(sales.date),
    //     measureFn: (Sales sales, _) => sales.totalPrice,
    //     colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
    //   ),
    // ];

//     _pieChartData = [
//       charts.Series(
//         id: 'Sales',
//         data: salesList,
//         domainFn: (Sales sales, _) => sales.date,
//         measureFn: (Sales sales, _) => sales.totalPrice,
//         labelAccessorFn: (Sales sales, _) =>
//             '${sales.date}: \$${sales.totalPrice}',
//         colorFn: (Sales sales, _) =>
//             charts.MaterialPalette.deepOrange.shadeDefault.lighter,
//       ),
//     ];

//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Charts'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // if (_barChartData != null)
//             //   SizedBox(
//             //     height: 300,
//             //     child: charts.BarChart(
//             //       _barChartData,
//             //       animate: true,
//             //       barRendererDecorator: charts.BarLabelDecorator<String>(),
//             //     ),
//             //   ),
            // if (_lineChartData != null)
            //   SizedBox(
            //     height: 30,
                // child: charts.LineChart(
                //   _lineChartData,
                //   animate: true,
                //   defaultRenderer: charts.LineRendererConfig(includeArea: true),
                // ),
            //   ),
//             if (_pieChartData != null)
//               SizedBox(
//                 height: 30,
                // child: charts.PieChart(
                //   _pieChartData,
                //   animate: true,
                //   defaultRenderer: charts.ArcRendererConfig(
                //     arcRendererDecorators: [
                //       charts.ArcLabelDecorator(
                //         labelPosition: charts.ArcLabelPosition.outside,
                //       ),
                //     ],
                //   ),
                // ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Sales {
//   final String date;
//   final int totalPrice;

//   Sales(this.date, this.totalPrice);
// }

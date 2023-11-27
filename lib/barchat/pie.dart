// import 'package:flutter/material.dart';
// import 'package:pie_chart/pie_chart.dart';

// // class pie extends StatelessWidget {
//   class pie extends StatefulWidget {
//     const pie({super.key});
  
//     @override
//     State<pie> createState() => _pieState();
//   }
  
//   class _pieState extends State<pie> {

//   late List<charts.Series<Sales, String>> _pieChartData;

//   @override
//   void initState() {
//     super.initState();
//     _initializeFirebase();
//   }

//   Future<void> _initializeFirebase() async {
//     await Firebase.initializeApp();
//     _fetchDataFromFirestore();
//   }

//   void _fetchDataFromFirestore() async {
//     var data = await FirebaseFirestore.instance.collection('trace').get();
//     var salesList = data.docs.map((doc) {
//       return Sales(doc.get('time'), doc.get('total'));
//     }).toList();

//     _barChartData = [
//       charts.Series(
//         id: 'Sales',
//         data: salesList,
//         domainFn: (Sales sales, _) => sales.date,
//         measureFn: (Sales sales, _) => sales.totalPrice,
//         colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//       ),
//     ];

//     _lineChartData = [
//       charts.Series(
//         id: 'Sales',
//         data: salesList,
//         domainFn: (Sales sales, _) => num.parse(sales.date),
//         measureFn: (Sales sales, _) => sales.totalPrice,
//         colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
//       ),
//     ];

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
//     return Container(
//       child: Center(
//         child: PieChart(
//           dataMap: dataMap,
//           chartRadius: MediaQuery.of(context).size.width / 1.7,
//           legendOptions: LegendOptions(
//             legendPosition: LegendPosition.bottom,
//           ),
//           chartValuesOptions: ChartValuesOptions(
//             showChartValuesInPercentage: true,
//           ),
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
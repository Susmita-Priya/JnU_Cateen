import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fluttertoast/fluttertoast.dart';
import 'bar_chart_model.dart';
import 'package:intl/intl.dart';

// class bar extends StatelessWidget {
//   bar({Key? key}) : super(key: key);
class bar extends StatefulWidget {
  const bar({super.key});

  @override
  State<bar> createState() => _barState();
}

class _barState extends State<bar> {
  List<charts.Series<Sales, String>> _barChartData = [];

  void _fetchDataFromFirestore() async {
    // print(formattedyear);
    var data = await FirebaseFirestore.instance
        .collection('bar')
        //.where('year', isEqualTo: '$formattedyear')
        //.orderBy('year')
        .orderBy('month')
        .get();
    var salesList = data.docs.map((doc) {
      return Sales(doc.get('month'), doc.get('price'));
    }).toList();

    _barChartData = [
      charts.Series(
        id: 'Sales',
        data: salesList,
        domainFn: (Sales sales, _) => sales.date,
        measureFn: (Sales sales, _) => sales.totalPrice,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        labelAccessorFn: (Sales sales, _) => sales.date,
      ),
    ];
    setState(() {});
  }
  // final List<BarChartModel> data = [
  //   BarChartModel(
  //     year: "2014",
  //     financial: 250,
  //     color: charts.ColorUtil.fromDartColor(Colors.blueGrey),
  //   ),
  //   BarChartModel(
  //     year: "2015",
  //     financial: 300,
  //     color: charts.ColorUtil.fromDartColor(Colors.red),
  //   ),
  //   BarChartModel(
  //     year: "2016",
  //     financial: 100,
  //     color: charts.ColorUtil.fromDartColor(Colors.green),
  //   ),
  //   BarChartModel(
  //     year: "2017",
  //     financial: 450,
  //     color: charts.ColorUtil.fromDartColor(Colors.yellow),
  //   ),
  //   BarChartModel(
  //     year: "2018",
  //     financial: 630,
  //     color: charts.ColorUtil.fromDartColor(Colors.lightBlueAccent),
  //   ),
  //   BarChartModel(
  //     year: "2019",
  //     financial: 950,
  //     color: charts.ColorUtil.fromDartColor(Colors.pink),
  //   ),
  //   BarChartModel(
  //     year: "2020",
  //     financial: 400,
  //     color: charts.ColorUtil.fromDartColor(Colors.purple),
  //   ),
  // ];

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    String formattedyear = DateFormat('yyyy').format(DateTime.now()).toString();
    // int year = int.parse(formattedyear);
    // int y1 = year - 1;
    // String yy = y1.toString();
    await Firebase.initializeApp();
    final snapshot = await FirebaseFirestore.instance
        .collection('bar')
        .where('year', isLessThan: formattedyear)
        .get();
    final data1 =
        snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    num totalCount = data1.length;
    print(totalCount);
    num totalPricee = data1.fold<num>(0, (sum, item) => sum + item['price']);
    String y = data1.fold<String>('', (sum, item) => sum + item['year']);
    print(totalPricee);
    if (totalCount != 0) {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      await firebaseFirestore
          .collection('line')
          .doc()
          .set({
            "year": y,
            "price": totalPricee,
          })
          .then((value) => {
                //  Fluttertoast.showToast(msg: "Done!"),
              })
          .catchError((error) => print("something is wrong. $error"));
      List<Future<void>> futures = [];
      snapshot.docs.forEach((doc) {
        futures.add(doc.reference.delete());
      });
    }
    _fetchDataFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    // List<charts.Series<BarChartModel, String>> series = [
    //   charts.Series(
    //     id: "financial",
    //     data: data,
    //     domainFn: (BarChartModel series, _) => series.year,
    //     measureFn: (BarChartModel series, _) => series.financial,
    //     colorFn: (BarChartModel series, _) => series.color,
    //   ),
    // ];

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: charts.BarChart(
        _barChartData,
        animate: true,
        //  barRendererDecorator: charts.BarLabelDecorator<String>(),
        domainAxis: charts.OrdinalAxisSpec(
          showAxisLine: true,
          //   renderSpec: charts.SmallTickRendererSpec(labelRotation: 50),
        ),
        primaryMeasureAxis: charts.NumericAxisSpec(
          showAxisLine: true,
          // tickFormatterSpec: charts.BasicNumericTickFormatterSpec.fromNumberFormat(
          // charts.NumberFormat.currency(
          //   locale: 'en_US',
          //   symbol: '\$',
          //   decimalDigits: 0,
          // ),
          //    ),
        ),
      ),
    );
  }
}

class Sales {
  final String date;
  final int totalPrice;

  Sales(this.date, this.totalPrice);
}

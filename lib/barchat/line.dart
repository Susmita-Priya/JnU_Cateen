import 'package:bfmh_canteen/barchat/bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class line extends StatefulWidget {
  const line({super.key});

  @override
  State<line> createState() => _lineState();
}

class _lineState extends State<line> {
  void initState() {
    _fetchDataFromFirestore();

    super.initState();
  }

  List<Sales> data = [];

  _fetchDataFromFirestore() async {
    // print(formattedyear);
    var data1 = await FirebaseFirestore.instance
        .collection('line')
        //.where('year', isEqualTo: '$formattedyear')
        //.orderBy('year')
        .orderBy('year')
        .get();
    data = data1.docs.map((doc) {
      return Sales(doc.get('year'), doc.get('price'));
    }).toList();
    print('hi');
  }

  @override
  Widget build(BuildContext context) {
    _fetchDataFromFirestore();
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('line')
            .orderBy('year')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text('Loading...');
          }

          final data = snapshot.data!.docs.map((doc) {
            String date = doc['year'];
            int value = doc['price'];
            return Sales(date, value);
          }).toList();

          return Scaffold(
            body: Container(
              // padding: EdgeInsets.symmetric(),
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                //title: ChartTitle(text: 'Yearly Sales Analysis'),
                // legend: Legend(
                //   isVisible: true,
                // ),

                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<Sales, String>>[
                  LineSeries<Sales, String>(
                    dataSource: data,
                    xValueMapper: (Sales sales, _) => sales.date,
                    yValueMapper: (Sales sales, _) => sales.totalPrice,
                    name: 'Sales',
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class Sales {
  final String date;
  final int totalPrice;

  Sales(this.date, this.totalPrice);
}

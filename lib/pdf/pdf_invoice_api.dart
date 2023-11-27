import 'dart:io';
import 'package:bfmh_canteen/pdf/pdf_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:intl/intl.dart';

class PdfInvoiceApi {
  static Future<File> generate() async {
    final pdf = Document();
    final snapshot = await FirebaseFirestore.instance
        .collection('trace')
        //.where("status", isNotEqualTo: "Cancelled")
        .get();
    final data =
        snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    num totalCount = data.length;
    num totalPricee = data.fold<num>(0, (sum, item) => sum + item['total']);
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String formattedmonth = DateFormat('MM').format(DateTime.now());
    String formattedyear = DateFormat('yyyy').format(DateTime.now());

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore
        .collection('bar')
        .doc()
        .set({
          "date": formattedDate,
          "month": formattedmonth,
          "year": formattedyear,
          "price": totalPricee,
        })
        .then((value) => {
              Fluttertoast.showToast(msg: "Done!"),
            })
        .catchError((error) => print("something is wrong. $error"));

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(totalCount),
        SizedBox(height: 1 * PdfPageFormat.cm),
        buildTitle(),
        buildInvoice(data),
        Divider(),
        buildTotal(totalPricee),
      ],
      footer: (context) => buildFooter(),
    ));

    return PdfApi.saveDocument(
        name: 'jnu_canteen($formattedDate).pdf', pdf: pdf);
  }

  static Widget buildHeader(num ordernm) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSupplierAddress(),
              Container(
                height: 70,
                width: 70,
                child: BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data: "JnU Canteen\n Jagannath University",
                ),
              ),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildCustomerAddres(),
              buildInvoiceInfo(ordernm),
            ],
          ),
        ],
      );

  static Widget buildCustomerAddres() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('     ', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('    '),
        ],
      );

  static Widget buildInvoiceInfo(num ordernm) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String formattedtime = DateFormat('hh:mm:ss a').format(DateTime.now());
    String orderno = ordernm.toString();
    final titles = <String>['Date:', 'Time:', 'Total Order:'];
    final data = <String>[formattedDate, formattedtime, orderno];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }

  static Widget buildSupplierAddress() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("JnU Canteen",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text("Jagannath University", style: TextStyle(fontSize: 14)),
        ],
      );

  static Widget buildTitle() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Report',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          // Text(invoice.info.description),
          // SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildInvoice(List<Map<String, dynamic>> data) {
// Define the table headers
    final headers = ['Date', 'Order id', 'Item', 'Price(TK)'];

    // Define the table rows
    final rows = data.map((item) {
      return [
        item['time'],
        item['order_id'],
        item['item'],
        item['total'],
        // '\$${item['total'].toString()}',
      ];
    }).toList();
    return Table.fromTextArray(
      headers: headers,
      data: rows,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      // cellHeight: 30,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.center,
        2: pw.Alignment.centerLeft,
        3: pw.Alignment.centerRight,
      },
      cellPadding: pw.EdgeInsets.all(10),
      columnWidths: {
        0: pw.FixedColumnWidth(70),
        1: pw.FixedColumnWidth(70),
        2: pw.FixedColumnWidth(140),
        3: pw.IntrinsicColumnWidth(),
      },
    );
  }

  static Widget buildTotal(num totalPrice) {
    //    final snapshot = await FirebaseFirestore.instance.collection('trace').get();
    //   final data =
    //       snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    //   final totalCount = data.length;
    //  final totalPrice = data.fold<double>(0, (sum, item) => sum + item['price']);

    // final netTotal = invoice.items
    //     .map((item) => item.unitPrice * item.quantity)
    //     .reduce((item1, item2) => item1 + item2);
    // final vatPercent = invoice.items.first.vat;
    // final vat = null;
    // final total = netTotal + vat;

    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Net total',
                  value: totalPrice.toString() + " TK",
                  unite: true,
                ),
                buildText(
                  title: 'Vat%',
                  value: '0%',
                  unite: true,
                ),
                Divider(),
                buildText(
                  title: 'Total amount',
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  value: totalPrice.toString() + " TK",
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(
              title: 'Address', value: 'Jagannath University,Sadarghat,Dhaka'),
          // SizedBox(height: 1 * PdfPageFormat.mm),
          // buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo),
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}

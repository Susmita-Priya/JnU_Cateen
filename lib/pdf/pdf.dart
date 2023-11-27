import 'dart:io';
import 'package:bfmh_canteen/pdf/pdf_api.dart';
import 'package:bfmh_canteen/pdf/pdf_invoice_api.dart';
import 'package:bfmh_canteen/stuff/trace.dart';
import 'package:bfmh_canteen/stuff/trace1.dart';
import 'package:bfmh_canteen/widgets/fetchfeedback.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';

class pdf extends StatefulWidget {
  const pdf({super.key});

  @override
  State<pdf> createState() => _pdfState();
}

class _pdfState extends State<pdf> {
  deData() async {
    final snapshot = await FirebaseFirestore.instance.collection('trace').get();
    final data =
        snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    snapshot.docs.forEach((doc) {
      doc.reference.delete();
    });
  }

  Widget trsee(String collectionName) {
    String? email1 = FirebaseAuth.instance.currentUser!.email;
    return Container(
      child: Stack(
        children: <Widget>[
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(collectionName)
                //.where("status", isNotEqualTo: "Cancelled")
                .orderBy("time", descending: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Something is wrong"),
                );
              }
              return ListView.builder(
                  itemCount:
                      snapshot.data == null ? 0 : snapshot.data!.docs.length,
                  itemBuilder: (_, index) {
                    DocumentSnapshot _documentSnapshot =
                        snapshot.data!.docs[index];

                    return Card(
                      elevation: 5,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage("assets/profile.png"),
                        ),
                        //fit: BoxFit.cover,

                        title: Text(
                          'orderid'.tr + " : ${_documentSnapshot['order_id']}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                              fontSize: 19.h),
                        ),
                        subtitle: Text(
                          "${_documentSnapshot['time']}",
                          //  "\n(${_documentSnapshot['item']})"
                          // "\n${_documentSnapshot['total']} TK"
                          //     "\n\n" +
                          // 'status'.tr +
                          // " : ${_documentSnapshot['status']}",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'orderst'.tr,
            style: TextStyle(
              //fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.orange,
          //automaticallyImplyLeading: false,
          //centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: SafeArea(
          child: trsee("trace"),
          //customButton("Continue", () => sendUserDataToDB()),
        ),
        bottomNavigationBar: Container(
            height: 55,
            width: double.infinity,
            padding: const EdgeInsets.only(
                top: 0, left: 114, right: 114, bottom: 10),
            child: TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  backgroundColor: Colors.orange),
              child: Text(
                'pdf'.tr,
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async {
                final pdfFile = await PdfInvoiceApi.generate();
                deData();
                PdfApi.openFile(pdfFile);
              },
            )));
  }
}

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  String? r;
  String? sub;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool _isPaused = false;
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 3,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Text(
                      "\n"
                      '${result!.code}\n',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  else
                    Text('\n' + 'scan'.tr + '\n',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.pauseCamera();
                            },
                            child: Icon(CupertinoIcons.pause_circle_fill)),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.resumeCamera();
                          },
                          child: Icon(CupertinoIcons.play_circle_fill),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                return Icon(CupertinoIcons.bolt_fill);
                              },
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return Icon(
                                      CupertinoIcons.camera_rotate_fill);
                                } else {
                                  return const Text('loading');
                                }
                              },
                            )),
                      )
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: <Widget>[
                  //     // Container(
                  //     //   margin: const EdgeInsets.all(8),
                  //     //   child: ElevatedButton(
                  //     //       onPressed: () async {
                  //     //         await controller?.toggleFlash();
                  //     //         setState(() {});
                  //     //       },
                  //     //       child: FutureBuilder(
                  //     //         future: controller?.getFlashStatus(),
                  //     //         builder: (context, snapshot) {
                  //     //           return Icon(CupertinoIcons.bolt_fill);
                  //     //         },
                  //     //       )),
                  //     // ),
                  //     // Container(
                  //     //   margin: const EdgeInsets.all(8),
                  //     //   child: ElevatedButton(
                  //     //       onPressed: () async {
                  //     //         await controller?.flipCamera();
                  //     //         setState(() {});
                  //     //       },
                  //     //       child: FutureBuilder(
                  //     //         future: controller?.getCameraInfo(),
                  //     //         builder: (context, snapshot) {
                  //     //           if (snapshot.data != null) {
                  //     //             return Icon(
                  //     //                 CupertinoIcons.camera_rotate_fill);
                  //     //           } else {
                  //     //             return const Text('loading');
                  //     //           }
                  //     //         },
                  //     //       )),
                  //     // )
                  //   ],
                  // ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 240.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.orange,
          borderRadius: 8,
          borderLength: 30,
          borderWidth: 8,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      if (!_isPaused) {
        controller.pauseCamera();
        // Do something with the scan data
        r = scanData.code;
        sub = r?.substring(42, 48);
        print(sub);
        addData();
        setState(() {
          _isPaused = true;
          result = scanData;
        });
      }
    });
  }

  addData() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("trace");
    final snapshot =
        await _collectionRef.where("order_id", isEqualTo: sub).get();

    final docRef = snapshot.docs.first.reference;

    await docRef
        .update({
          'status': "Handover Done",
        })
        .then((value) => {
              Fluttertoast.showToast(msg: "Done !!"),
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (_) => tracesee()))
            })
        .catchError((error) => print("something is wrong. $error"));
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

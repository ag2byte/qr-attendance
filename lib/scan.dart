import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() =>
      _ScanPageState();
}
class _ScanPageState extends
State<ScanPage> {
  String qrCodeResult = "Scan The QR for Attendance";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Scanner"),
        centerTitle: true,
         ),
        body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
        mainAxisAlignment:
        MainAxisAlignment.center,
        crossAxisAlignment:
        CrossAxisAlignment.stretch,
        children: <Widget>[
            Text(
            qrCodeResult,
            style: TextStyle(
            fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
            ),
            SizedBox(
            height: 20.0,
            ),
            FlatButton(
              padding: EdgeInsets.all(15.0),
              onPressed: ()
              async {
              String codeScanner = await BarcodeScanner.scan();
              setState(() {
              qrCodeResult = codeScanner;
              });
            },
              child: Text(
                "Open Scanner",
                style:
                TextStyle(color:
                Colors.blue, fontWeight: FontWeight.bold),
              ),
              shape:
              RoundedRectangleBorder(
                  side: BorderSide(color:
                  Colors.blue, width: 3.0),
                  borderRadius:
                  BorderRadius.circular(20.0)),
            )
        ],
        ),
        ),
    );
  }

}

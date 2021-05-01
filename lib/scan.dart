import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class ClassDetailSchema {
  final String classname;
  final DateTime start;
  final DateTime end;
  final String facultyid;

  ClassDetailSchema(this.classname, this.start, this.end, this.facultyid);

  Map toJson() => {
        'classname': classname,
        'starttime': start,
        'endtime': end,
        'facultyid': facultyid,
      };
}

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String qrCodeResult = "Scan The QR for Attendance";
  DateTime start;
  DateTime end;
  dynamic myEncode(dynamic item) {
                  if (item is DateTime) {
                    return item.toIso8601String();
                  }
                  return item;
                }
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
              onPressed: () async {
                String codeScanner = await BarcodeScanner.scan();
                setState(() {
                  qrCodeResult = codeScanner;
                });
                var details = codeScanner.split(",");
                start = DateTime.parse(details[0]);
                end = DateTime.parse(details[1]);

                ClassDetailSchema s1 =
                    new ClassDetailSchema(details[2], start, end, details[3]);
                Map data = s1.toJson();
                print(data);

                String body1 = json.encode(data, toEncodable: myEncode);
                

                print(body1);
                var client = http.Client();
                print(client.hashCode);
                try {
                  var uriResponse = await client.post(
                    Uri.parse('https://qrspine.herokuapp.com/tests'),
                    headers: {"Content-Type": "application/json;charset=UTF-8"},
                    body: body1,
                  );
                  print('sent');
                  print(uriResponse.body);
                  Map _response = json.decode(uriResponse.body);
                }
                finally{
                  Fluttertoast.showToast(

                    msg: "Attendace added for class " + details[2],
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.SNACKBAR,
                    fontSize: 12.0,
                  );
                }
              },
              child: Text(
                "Open Scanner",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.blue, width: 3.0),
                  borderRadius: BorderRadius.circular(20.0)),
            )
          ],
        ),
      ),
    );
  }
}

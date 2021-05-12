import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:qr_attendance_app/attendance.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class AttendanceSchema {
  final String cid;
  final String sid;
  final DateTime scantime;

  AttendanceSchema(this.cid, this.sid, this.scantime);

  Map toJson() => {
        'classid': cid,
        'studentid': sid,
        'scantime': scantime,
      };
}

class ScanPage extends StatefulWidget {
  final String sid;
  ScanPage(this.sid);
  @override
  _ScanPageState createState() => _ScanPageState(sid);
}

class _ScanPageState extends State<ScanPage> {
  String sid;
  _ScanPageState(this.sid);
  String qrCodeResult = "Scan The QR for Attendance";
  DateTime start;
  DateTime end;
  Map _response;
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
                print(details);
                start = DateTime.parse(details[0]);
                end = DateTime.parse(details[1]);

                AttendanceSchema s1 =
                    new AttendanceSchema(details[4], sid, DateTime.now());
                Map data = s1.toJson();
                print(data);

                String body1 = json.encode(data, toEncodable: myEncode);

                print(body1);
                var client = http.Client();
                print(client.hashCode);
                try {
                  var uriResponse = await client.post(
                    Uri.parse('https://qrspine.herokuapp.com/attend'),
                    headers: {"Content-Type": "application/json;charset=UTF-8"},
                    body: body1,
                  );
                  // print('sent');
                  // print(uriResponse.body);
                  _response = json.decode(uriResponse.body);
                } finally {
                  if (_response["present"]) {
                    Fluttertoast.showToast(
                      msg: "Attendace added for class " + details[2],
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.SNACKBAR,
                      fontSize: 20.0,
                    );
                  } else {
                    Fluttertoast.showToast(
                      msg: "you have scanned late please contact the faculty",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.SNACKBAR,
                      fontSize: 20.0,
                    );
                  }
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
            ),
            SizedBox(
              height: 20.0,
            ),
            flatButton("See Attendance", AttendancePage(_response)),
          ],
        ),
      ),
    );
  }

  Widget flatButton(String text, Widget widget) {
    return FlatButton(
      padding: EdgeInsets.all(15.0),
      onPressed: () async {
        //  AttendanceSchema s1 = new AttendanceSchema(
        //      "show attendance", sid, DateTime.now());
        //   Map data = s1.toJson();

        //   String body1 = json.encode(data, toEncodable: myEncode);
        //   print(body1);

        var client = http.Client();
        print(client.hashCode);
        try {
          var uriResponse = await client.get(
            Uri.parse('https://qrspine.herokuapp.com/getattendance?res=' + sid),
            headers: {"Content-Type": "application/json;charset=UTF-8"},
          );
          print('sent');
          // print(uriResponse.body);
          Map _response = json.decode(uriResponse.body);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AttendancePage(_response)));
        } finally {
          client.close();
        }
      },
      child: Text(
        text,
        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      ),
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.blue, width: 3.0),
          borderRadius: BorderRadius.circular(20.0)),
    );
  }
}

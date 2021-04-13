import 'package:flutter/material.dart';
import 'package:qr_attendance_app/scan.dart';

class LoginStudentPage extends StatefulWidget {
  @override
  _LoginStudentPageState createState() => _LoginStudentPageState();
}

class _LoginStudentPageState extends State<LoginStudentPage> {
  @override
  Widget build(BuildContext context) {
    TextField passwordField;
    TextField regnoField;
        return Scaffold(
          appBar: AppBar(
            title: Text("QR ATTENDANCE SYSTEM"),
            centerTitle: true,
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                  regnoField = TextField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your Reg No'),
            ),
            SizedBox(
              height: 10.0,
            ),
              passwordField = TextField(
              obscureText: true,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your Password'),
            ),
            SizedBox(
              height: 20.0,
            ),
            flatButton("Login", ScanPage()),
          ],
        ),
      ),
    );
  }

  Widget flatButton(String text, Widget widget) {
    return FlatButton(
      padding: EdgeInsets.all(15.0),
      onPressed: () async {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => widget));
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

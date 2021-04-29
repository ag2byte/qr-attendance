import 'package:flutter/material.dart';
import 'package:qr_attendance_app/login_student.dart';
import 'package:qr_attendance_app/login_admin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
  
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
            flatButton("Login for Student", LoginStudentPage()),
            SizedBox(height: 20.0,),
            flatButton("Login for Admin", LoginAdminPage()),

          ],
        ),
      ),
    );
  }

  Widget flatButton(String text, Widget widget) {
    return FlatButton(
      padding: EdgeInsets.all(15.0),
      onPressed: () async {
        var client = http.Client();

        try {
          var uriResponse = await client.get(
            Uri.parse('https://qrspine.herokuapp.com/'),
          );
        }
        finally{
          Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => widget));
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

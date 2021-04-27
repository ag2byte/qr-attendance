import 'package:flutter/material.dart';
import 'package:qr_attendance_app/scan.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StudemtLoginSchema {
  final int regno;
  final String password;

  StudemtLoginSchema(this.regno, this.password);

  Map toJson() => {
        'username': regno,
        'password': password,
      };
}

class LoginStudentPage extends StatefulWidget {
  @override
  _LoginStudentPageState createState() => _LoginStudentPageState();
}

class _LoginStudentPageState extends State<LoginStudentPage> {
  @override
    final passwordController = TextEditingController();
    final regnoController = TextEditingController();

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
                controller: regnoController,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter your Reg No'),
                ),
            SizedBox(
              height: 10.0,
            ),
            passwordField = TextField(
              obscureText: true,
              controller: passwordController,
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

        StudemtLoginSchema s1 = new StudemtLoginSchema(int.parse(regnoController.text), passwordController.text);
        Map data = s1.toJson();

        // Map data = {
        //     'username': 809121,
        //     'password': 'gojofan'
        //   };

        String body1 = json.encode(data);
        print(body1);
        var client = http.Client();
        try {
          var uriResponse = await client.post(
            Uri.parse('https://qrspine.herokuapp.com/tests'),
            headers: {"Content-Type": "application/json"},
            body: body1,
          );
          print('sent');
        } finally {
          client.close();
        }
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

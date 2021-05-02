import 'package:flutter/material.dart';
import 'package:qr_attendance_app/scan.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class StudentLoginSchema {
  final String regno;
  final String password;
  final bool isStudent;

  StudentLoginSchema(this.regno, this.password, this.isStudent);

  Map toJson() => {
        'username': regno,
        'password': password,
        'isStudent': isStudent,
      };
}

class LoginStudentPage extends StatefulWidget {
  @override
  _LoginStudentPageState createState() => _LoginStudentPageState();
}

class _LoginStudentPageState extends State<LoginStudentPage> {
  final passwordController = TextEditingController();
  final regnoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String regno;
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
            TextField(
              controller: regnoController,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your Reg No'),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your Password'),
            ),
            SizedBox(
              height: 20.0,
            ),
            flatButton("Login", ScanPage(regno)),
          ],
        ),
      ),
    );
  }

  Widget flatButton(String text, Widget widget) {
    return FlatButton(
      padding: EdgeInsets.all(15.0),
      onPressed: () async {
        StudentLoginSchema s1 = new StudentLoginSchema(
            regnoController.text, passwordController.text, true);
        Map data = s1.toJson();

        String body1 = json.encode(data);
        print(body1);
        var client = http.Client();
        print(client.hashCode);
        try {
          var uriResponse = await client.post(
            Uri.parse('https://qrspine.herokuapp.com/token'),
            headers: {"Content-Type": "application/json;charset=UTF-8"},
            body: body1,
          );
          print('sent');
          Map _response = json.decode(uriResponse.body);
          String regno = regnoController.text;
          if (_response.containsKey("access_token")) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ScanPage(regno)));
          } else {
            print(_response['detail']);
            Fluttertoast.showToast(
                msg: _response['detail'],
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.SNACKBAR,
                fontSize: 12.0);
          }
        } catch (Error) {
          print(Error);
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

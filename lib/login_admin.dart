import 'package:flutter/material.dart';
import 'package:qr_attendance_app/classdetails.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class FacultyLoginSchema {
  final String email;
  final String password;
  final bool isStudent;

  FacultyLoginSchema(this.email, this.password, this.isStudent);

  Map toJson() => {
        'username': email,
        'password': password,
        'isStudent': isStudent,
      };
}

class LoginAdminPage extends StatefulWidget {
  @override
  _LoginAdminPageState createState() => _LoginAdminPageState();
}

class _LoginAdminPageState extends State<LoginAdminPage> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  String id;
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
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your Teacher Email ID'),
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
            flatButton("Login", ClassDetailsPage(id)),
          ],
        ),
      ),
    );
  }

  Widget flatButton(String text, Widget widget) {
    return FlatButton(
      padding: EdgeInsets.all(15.0),
      onPressed: () async {
        FacultyLoginSchema s1 = new FacultyLoginSchema(
            emailController.text, passwordController.text, false);
        Map data = s1.toJson();

        String body1 = json.encode(data);
        print(body1);
        var client = http.Client();
        try {
          var uriResponse = await client.post(
            Uri.parse('https://qrspine.herokuapp.com/token'),
            headers: {"Content-Type": "application/json;charset=UTF-8"},
            body: body1,
          );
          print('sent');
          Map _response = json.decode(uriResponse.body);
          if (_response.containsKey("access_token")) {
            id = _response["access_token"];
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ClassDetailsPage(id)));
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

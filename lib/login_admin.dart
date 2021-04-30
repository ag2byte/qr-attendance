import 'package:flutter/material.dart';
import 'package:qr_attendance_app/generate.dart';
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
  @override
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  Map _response;

  Widget build(BuildContext context) {
    TextField passwordField;
    TextField emailField;
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
            emailField = TextField(
              controller: emailController,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your Teacher Email ID'),
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
            flatButton("Login", GeneratePage()),
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
          // print(uriResponse.body); //access
          Map _response = json.decode(uriResponse.body);
          // print(_response.keys);
          if (_response.containsKey("access_token")) {
            client.close();
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => widget));
          } else {
            print(_response['detail']);
            Fluttertoast.showToast(
                msg: _response['detail'],
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.SNACKBAR,
                fontSize: 12.0);
          }
        } 
      catch(Error){print(Error);}
        finally {
          client.close();
        }
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => widget));
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

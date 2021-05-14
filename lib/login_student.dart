import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.5, 1],
                  colors: [Color(0xff661EFF), Color(0xffFFA3FD)])),
        ),
        title: Text(
          "",
          style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20.0),
          child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Padding(padding: const EdgeInsets.only(top: 20)),

              SvgPicture.asset(
                "assets/student.svg",
                height: 200,
                width: 181,
              ),
              //("assets/student.svg",height : 340,
              //width: 181,),
              new Padding(padding: const EdgeInsets.only(top: 20)),

              Center(child: Text('LOGIN',style: TextStyle(fontFamily: 'Poppins',fontSize: 32,fontWeight: FontWeight.w700),)),

              new Padding(padding: const EdgeInsets.only(top: 20)),

              Container(
                height: 64,
                width: 325,

                decoration: BoxDecoration(
                  color: Color(0xffEFF0F6),
                  borderRadius: BorderRadius.all(Radius.circular(16)),

                ),
                child : TextField(
                  controller: regnoController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon:Icon(Icons.mail_outline ),

                  //    border: UnderlineInputBorder(),
                      labelText: 'Registration no.'),
                ),

              ),

              new Padding(padding: const EdgeInsets.only(top: 40)),

              //new Padding(padding: const EdgeInsets.only(top: 20)),

              Container(
                height: 64,
                width: 295,

                decoration: BoxDecoration(
                  color: Color(0xffFCFCFC),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  border: Border(
                    top:  BorderSide(
                      color: Colors.purple,
                      width: 0.7,
                    ),
                    bottom:  BorderSide(
                      color: Colors.purple,
                      width: 0.7,
                    ),
                    left:  BorderSide(
                      color: Colors.purple,
                      width: 0.7,
                    ),
                    right:  BorderSide(
                      color: Colors.purple,
                      width: 0.7,
                    ),
                  ),
                ),

                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon:Icon(Icons.remove_red_eye_outlined ),
                     // border: UnderlineInputBorder(),
                      labelText: 'Password',
                  suffixIcon: Icon(Icons.clear)),

                ),
              ),

              //new Padding(padding: const EdgeInsets.only(top: 20)),
              new Padding(padding: const EdgeInsets.only(top: 20)),

              flatButton("Login", ScanPage(regno)),
            ],
          ),
        ),
      ),
    );
  }

  Widget flatButton(String text, Widget widget) {
    return FlatButton(
      padding: EdgeInsets.all(20.0),
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
        style: TextStyle(color: Color(0xffF7F7FC),fontFamily: "Poppins", fontWeight:FontWeight.w600),
      ),
      color: Color(0xff5F2EEA),
      shape: RoundedRectangleBorder(
        //  side: BorderSide(color: Colors.blue, width: 3.0),
          borderRadius: BorderRadius.circular(20.0)),
    );
  }
}
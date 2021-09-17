import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.5,1],

                  colors: [Color(0xff661EFF), Color(0xffFFA3FD)])),

        ),
        title: Text("",style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.bold),),
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
      //        new Padding(padding: const EdgeInsets.only(top: 20)),

              SvgPicture.asset(
                "assets/admin_login.svg",
                height: 200,
                width: 181,
              ),
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
                child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon:Icon(Icons.mail_outline ),
                      //  border: UnderlineInputBorder(),
                        labelText: 'Teacher Email'),
                  ),
              ),

              new Padding(padding: const EdgeInsets.only(top: 40)),


              Container(
                height: 64,
                width: 325,

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
                      prefixIcon:Icon(Icons.remove_red_eye),
                      //border: UnderlineInputBorder(),
                      labelText: 'Password',
                      suffixIcon: Icon(Icons.clear)),
                ),
              ),
              new Padding(padding: const EdgeInsets.only(top: 30)),

              flatButton("Login", ClassDetailsPage(id)),
            ],
          ),
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
            Uri.parse('SERVER TOKEN ENDPOINT'),
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
        style: TextStyle(color: Color(0xffF7F7FC),fontFamily: "Poppins", fontWeight:FontWeight.w600),
      ),
      color: Color(0xff5F2EEA),
      shape: RoundedRectangleBorder(
         // side: BorderSide(color: Colors.blue, width: 3.0),
          borderRadius: BorderRadius.circular(20.0)),
    );
  }
}
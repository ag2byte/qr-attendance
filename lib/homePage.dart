import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_attendance_app/login_student.dart';
import 'package:qr_attendance_app/login_admin.dart';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        title: Text("QR ATTENDANCE SYSTEM",style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
              child: Container(

          //padding: EdgeInsets.all(20.0),
          child: Column(

            children: <Widget>[

              new Padding(padding: const EdgeInsets.only(top: 15)),
               Image.asset("assets/home.png",height : 340,
                 width: 181,),
              new Padding(padding: const EdgeInsets.only(top: 30)),
              Container(
                padding: const EdgeInsets.all(50),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children:<Widget> [
                    flatButton("Login for Student", LoginStudentPage()),
// // SizedBox(
// //   height: 20.0,
                    new Padding(padding: const EdgeInsets.only(top: 50)),

                    new Divider(height: 10,thickness: 1.0,color: Color(0xff6C63FF),indent:80 ,endIndent: 80,),

                    new Padding(padding: const EdgeInsets.only(top: 50)),
// // ),
                  flatButton("Login for Teacher", LoginAdminPage()),

                  ],
                ),
              )
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
        var client = http.Client();

        try {
          await client.get(
            Uri.parse('https://qrspine.herokuapp.com/'),
          );
        } finally {
          client.close();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => widget));
        }
      },
      child: Text(
        text,
        style: TextStyle(color: Color(0xffF7F7FC),fontFamily: "Poppins", fontWeight:FontWeight.w600),
      ),
      color: Color(0xff5F2EEA),
      shape: RoundedRectangleBorder(
          //side: BorderSide(color: Colors.blue, width: 3.0),
          borderRadius: BorderRadius.circular(40.0)),

    );
  }
}


// flatButton("Login for Student", LoginStudentPage()),
// // SizedBox(
// //   height: 20.0,
// new Padding(padding: const EdgeInsets.only(top: 30)),
// // ),
// flatButton("Login for Admin", LoginAdminPage()),
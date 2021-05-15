import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:qr_attendance_app/generate.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class ClassDetailSchema {
  final String classname;
  final DateTime start;
  final DateTime end;
  final String facultyid;

  ClassDetailSchema(this.classname, this.start, this.end, this.facultyid);

  Map toJson() => {
        'classname': classname,
        'starttime': start,
        'endtime': end,
        'facultyid': facultyid,
      };
}

class ClassDetailsPage extends StatefulWidget {
  final String id;
  ClassDetailsPage(this.id);
  @override
  _ClassDetailsPageState createState() => _ClassDetailsPageState(id);
}

class _ClassDetailsPageState extends State<ClassDetailsPage> {
  String id;
  _ClassDetailsPageState(this.id);
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final classnameContoller = TextEditingController();
  DateTime pickeddate = DateTime.now();
  TimeOfDay start = TimeOfDay.now();
  TimeOfDay end = TimeOfDay.now();
  DateTime start1;
  String cid;
  DateTime end1;
  dynamic myEncode(dynamic item) {
    if (item is DateTime) {
      return item.toIso8601String();
    }
    return item;
  }

  @override
  Widget build(BuildContext context) {
    int t = end.minute;
    int t1 = start.minute;
    String endmin;
    String startmin;
    if (t < 10) {
      endmin = "0" + t.toString();
    } else {
      endmin = t.toString();
    }
    if (t1 < 10) {
      startmin = "0" + t1.toString();
    } else {
      startmin = t1.toString();
    }

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
        title: Text("Class Builder",style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.bold),),
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
                "assets/classbuilder.svg",
                height: 200,
                width: 181,
              ),

              new Padding(padding: const EdgeInsets.only(top: 20)),

              Container(
                height: 64,
                width: 325,

                decoration: BoxDecoration(
                  color: Color(0xffEFF0F6),
                  borderRadius: BorderRadius.all(Radius.circular(16)),

                ),
                child: TextField(
                  controller: classnameContoller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon:Icon(Icons.edit),
                      //  border: UnderlineInputBorder(),
                      //labelText: 'Teacher Email'),

                      labelText: 'class name'),
                ),
              ),

              new Padding(padding: const EdgeInsets.only(top: 20)),


              Container(
                height: 64,
                width: 325,

                decoration: BoxDecoration(
                  color: Color(0xffEFF0F6),
                  borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: ListTile(
                  title: Text(
                      "${pickeddate.day}/${pickeddate.month}/${pickeddate.year}"),
                  trailing: Icon(Icons.keyboard_arrow_down),
                  onTap: _pickDate,
                ),
              ),
              new Padding(padding: const EdgeInsets.only(top: 20)),

              Container(
                decoration: BoxDecoration(
                    color: Color(0xffEFF0F6),
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: ListTile(
                  title: Text("${start.hour}" + ":" + startmin),
                  trailing: Icon(Icons.keyboard_arrow_down),
                  onTap: _pickStartTime,
                ),
              ),
              new Padding(padding: const EdgeInsets.only(top: 20)),

              Container(
                decoration: BoxDecoration(
                    color: Color(0xffEFF0F6),
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: ListTile(
                  title: Text("${end.hour}" + ":" + endmin),
                  trailing: Icon(Icons.keyboard_arrow_down),
                  onTap: _pickEndTime,
                ),
              ),

              new Padding(padding: const EdgeInsets.only(top: 20)),

              flatButton(
                  "Generate QR",
                  GeneratePage(
                      pickeddate, start, end, classnameContoller.text, id, cid)),
            ],
          ),
        ),
      ),
    );
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: DateTime.now(),
    );

    if (date != null)
      setState(() {
        pickeddate = date;
      });
  }

  _pickStartTime() async {
    TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null)
      setState(() {
        start = time;
      });
  }

  _pickEndTime() async {
    TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null)
      setState(() {
        end = time;
      });
  }

 String formatTimeOfDay(TimeOfDay tod, DateTime date) {
    final now = date;
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat('yyyy-MM-dd HH:mm:ss');
    return format.format(dt);
  }
  
  Widget flatButton(String text, Widget widget) {
    return FlatButton(
      padding: EdgeInsets.all(15.0),
      onPressed: () async {
        print(start);
        start1 = DateTime.parse(formatTimeOfDay(start, pickeddate));
        end1 = DateTime.parse(formatTimeOfDay(end, pickeddate));
        print(start1);
        ClassDetailSchema s1 =
            new ClassDetailSchema(classnameContoller.text, start1, end1, id);
        Map data = s1.toJson();
        print(data);

        if (start.hour > end.hour) {
          Fluttertoast.showToast(
              msg: "Please check the timings",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.SNACKBAR,
              fontSize: 12.0);
        } else {
          String body1 = json.encode(data, toEncodable: myEncode);

          print(body1);
          var client = http.Client();
          try {
            var uriResponse = await client.post(
              Uri.parse('https://qrspine.herokuapp.com/addclass'),
              headers: {"Content-Type": "application/json;charset=UTF-8"},
              body: body1,
            );
            print('sent');
            print(uriResponse.body);
            Map _response = json.decode(uriResponse.body);
            cid = _response['cid'];
          } finally {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => GeneratePage(
                    pickeddate, start, end, classnameContoller.text, id, cid)));
          }
        }
      },
      child: Text(
        text,
        style: TextStyle(color: Color(0xffF7F7FC),fontFamily: "Poppins", fontWeight:FontWeight.w600),
      ),
      color: Color(0xff5F2EEA),
      shape: RoundedRectangleBorder(
          //side: BorderSide(color: Colors.blue, width: 3.0),style: TextStyle(color: Color(0xffF7F7FC),fontFamily: "Poppins", fontWeight:FontWeight.w600),

          borderRadius: BorderRadius.circular(40.0)),
    );
  }
}
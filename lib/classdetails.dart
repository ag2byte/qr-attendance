import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_attendance_app/generate.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';

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
  String id;
  ClassDetailsPage(this.id);
  @override
  _ClassDetailsPageState createState() => _ClassDetailsPageState(id);
}

class _ClassDetailsPageState extends State<ClassDetailsPage> {
  String id;
  _ClassDetailsPageState(this.id);
  @override
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final classnameContoller = TextEditingController();
  
  Map _response;
  DateTime PickedDate = DateTime.now();
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

  Widget build(BuildContext context) {
    TextField passwordField;
    TextField classnameField;

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

            classnameField = TextField(
              controller: classnameContoller,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter the class name'),
            ),
            SizedBox(
              height: 10.0,
            ),


            ListTile(
              title: Text("${PickedDate.day}/${PickedDate.month}/${PickedDate.year}"),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: _pickDate,

            ),

               SizedBox(
              height: 10.0,
            ),


            ListTile(
              title: Text("${start.hour}:${start.minute}"),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: _pickStartTime,

            ),

               SizedBox(
              height: 10.0,
            ),


            ListTile(
              title: Text("${end.hour}:${end.minute}"),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: _pickEndTime,

            ),
          
            SizedBox(
              height: 20.0,
            ),
            flatButton("Generate The QR", GeneratePage(PickedDate, start, end , classnameContoller.text,id,cid)),
          ],
        ),
      ),
    );
  }

  _pickDate() async{
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year-5),
      lastDate: DateTime(DateTime.now().year+5),
      initialDate: DateTime.now(),
    );

    if(date!=null)
    setState(() {
      PickedDate = date;
    });
  }

  _pickStartTime() async{
    TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if(time!=null)
    setState(() {
       start = time;
    });
  }


  _pickEndTime() async{
    TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if(time!=null)
    setState(() {
       end = time;
    });
  }

  String formatTimeOfDay(TimeOfDay tod, DateTime date) {
    final now = date;
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format =  DateFormat('yyyy-MM-dd HH:MM:ss');  //"6:00 AM"
    return format.format(dt);
     }

  Widget flatButton(String text, Widget widget) {
    return FlatButton(
      padding: EdgeInsets.all(15.0),
      onPressed: () async {
        // print(id);
        // print(formatTimeOfDay(start, PickedDate));
        // print(formatTimeOfDay(end, PickedDate));
        // print(classnameContoller.text);
         start1 = DateTime.parse(formatTimeOfDay(start, PickedDate));
          end1 = DateTime.parse(formatTimeOfDay(end, PickedDate));
        ClassDetailSchema s1 = new ClassDetailSchema(classnameContoller.text, start1, end1, id);
        Map data = s1.toJson();
        print(data);
        
         if (start.hour>end.hour) {
            Fluttertoast.showToast(
                msg: "Please check the timings",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.SNACKBAR,
                fontSize: 12.0);
          }
        else{
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
                }
                finally{
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => GeneratePage(PickedDate, start,end,classnameContoller.text,id,cid))
             );
                }
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
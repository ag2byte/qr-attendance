import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/rendering.dart';



class GeneratePage extends StatefulWidget {
  DateTime date;
  TimeOfDay start;
  TimeOfDay end;
  String classname;
  String id;
  GeneratePage(this.date,this.start,this.end,this.classname,this.id);
  @override
  
  State<StatefulWidget> createState() => GeneratePageState(date,start,end,classname,id);
}

class GeneratePageState extends State<GeneratePage> {
  DateTime date;
  TimeOfDay start;
  TimeOfDay end;
  String id;
  String classname;
  GeneratePageState(this.date,this.start,this.end,this.classname,this.id);
    // already generated qr code when the page opens
  
  

  @override
  String formatTimeOfDay(TimeOfDay tod, DateTime date) {
    final now = date;
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format =  DateFormat('yyyy-MM-dd HH:MM:ss');  //"6:00 AM"
    return format.format(dt);
     }

  Widget build(BuildContext context) {
    String qrData = formatTimeOfDay(start, date) +","+ formatTimeOfDay(end, date) +","+ classname + "," +id;
    print(qrData);
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
        actions: <Widget>[],
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QrImage(
              
              //plce where the QR Image will be shown
              data: qrData,
            ),
            SizedBox(
              height: 40.0,
            ),
          
          ],
        ),
      ),
    );


    

  }

  final qrdataFeed = TextEditingController();
}
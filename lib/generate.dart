import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter/rendering.dart';

class GeneratePage extends StatefulWidget {
  final DateTime date;
  final String cid;
  final TimeOfDay start;
  final TimeOfDay end;
  final String classname;
  final String id;
  GeneratePage(
      this.date, this.start, this.end, this.classname, this.id, this.cid);
  @override
  State<StatefulWidget> createState() =>
      GeneratePageState(date, start, end, classname, id, cid);
}

class GeneratePageState extends State<GeneratePage> {
  DateTime date;
  TimeOfDay start;
  TimeOfDay end;
  String cid;
  String id;
  String classname;
  GeneratePageState(
      this.date, this.start, this.end, this.classname, this.id, this.cid);

  String formatTimeOfDay(TimeOfDay tod, DateTime date) {
    final now = date;
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat('yyyy-MM-dd HH:MM:ss');
    return format.format(dt);
  }

  @override
  Widget build(BuildContext context) {
    print(cid);
    String qrData = formatTimeOfDay(start, date) +
        "," +
        formatTimeOfDay(end, date) +
        "," +
        classname +
        "," +
        id +
        "," +
        cid;
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

import 'package:flutter/cupertino.dart';
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
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Container(
                    height: 339,
                    width: 405,
                    child: Center(
                      child: QrImage(
                        data: qrData,
                      ),
                    ),
                  ),
                ),
                new Padding(padding: const EdgeInsets.only(top: 30)),

                new Divider(height: 20,thickness: 1,color: Color(0xff6C63FF),indent: 60,endIndent: 60,),

                new Padding(padding: const EdgeInsets.only(top: 30)),

               Center(
                 child: Container(
                   padding: EdgeInsets.only(left: 5),
                   child: Column(

                    children : [ Center(
                      child: Row(
                      children: [
                        Center(
                          child: Container(
                            height: 45,
                            width: 170,
                           // padding: EdgeInsets.only(left: 30),
                            decoration: BoxDecoration(
                              color: Color(0xffFCFCFC),
                              borderRadius: BorderRadius.all(Radius.circular(0)),
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

                            child: Center(
                              child: Text(
                                'Class Name'
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 45,
                          width: 170,

                          decoration: BoxDecoration(
                            color: Color(0xffFCFCFC),
                            borderRadius: BorderRadius.all(Radius.circular(0)),
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

                          child: Center(
                            child: Text(
                                classname
                            ),
                          ),
                        ),

                      ],
                      ),
                    ),

                      new Padding(padding: const EdgeInsets.only(top: 20)),

                      Row(
                        children: [
                          Container(
                            height: 45,
                            width: 170,

                            decoration: BoxDecoration(
                              color: Color(0xffFCFCFC),
                              borderRadius: BorderRadius.all(Radius.circular(0)),
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

                            child: Center(
                              child: Text(
                                  'Class Date'
                              ),
                            ),
                          ),
                          Container(
                            height: 45,
                            width: 170,

                            decoration: BoxDecoration(
                              color: Color(0xffFCFCFC),
                              borderRadius: BorderRadius.all(Radius.circular(0)),
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

                            child: Center(
                              child: Text(
                                  formatTimeOfDay(start, date).substring(0,10)
                              ),
                            ),
                          ),

                        ],
                      ),

                      new Padding(padding: const EdgeInsets.only(top: 20)),

                      Row(
                        children: [
                          Container(
                            height: 45,
                            width: 170,

                            decoration: BoxDecoration(
                              color: Color(0xffFCFCFC),
                              borderRadius: BorderRadius.all(Radius.circular(0)),
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

                            child: Center(
                              child: Text(
                                  'Start time'
                              ),
                            ),
                          ),
                          Container(
                            height: 45,
                            width: 170,

                            decoration: BoxDecoration(
                              color: Color(0xffFCFCFC),
                              borderRadius: BorderRadius.all(Radius.circular(0)),
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

                            child: Center(
                              child: Text(
                                  (start.hour.toString()+":"+start.minute.toString())
                              ),
                            ),
                          ),

                        ],
                      ),

                      new Padding(padding: const EdgeInsets.only(top: 20)),

                      Row(
                        children: [
                          Container(
                            height: 45,
                            width: 170,

                            decoration: BoxDecoration(
                              color: Color(0xffFCFCFC),
                              borderRadius: BorderRadius.all(Radius.circular(0)),
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

                            child: Center(
                              child: Text(
                                  'End time'
                              ),
                            ),
                          ),
                          Container(
                            height: 45,
                            width: 170,

                            decoration: BoxDecoration(
                              color: Color(0xffFCFCFC),
                              borderRadius: BorderRadius.all(Radius.circular(0)),
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

                            child: Center(
                              child: Text(
                                  (end.hour.toString()+":"+end.minute.toString())
                              ),
                            ),
                          ),

                        ],
                      ),


                    ],

                   ),
                 ),
               ),


                new Padding(padding: const EdgeInsets.only(top: 20)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final qrdataFeed = TextEditingController();
}
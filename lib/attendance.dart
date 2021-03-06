import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AttendancePage extends StatefulWidget {
  final Map attendance;

  AttendancePage(this.attendance);

  @override
  _AttendancePageState createState() => _AttendancePageState(attendance);
}

class _AttendancePageState extends State<AttendancePage> {
  Map attendance;
  Color bg;

  _AttendancePageState(this.attendance);

  @override
  Widget build(BuildContext context) {
    print(attendance);
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
          "Attendance",
          style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // new Text(
                //   'Attendance Percentages',
                //   style: new TextStyle(fontWeight: FontWeight.bold),
                // ),
                new Expanded(
                    child: new ListView.builder(
                  itemCount: attendance.length,
                  itemBuilder: (BuildContext context, int index) {
                    String key1 = attendance.keys.elementAt(index);
                    
                   @override
                   Color returner(int a){

                      if(a >= 75 && a <=100){
                        return Colors.green;
                      }
                       if(a >= 40 && a <=74){
                        return Colors.amber;
                      }
                      else{
                        return Colors.red;
                      }


                   }
                    return Center(
                      child: new Row(
                        children: <Widget>[
                          new Padding(padding: const EdgeInsets.all(7)),
                          Container(

                              height: 75,
                              width: 140,
                              decoration: BoxDecoration(
                                color: Color(0xff661EFF),
                                borderRadius: BorderRadius.all(Radius.circular(16)),
                              ),
                              child: Center(
                                  child: Center(
                                    child: new Text(
                                key1 + ' :',
                                style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,color: Colors.white),
                              ),
                                  ))),
                          new Padding(padding: const EdgeInsets.only(top: 30)),
                          Container(
                            padding: EdgeInsets.only(left: 15),
                             height: 130,
                             width: 198,
                             child: Center(
                               child: CircularPercentIndicator(radius: 100,
                                   lineWidth: 10.0,
                                   percent:(attendance[key1].toDouble())/100,
                                  // percent: 80,
                                   backgroundColor: Colors.grey[400],

                                  //progressColor :bg ,
                                  
                                  progressColor: returner(attendance[key1]),
                                   center : new Text(attendance[key1].toStringAsFixed(2) + '%')),
                             ),
                           ),
                        ],
                      ),
                    );
                  },
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
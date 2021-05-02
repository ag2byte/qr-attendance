import 'package:flutter/material.dart';

class AttendancePage extends StatefulWidget {
  final Map attendance;

  AttendancePage(this.attendance);

  @override
  _AttendancePageState createState() => _AttendancePageState(attendance);
}


class _AttendancePageState extends State<AttendancePage> {
  Map attendance;
  _AttendancePageState(this.attendance);
  @override
  Widget build(BuildContext context) {
    String regno;
    print(attendance);
    return Scaffold(
      appBar: AppBar(
        title: Text("ATTENDANCE SHOWER"),
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
                new Text('Attendance Percentages', style: new TextStyle(fontWeight: FontWeight.bold),),

                new Expanded(child: new ListView.builder(
                  itemCount: attendance.length,
                  itemBuilder: (BuildContext context, int index){
                    String key1 = attendance.keys.elementAt(index);
                    return new Row(
                      children: <Widget>[
                        SizedBox(height: 50),
                        new Text('${key1} : '),
                        new Text(attendance[key1].toString()+'%'),
                      ],
                      
                    );
                    
                  },

                ))

              ],
        ),
      ),
    );
  }

}
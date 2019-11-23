import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shafferjeffreyTimesheet/common/SharedPref.dart';
import 'package:shafferjeffreyTimesheet/common/worktime.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TimeClock timeClock = TimeClock(false, DateTime.now(), null);
  Duration totalTime = Duration.zero;
  SharedPref sharedPref = SharedPref();

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  //Loading counter value on start
  _loadCounter() async {
    setState(() {
      timeClock = TimeClock.fromJson(
          sharedPref.read('timeSheet') as Map<String, dynamic>);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              child: getIcon(),
              onPressed: () {
                setState(() {
                  if (timeClock.isTracking) {
                    DateTime now = DateTime.now();
                    Duration duration = now.difference(timeClock.startTime);
                    PunchCycle punchCycle =
                        PunchCycle(duration, timeClock.startTime, now);
                    timeClock.timeCard.insert(0, punchCycle);
                    if (timeClock.timeCard.length > 10) {
                      timeClock.timeCard.removeLast();
                    }
                  } else {
                    timeClock.startTime = DateTime.now();
                  }
                  timeClock.isTracking = (!timeClock.isTracking);
                  sharedPref.save('timeSheet', timeClock.toJson());
                });
              },
            ),
            appBar: AppBar(
              title: Text("My Time"),
            ),
            body: body()));
  }

  Widget body() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Divider(),
          Text('Profile Details'),
          Container(
            // height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Table(
                  border: TableBorder.all(width: 1.0, color: Colors.black),
                  children: getTable()),
            ),
          ),
        ],
      ),
    );
  }

  String getRunningTime() {
    return "1.2";
  }

  List<TableRow> getTable() {
    List<TableRow> listOfTimeTable = new List<TableRow>();

    listOfTimeTable.add(new TableRow(children: [
      TableCell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new Text('START'),
            new Text(timeClock.startTime.toString()),
          ],
        ),
      )
    ]));

    return listOfTimeTable;
  }

  String getText() {
    if (timeClock.isTracking) {
      return ("Started At : \n" + timeClock.startTime.toString());
    } else {
      return (totalTime.inHours +
              (totalTime.inMinutes.remainder(Duration.minutesPerHour) / 60.0))
          .toString();
    }
  }

  Icon getIcon() {
    if (timeClock.isTracking) {
      return Icon(Icons.stop);
    } else {
      return Icon(Icons.play_arrow);
    }
  }
}

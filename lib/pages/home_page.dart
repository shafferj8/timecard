import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shafferjeffreyTimesheet/common/SharedPref.dart';
import 'package:shafferjeffreyTimesheet/common/worktime.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TimeClock timeClock = TimeClock(false, DateTime.now(), null);
  SharedPref sharedPref = SharedPref();

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  //Loading counter value on start
  _loadCounter() async {
    try {
      TimeClock _timeClock = TimeClock.fromJson(
          json.decode(await sharedPref.read('timeSheet')) as Map<String,
              dynamic>);

      setState(() {
        timeClock = _timeClock;
      });
    } catch (Exception) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: new Text("Nothing found!"),
          duration: const Duration(milliseconds: 500)));
    }
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
          Text(_getCurrentRunningText()),
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

  String _getCurrentRunningText() {
    String returnValue;
    if (timeClock.isTracking) {
      Duration totalTime = DateTime.now().difference(timeClock.startTime);

      String formattedDate =
      DateFormat('yyyy-MM-dd  kk:mm:ss').format(timeClock.startTime);

      returnValue = "Started : " +
          formattedDate +
          ",  Current Running Time : " +
          (totalTime.inHours +
              (totalTime.inMinutes.remainder(Duration.minutesPerHour) /
                  60.0))
              .toString();
    } else {
      returnValue = "Not Currently Tracking Time";
    }

    return returnValue;
  }

  List<TableRow> getTable() {
    List<TableRow> listOfTimeTable = new List<TableRow>();

    for (int i = 0; i < timeClock.timeCard.length; i++) {
      PunchCycle punchCycle = timeClock.timeCard[i];

      listOfTimeTable.add(new TableRow(children: [
        TableCell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new Text('START'),
              new Text(DateFormat('yyyy-MM-dd  kk:mm:ss')
                  .format(punchCycle.startTime)),
            ],
          ),
        ),
      ]));

      listOfTimeTable.add(new TableRow(children: [
        TableCell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new Text('STOP'),
              new Text(DateFormat('yyyy-MM-dd  kk:mm:ss')
                  .format(punchCycle.stopTime)),
            ],
          ),
        ),
      ]));

      Duration totalTime = punchCycle.stopTime.difference(punchCycle.startTime);

      listOfTimeTable.add(new TableRow(children: [
        TableCell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new Text('DURATION'),
              new Text((totalTime.inHours +
                  (totalTime.inMinutes.remainder(Duration.minutesPerHour) /
                      60.0))
                  .toString()),
            ],
          ),
        ),
      ]));
    }

    return listOfTimeTable;
  }

  Icon getIcon() {
    if (timeClock.isTracking) {
      return Icon(Icons.stop);
    } else {
      return Icon(Icons.play_arrow);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:shafferjeffreyTimesheet/pages/home_page.dart';

void main() {
  runApp(
    new MaterialApp(
      title: "Shaffer Timesheet",
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => HomePage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        // '/workload': (context) => WorkloadPage(),
        // '/staff-list': (context) => StaffListPage(),
        // '/timesheet': (context) => TimesheetPage(),
        // '/profile': (context) => ProfilePage(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(11, 210, 23, 1),
        accentColor: Color.fromRGBO(11, 210, 23, 1),
      ),
    ),
  );
}

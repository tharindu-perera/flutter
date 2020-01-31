import 'package:bloc/pages/LineChart.dart';
import 'package:bloc/pages/TabBar.dart';
import 'package:bloc/pages/all-widgets.dart';
import 'package:bloc/pages/login.dart';
import 'package:bloc/pages/pie_chart.dart';
import 'package:bloc/pages/bar-chart.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(title: 'Flutter Login'),
//      initialRoute: '/third',
      routes: {
        '/login': (context) => LoginPage(),
        '/all': (context) => AllWidggets(),
        '/tab': (context) => TabBarViewPage(null,0),
        '/pie-chart': (context) => TaskHomePage(),
        '/bar-chart': (context) => SalesHomePage(),
        '/linear-chart': (context) => LineChart.withSampleData(),
       },
    );
  }
}

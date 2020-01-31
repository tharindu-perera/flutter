//import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:bloc/models/Task.dart';
import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;

class TaskHomePage extends StatefulWidget {
  @override
  _TaskHomePageState createState() {
    return _TaskHomePageState();
  }
}

class _TaskHomePageState extends State<TaskHomePage> {
  List<charts.Series<Task, String>> _seriesPieData;
  List<Task> mydata;

  _generateData(mydata) {
    _seriesPieData = List<charts.Series<Task, String>>();
    _seriesPieData.add(
      charts.Series(
        domainFn: (Task task, _) => task.taskDetails,
        measureFn: (Task task, _) => task.taskVal,
        //        areaColorFn: (Task task, _) =>
//            charts.ColorUtil.fromDartColor(Colors.red),
//        colorFn: (Task task, _) =>
//            charts.ColorUtil.fromDartColor(Colors.blue),

//        id: 'tasks',
        data: mydata,
        labelAccessorFn: (Task row, _) => "${row.taskVal}",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(title: Text('Tasks')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<List<Task>>(
      stream: fetchPost().asStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          List<Task> task = snapshot.data;
          return _buildChart(context, task);
        }
      },
    );
  }

  Widget _buildChart(BuildContext context, List<Task> taskdata) {
    mydata = taskdata;
    _generateData(mydata);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
          SizedBox(
                height: 10.0,
              ),
              Text(
                'Track Summary',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold,),
              ),
//              SizedBox(
//                height: 10.0,
//              ),
              Expanded(
                child: charts.PieChart(_seriesPieData,
                    animate: true,
                    animationDuration: Duration(seconds: 1),
                    behaviors: [
                      new charts.DatumLegend(
                        outsideJustification: charts.OutsideJustification.endDrawArea,
                        horizontalFirst: false,
                        showMeasures: true,
//                        desiredMaxRows: 1,
                        desiredMaxColumns: 1,
                        cellPadding: new EdgeInsets.only(
                            right: 4.0, bottom: 4.0, top: 4.0),
                        entryTextStyle: charts.TextStyleSpec(

//                            color: charts.MaterialPalette.red.shadeDefault,
//                            fontFamily: 'Georgia',
                            fontSize: 18),
                      )
                    ],
                    defaultRenderer: new charts.ArcRendererConfig(
//                        arcWidth: 100,
                        arcRendererDecorators: [
                          new charts.ArcLabelDecorator(
                              labelPosition: charts.ArcLabelPosition.inside)
                        ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
Future<List<Task>> fetchPost() async {
  final response = await http.get('https://api.myjson.com/bins/76kga');
  if (response.statusCode == 200) {
    return (json.decode(response.body) as List)
        .map((data) => new Task.fromJson(data))
        .toList();
  } else {
    throw Exception('Failed to load post');
  }
}
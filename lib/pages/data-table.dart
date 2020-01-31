import 'dart:async';
import 'dart:convert';

import 'package:bloc/pages/form.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Result>> fetchResults(http.Client client) async {
  final response = await client.get('https://api.myjson.com/bins/j5xau');

  // Use the compute function to run parseResults in a separate isolate
  return compute(parseResults, response.body);
}

GlobalKey<ScaffoldState> _scaffoldKey;
// A function that will convert a response body into a List<Result>
List<Result> parseResults(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Result>((json) => Result.fromJson(json)).toList();
}

class Result {
  final String sex;
  final String region;
  final int year;
  final String statistic;
  final String value;

  Result({this.sex, this.region, this.year, this.statistic, this.value});

  bool selected = false;

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      sex: json['sex'] as String,
      region: json['region'] as String,
      year: json['year'] as int,
      statistic: json['statistic'] as String,
      value: json['value'] as String,
    );
  }
}

class ResultsDataSource extends DataTableSource {
  final List<Result> _results;
  final BuildContext context;
  final _DataTableDemoState demoState;

  ResultsDataSource(this._results, this.context, this.demoState);

  void _sort<T>(Comparable<T> getField(Result d), bool ascending) {
    _results.sort((Result a, Result b) {
      if (!ascending) {
        final Result c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _results.length) return null;
    final Result result = _results[index];
    return DataRow.byIndex(index: index, selected: result.selected,

//        onSelectChanged: (bool value) {
//          _neverSatisfied();
//          if (result.selected != value) {
//            _selectedCount += value ? 1 : -1;
//            assert(_selectedCount >= 0);
//            result.selected = value;
//            notifyListeners();
//          }
//        },
        cells: <DataCell>[
          DataCell(
              new Icon(
                Icons.train,
                color: Colors.blueAccent,
              ), onTap: () {
            demoState.neverSatisfied(result);
          }),
          DataCell(Text('${result.sex}'), onTap: () {
            demoState.neverSatisfied(result);
          }),
          DataCell(Text('${result.region}'), onTap: () {
            demoState.neverSatisfied(result);
          }),
          DataCell(Text('${result.year}'), onTap: () {
            demoState.neverSatisfied(result);
          }),
          DataCell(Text('${result.statistic}'), onTap: () {
            demoState.neverSatisfied(result);
          }),
          DataCell(Text('${result.value}'), onTap: () {
            demoState.neverSatisfied(result);
          }),
        ]);
  }

  @override
  int get rowCount => _results.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void _selectAll(bool checked) {
    for (Result result in _results) result.selected = checked;
    _selectedCount = checked ? _results.length : 0;
    notifyListeners();
  }
}

class DataTableDemo extends StatefulWidget {
  ResultsDataSource _resultsDataSource = ResultsDataSource([], null, null);
  bool isLoaded = false;

  @override
  _DataTableDemoState createState() => _DataTableDemoState();
}

class _DataTableDemoState extends State<DataTableDemo> {
  Future<void> neverSatisfied(Result result) async {
    MediaQueryData _mediaQueryData;
    double screenWidth;
    double screenHeight;
    double blockSizeHorizontal;
    double blockSizeVertical;

    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    return showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: screenHeight,
            width: screenWidth / 2,
            child: SizedBox.expand(child: FormImage()),
//            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(1, 0), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    );
  }

  ResultsDataSource _resultsDataSource = ResultsDataSource([], null, null);
  bool isLoaded = false;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  void _sort<T>(
      Comparable<T> getField(Result d), int columnIndex, bool ascending) {
    _resultsDataSource._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  Future<void> getData(BuildContext context) async {
    final results = await fetchResults(http.Client());
    if (!isLoaded) {
      setState(() {
        _resultsDataSource = ResultsDataSource(results, context, this);
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _scaffoldKey = new GlobalKey<ScaffoldState>();

    getData(context);
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
//        appBar: AppBar(
//          leading: null,
//
//          title: const Text('Data tables'),
//        ),

        body: !isLoaded
            ? Center(child: new CircularProgressIndicator())
            : ListView(padding: const EdgeInsets.all(20.0), children: <Widget>[
                PaginatedDataTable(
                    actions: <Widget>[],
                    header: const Text('Census Data'),
                    rowsPerPage: _rowsPerPage,
                    onRowsPerPageChanged: (int value) {
                      setState(() {
                        _rowsPerPage = value;
                      });
                    },
                    sortColumnIndex: _sortColumnIndex,
                    sortAscending: _sortAscending,
                    onSelectAll: _resultsDataSource._selectAll,
                    columns: <DataColumn>[
                      DataColumn(
                        label: new Text(''),
                      ),
                      DataColumn(
                          label: const Text('Sex'),
                          onSort: (int columnIndex, bool ascending) =>
                              _sort<String>(
                                  (Result d) => d.sex, columnIndex, ascending)),
                      DataColumn(
                          label: const Text('Region'),
                          numeric: true,
                          onSort: (int columnIndex, bool ascending) =>
                              _sort<String>((Result d) => d.region, columnIndex,
                                  ascending)),
                      DataColumn(
                          label: const Text('Year'),
                          numeric: true,
                          onSort: (int columnIndex, bool ascending) =>
                              _sort<num>((Result d) => d.year, columnIndex,
                                  ascending)),
                      DataColumn(
                          label: const Text('Data'),
                          numeric: true,
                          onSort: (int columnIndex, bool ascending) =>
                              _sort<String>((Result d) => d.statistic,
                                  columnIndex, ascending)),
                      DataColumn(
                          label: const Text('Value'),
                          numeric: true,
                          onSort: (int columnIndex, bool ascending) =>
                              _sort<String>((Result d) => d.value, columnIndex,
                                  ascending)),
                    ],
                    source: _resultsDataSource)
              ]));
  }
}

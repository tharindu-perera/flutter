import 'package:bloc/pages/LineChart.dart';
import 'package:bloc/pages/all-widgets.dart';
import 'package:bloc/pages/data-table.dart';
 import 'package:bloc/pages/login.dart';
import 'package:bloc/pages/pie_chart.dart';
import 'package:bloc/pages/bar-chart.dart';

///
/// Created by NieBin on 2019/1/13
/// Github: https://github.com/nb312
/// Email: niebin312@gmail.com

import "package:flutter/material.dart";

class TabBarViewPage extends StatefulWidget {
  @override
  TabBarViewState createState() => TabBarViewState();
  int initialIndex;

  TabBarViewPage(Key key, int initialIndex) : super(key: key) {
    this.initialIndex = initialIndex;
  }
}

class TabBarViewState extends State<TabBarViewPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'PIE CHART', icon: new Icon(Icons.pie_chart)),
    Tab(text: 'BAR CHART', icon: new Icon(Icons.insert_chart)),
    Tab(text: 'LINE CHART', icon: new Icon(Icons.show_chart)),
    Tab(text: 'TABLE', icon: new Icon(Icons.table_chart)),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(
        vsync: this,
        length: myTabs.length,
        initialIndex: this.widget.initialIndex);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
//      final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//    int i = ModalRoute.of(context).settings.arguments ?? 0;
//    setState(() {
//      tabController = TabController(vsync: this, length: myTabs.length, initialIndex: i);
//    });

    return Scaffold(
//      key: _scaffoldKey,
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AllWidggets()),
          );
        },
        child: new Icon(
          Icons.home,
          size: 50,
        ),
      ),
      appBar: AppBar(
//        leading: new IconButton(
//            icon: new Icon(Icons.apps),
//            onPressed: () => _scaffoldKey.currentState.openDrawer()),

        title: TabBar(
          controller: tabController,
          tabs: myTabs,
        ),

//        title: Text('ff'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                children: <Widget>[
                  Stack(
                    alignment: const Alignment(0.6, 0.6),
                    children: [
                      CircleAvatar(
                        child: new Icon(
                          Icons.account_circle,
                          size: 49,
                        ),
                        radius: 50,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black45,
                        ),
                        child: Text(
                          'User ABC',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            ListTile(
              subtitle: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.blueGrey),
                ),
              ),
            ),
          ],
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: <Widget>[
//            Container(
////              constraints: BoxConstraints.expand(height: 50),
//              child: _tabBarLabel(),
//            ),
            Expanded(
              child: Container(
                child: TabBarView(controller: tabController, children: [
                  Container(
                    child: TaskHomePage(),
                  ),
                  Container(
                    child: SalesHomePage(),
                  ),
                  Container(
                    child: LineChart.withSampleData(),
                  ),
                  Container(
                    child: DataTableDemo(),
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

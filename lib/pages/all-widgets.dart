import 'package:bloc/pages/TabBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

class AllWidggets extends StatelessWidget {
  static final showGrid = true; // Set to false to show ListView
//  static final _myTabbedPageKey = new GlobalKey<TabBarViewState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false ,

//      title: 'Flutter layout demo',
      home: Scaffold(
//        backgroundColor: Color(0xff171E26),
//        appBar: AppBar(
//          title: Text('Flutter layout demo'),
//        ),
        body: Container(
          decoration: BoxDecoration(color: Color(0xff171E26),
            image: DecorationImage(

              image: AssetImage("images/wabtec-icon.png"),
              fit: BoxFit.scaleDown,
            ),
          ),
          child: Center(

            child: Column(

              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: new LayoutBuilder(builder: (context2, constraint) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TabBarViewPage(null, 0)),
                            );
                          },
                          child: Image.asset(
                            'images/003.png',
//                          width: 600,
//                          height: 240,
//                          fit: BoxFit.contain,
                          ),
                        );
                      }),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: new LayoutBuilder(builder: (context, constraint) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TabBarViewPage(null, 1)),
                            );
                          },
                          child: Image.asset(
                            'images/002.png',
//                          width: 600,
//                          height: 240,
//                          fit: BoxFit.scaleDown,
                          ),
                        );
                      }),
                    )
                  ],
                )),
                Expanded(
                    child: Row(
                  children: <Widget>[
                    Expanded(
                      child: new LayoutBuilder(builder: (context, constraint) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TabBarViewPage(null, 2)),
                            );
                          },
                          child: Image.asset(
                            'images/001.png',
//                          width: 600,
//                          height: 240,
//                          fit: BoxFit.contain,
                          ),
                        );
                      }),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: new LayoutBuilder(builder: (context, constraint) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TabBarViewPage(null, 3)),
                            );
                          },
                          child: Image.asset(
                            'images/004.png',
//                          width: 600,
//                          height: 240,
//                          fit: BoxFit.contain,
                          ),
                        );
                      }),
                    )
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

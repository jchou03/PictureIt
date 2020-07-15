//import 'dart:html';3

import 'package:flutter/material.dart';
import 'package:pictureit/Tools/gettingStarted.dart';
import 'package:pictureit/project.dart';

// variable setup for the app
// color setups
const backgroundColor = Color(0xFFE7FBF4);
const headingColor = Colors.white;
const boxColor = Color(0xFF94DFD2);
const arrowColor = Color(0xFFFFF7BF);
// padding, margin, and border radius setup
const globalPadding = 15.0;
const globalMargin = 15.0;
const borderRadius = 10.0;

// variables for icon changing
IconData importantIcon = Icons.favorite_border;
Color importantColor = Colors.blueAccent;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'PictureIt',
        //routes: {'/': (context) => MyApp()},
        theme: ThemeData(
          primaryColor: headingColor,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //home: MyHomePage(title: 'PictureIt')
        home: GettingStarted());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _likeCounter = 0;

  void _incrementLikeCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _likeCounter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      backgroundColor: backgroundColor,
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // an array of widgets for
          children: <Widget>[
            // container for displaying the current projects that the user is engaged in
            Container(
              // set the width to fill the width of the screen
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(globalPadding),
              margin: EdgeInsets.all(globalMargin),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  color: Colors.white),
              // the column containing the content
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('My Projects: '),
                  Text('SamTrans - Leader'),
                  Text('Homlessness - Leader'),
                ],
              ),
            ),

            Project(
                "I am the only one on the Samtrans bus and I have to wait so long for it!",
                "I've been riding the SamTrans Bus route 260 for the last two months and almost every time, no one was on the bus except me and the bus driver!",
                "David",
                Image.asset(
                  "assets/images/Screenshot (437).png",
                  height: 50,
                ),
                Image.asset("assets/images/busImg.png"))
            /*
            // container for the post of Samtrans
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(globalPadding),
              margin: EdgeInsets.all(globalMargin),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  color: Colors.white),
              // the column containing the content
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      // the expanded class makes it so the text doesn't run off of the screen
                      Expanded(
                          child: Text(
                              'I am the only one on the Samtrans bus and I have to wait so long for it!')),
                      // button for joining the project
                      FlatButton(
                        color: boxColor,
                        textColor: arrowColor,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.blueAccent,
                        onPressed: () {},
                        child: Text('Join Project'),
                      ),
                    ],
                  ),
                  // add a margin to the image so it doesn't go right up to the text
                  Container(
                    margin: EdgeInsets.all(globalMargin),
                    child: Image.asset(
                      'assets/images/busImg.png',
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  // row to display pfp, name, and exclamation points
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // left section of the row
                      Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/images/Screenshot (437).png',
                            height: 50,
                          ),
                          Text('David'),
                        ],
                      ),

                      // right section of the row showing the exclamation points & stuff
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(importantIcon),
                            color: importantColor,
                            onPressed: () {
                              setState(() {
                                if (importantColor == Colors.redAccent) {
                                  importantColor = Colors.blueAccent;
                                  importantIcon = Icons.favorite_border;
                                  _likeCounter--;
                                } else {
                                  importantColor = Colors.redAccent;
                                  importantIcon = Icons.favorite;
                                  _likeCounter++;
                                }
                              });
                            },
                          ),
                          Text('$_likeCounter'),
                          Icon(
                            Icons.chat_bubble_outline,
                            size: 24.0,
                          )
                        ],
                      )
                    ],
                  ),
                  Text(
                      "I've been riding the SamTrans Bus route 260 for the last two months and almost every time, no one was on the bus except me and the bus driver!"),
                ],
              ),
            ),*/
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementLikeCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// Function for creating containers for different parts of the app *unfinished*
Container SectionCreation(String title, BuildContext context) {
  Container item = Container(
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.all(globalPadding),
    margin: EdgeInsets.all(globalMargin),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius), color: Colors.white),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text('My Projects: '),
        Text('SamTrans - Leader'),
        Text('Homlessness - Leader'),
      ],
    ),
  );

  return item;
}

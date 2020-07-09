import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pictureit/Tools/empathy.dart';

// color setups
const backgroundColor = Color(0xFFE7FBF4);
const headingColor = Colors.white;
const boxColor = Color(0xFF94DFD2);
const arrowColor = Color(0xFFFFF7BF);

// padding, margin, and border radius setup
const globalPadding = 15.0;
const globalMargin = 15.0;
const borderRadius = 10.0;

// class for the getting started page for the problem solving tools
class GettingStarted extends StatelessWidget {
  // setting up fonts
  TextStyle titleFont;
  TextStyle textFont;
  TextStyle subFont;

  /*GettingStarted(TextStyle titleFont, TextStyle textFont, TextStyle subFont) {
    this.titleFont = titleFont;
    this.textFont = textFont;
    this.subFont = subFont;
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('PictureIt')),
        body: Container(
          color: backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // title
              Text(
                'Getting Started',
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
              // questions
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('• Where have you observed this problem?',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 18)),
                  Text('• When did you first notice it? ',
                      style: TextStyle(color: Colors.black, fontSize: 18)),
                  Text('• Where did you first notice it?',
                      style: TextStyle(color: Colors.black, fontSize: 18)),
                ],
              ),
              // noticing problem text
              Text('I first noticed the problem...',
                  style: TextStyle(color: Colors.black, fontSize: 20)),

              // text box for user input
              Container(
                color: boxColor,
                margin: EdgeInsets.all(globalPadding),
                child: TextField(
                  autocorrect: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Where did you first notice this problem?'),
                ),
              ),
              // button to move to next page
              RaisedButton(
                  color: Colors.blueAccent,
                  splashColor: Colors.blueAccent,
                  disabledColor: Colors.redAccent,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Empathy()));
                  },
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Next",
                        style: TextStyle(color: arrowColor, fontSize: 20),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: arrowColor,
                        size: 20,
                      )
                    ],
                  ))
            ],
          ),
        ));
  }
}

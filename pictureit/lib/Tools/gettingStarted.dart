import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pictureit/Data/project.dart';
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
  // project data storage
  Project project;
  // text controller for the different text fields
  final gettingStartedController = TextEditingController();

  GettingStarted(Project project) {
    this.project = project;
    if (project == null) {
      this.project = new Project();
    }
    // set the text values based on past text
    gettingStartedController.text = project.getGettingStarted();
  }

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
                style: TextStyle(color: Colors.black, fontSize: 35),
              ),
              // questions
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('• Where have you observed this problem?',
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                  Text('• When did you first notice it? ',
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                  Text('• Where did you first notice it?',
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                ],
              ),
              // noticing problem text
              Text('I first noticed the problem...',
                  style: TextStyle(color: Colors.black, fontSize: 25)),

              // text box for user input
              Container(
                color: boxColor,
                margin: EdgeInsets.all(globalPadding),
                child: TextField(
                  minLines: 5,
                  maxLines: 5,
                  autocorrect: true,
                  controller: gettingStartedController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Where did you first notice this problem?'),
                ),
              ),
              // button to move to next page
              Container(
                  margin: EdgeInsets.all(globalMargin),
                  child: RaisedButton(
                      color: boxColor,
                      splashColor: Colors.blueAccent,
                      padding: EdgeInsets.all(20),
                      onPressed: () {
                        // update the text for this project
                        project
                            .setGettingStarted(gettingStartedController.text);
                        print(project.getGettingStarted());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Empathy(project)));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      )))
            ],
          ),
        ));
  }
}
// spooky comment

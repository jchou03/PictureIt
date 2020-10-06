import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pictureit/Data/project.dart';
import 'package:pictureit/Tools/defining.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// color setups
const backgroundColor = Color(0xFFE7FBF4);
const headingColor = Colors.white;
const boxColor = Color(0xFF94DFD2);
const arrowColor = Color(0xFFFFF7BF);

// padding, margin, and border radius setup
const globalPadding = 15.0;
const globalMargin = 15.0;
const borderRadius = 10.0;

class Empathy extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  final firestore = Firestore.instance;
  FirebaseUser loggedInUser;

  Project project;
  // set up text controllers
  TextEditingController empathy1Controller = TextEditingController();
  TextEditingController empathy2Controller = TextEditingController();

  Empathy(Project project) {
    this.project = project;
    if (project == null) {
      this.project = new Project();
    }
    // text controller text is definined in the constructor to avoid the text being reset every time the widget is built, leading to the loss of text by the user
    empathy1Controller.text = project.getEmpathy1();
    empathy2Controller.text = project.getEmpathy2();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        // appbar is the header
        appBar: AppBar(
          title: Text('PictureIt'),
          backgroundColor: headingColor,
        ),
        // container for body of page
        body: Container(
            padding: EdgeInsets.all(globalPadding),
            color: backgroundColor,
            width: MediaQuery.of(context).size.width,
            // listview so it can scroll
            child: ListView(children: <Widget>[
              // column of content
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // title for the section
                  Text('Empathy',
                      style: TextStyle(color: Colors.black, fontSize: 35)),
                  // first round of text (prompt and text box)
                  Container(
                      margin: EdgeInsets.symmetric(
                          vertical: globalMargin, horizontal: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '1) Initial Thoughts',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: globalMargin),
                            child: Text(
                                'Reflect on what you already know about the problem.',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 22)),
                          ),
                          Container(
                              margin: EdgeInsets.all(globalMargin),
                              child: Text(
                                ' • Worst affected group? ex: Women ages 25-35',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              )),
                          Container(
                              margin: EdgeInsets.all(globalMargin),
                              child: Text(
                                  ' • Effects of the problem? ex: gas, money, and time wasted',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20))),
                          Container(
                              margin: EdgeInsets.all(globalMargin),
                              child: Text(
                                ' • Most frequent time the problem happens? ex: 3pm on weekdays',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              )),
                          // text box for user input
                          Container(
                            color: boxColor,
                            margin:
                                EdgeInsets.symmetric(vertical: globalPadding),
                            child: TextField(
                              minLines: 5,
                              maxLines: 5,
                              autocorrect: true,
                              controller: empathy1Controller,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText:
                                      'What do you already know about this problem?'),
                            ),
                          ),
                        ],
                      )),

                  // section for second prompt
                  Container(
                    child: Column(
                      children: <Widget>[
                        Text('2) Ask affected people about the problem',
                            style:
                                TextStyle(color: Colors.black, fontSize: 30)),
                        Container(
                            margin: EdgeInsets.all(globalMargin),
                            child: Text(
                              ' • What have other people noticed about this problem? ',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            )),
                        Container(
                            margin: EdgeInsets.all(globalMargin),
                            child: Text(
                              ' • Do they have different points of view on the problem than you do?',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            )),
                        // text field for user input
                        Container(
                          color: boxColor,
                          margin: EdgeInsets.symmetric(vertical: globalPadding),
                          child: TextField(
                            minLines: 5,
                            maxLines: 5,
                            autocorrect: true,
                            controller: empathy2Controller,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText:
                                    'What did the other people say about the problem?'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // second text box
                  // text box for user input

                  // Button for moving to the next page
                  Container(
                      margin: EdgeInsets.symmetric(vertical: globalMargin),
                      child: RaisedButton(
                          color: boxColor,
                          splashColor: Colors.blueAccent,
                          padding: EdgeInsets.all(20),
                          onPressed: () {
                            // save the new text to the project
                            project.setEmpathy1(empathy1Controller.text);
                            project.setEmpathy2(empathy2Controller.text);

                            firestore
                                .collection('Projects')
                                .document(project.getFirebaseDocumentId())
                                .setData({
                              'empathy1': empathy1Controller.text,
                              'empathy2': empathy2Controller.text,
                            }, merge: true);

                            if (project.getStage() < 1) {
                              project.setStage(1);
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Defining(project)));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Next",
                                style:
                                    TextStyle(color: arrowColor, fontSize: 20),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: arrowColor,
                                size: 20,
                              )
                            ],
                          )))
                ],
              )
            ])));
  }
}

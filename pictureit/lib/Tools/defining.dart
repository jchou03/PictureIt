import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pictureit/Data/project.dart';
import 'package:pictureit/Tools/brainstorming.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
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

class Defining extends StatelessWidget {
  final authInstance = auth.FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  Project project;

  final defining1Controller = TextEditingController();
  final defining2Controller = TextEditingController();

  Defining(Project project) {
    this.project = project;

    // text controller text is definined in the constructor to avoid the text being reset every time the widget is built, leading to the loss of text by the user
    defining1Controller.text = project.getDefining1();
    defining2Controller.text = project.getDefining2();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('PictureIt'),
          backgroundColor: headingColor,
        ),
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
                  Text('Defining',
                      style: TextStyle(color: Colors.black, fontSize: 35)),
                  // first round of text (prompt and text box)
                  Container(
                      margin: EdgeInsets.symmetric(
                          vertical: globalMargin, horizontal: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin:
                                EdgeInsets.symmetric(vertical: globalMargin),
                            child: Text(
                                'This page is for defining the needs of the people affected by the problem and narrowing down what it actually is.',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20)),
                          ),
                          Container(
                              margin: EdgeInsets.all(globalMargin),
                              child: Text(
                                'WHO is this problem affecting?',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 22),
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
                              controller: defining1Controller,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText:
                                      ' • Describe the person affected here'),
                            ),
                          ),
                        ],
                      )),

                  // section for second prompt
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                            //margin: EdgeInsets.all(globalMargin),
                            child: Text(
                          'WHY is the problem happening?',
                          style: TextStyle(color: Colors.black, fontSize: 22),
                        )),
                        Container(
                            margin:
                                EdgeInsets.symmetric(vertical: globalMargin),
                            // using RichText widget to be able to enable the bold text sections
                            child: RichText(
                              text: new TextSpan(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            'Start broad and narrow down your answer. ex: there are empty buses '),
                                    TextSpan(
                                        text: 'because ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(text: 'not many people '),
                                    TextSpan(
                                        text: 'because ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(text: 'not popular route '),
                                    TextSpan(
                                        text: 'because ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text:
                                            'the area has become less populated...')
                                  ]),
                            )),
                        // text field for user input
                        Container(
                          color: boxColor,
                          margin: EdgeInsets.symmetric(vertical: globalPadding),
                          child: TextField(
                            minLines: 5,
                            maxLines: 5,
                            autocorrect: true,
                            controller: defining2Controller,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: ' • Type your thought process here'),
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
                            // updating the project data
                            project.setDefining1(defining1Controller.text);
                            project.setDefining2(defining2Controller.text);

                            firestore
                                .collection("Projects")
                                .document(project.getFirebaseDocumentId())
                                .setData({
                              'defining1': project.getDefining1(),
                              'defining2': project.getDefining2(),
                            }, SetOptions(merge: true));
                            if (project.getStage() < 2) {
                              project.setStage(2);
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Brainstorming(project)));
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

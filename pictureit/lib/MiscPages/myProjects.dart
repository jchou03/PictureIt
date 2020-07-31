import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pictureit/Data/project.dart';
import 'package:pictureit/Data/user.dart';
import 'package:pictureit/MiscPages/projectHome.dart';

const backgroundColor = Color(0xFFE7FBF4);
const headingColor = Colors.white;
const boxColor = Color(0xFF94DFD2);
const arrowColor = Color(0xFFFFF7BF);

// padding, margin, and border radius setup
const globalPadding = 15.0;
const globalMargin = 15.0;
const borderRadius = 10.0;

class MyProjects extends StatefulWidget {
  User user;

  MyProjects(User user) {
    this.user = user;
  }

  MyProjectsState createState() => MyProjectsState(user);
}

class MyProjectsState extends State<MyProjects> {
  User user;

  MyProjectsState(User user) {
    this.user = user;
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
          child: ListView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // title
                  Text('My Projects',
                      style: TextStyle(color: Colors.black, fontSize: 35)),
                  // first box for my projects (leader or collaborator)
                  Container(
                      color: headingColor,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(globalMargin),
                      padding: EdgeInsets.all(globalPadding),
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text('Working on',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 25)),
                          ),
                          // create a column of RichTexts displaying the projects
                          Column(
                              children: List.generate(user.getProjects().length,
                                  (index) {
                            Project project = user.getProjects()[index];
                            String role = 'Collaborator';
                            if (project.getCreator() == user) {
                              role = 'Leader';
                            }

                            return Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(
                                    vertical: globalPadding / 2),
                                // uses richtext because then it allows for in text links to the project pages
                                child: RichText(
                                  textAlign: TextAlign.left,
                                  text: TextSpan(
                                      // set up the default style
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                      children: <TextSpan>[
                                        // text that takes to project page
                                        TextSpan(
                                            text: '•${project.getTitle()}',
                                            style: TextStyle(
                                                color: boxColor,
                                                decoration:
                                                    TextDecoration.underline),
                                            // link within text
                                            recognizer:
                                                new TapGestureRecognizer()
                                                  ..onTap = () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ProjectHome(
                                                                    project)));
                                                  }),
                                        TextSpan(text: ' - ' + role),
                                      ]),
                                ));
                          }))
                        ],
                      )),
                ],
              )
            ],
          ),
        ));
  }
}

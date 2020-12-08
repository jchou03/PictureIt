// color setups
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pictureit/Data/project.dart';
import 'package:pictureit/Tools/brainstorming.dart';
import 'package:pictureit/Tools/defining.dart';
import 'package:pictureit/Tools/designing.dart';
import 'package:pictureit/Tools/empathy.dart';
import 'package:pictureit/Tools/gettingStarted.dart';
import 'package:pictureit/Tools/voting.dart';

const backgroundColor = Color(0xFFE7FBF4);
const headingColor = Colors.white;
const boxColor = Color(0xFF94DFD2);
const arrowColor = Color(0xFFFFF7BF);

// padding, margin, and border radius setup
const globalPadding = 15.0;
const globalMargin = 15.0;
const borderRadius = 10.0;

class ProjectHome extends StatefulWidget {
  static const String id = 'projectHome_screen';
  Project project;

  ProjectHome(Project project) {
    this.project = project;
  }

  ProjectHomeState createState() => ProjectHomeState(project);
}

class ProjectHomeState extends State<ProjectHome> {
  Project project;
  // List to store the column of raised buttons for the stages
  List<RaisedButton> stages = [];

  final authInstance = auth.FirebaseAuth.instance;
  auth.User loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    print("logged in");
    try {
      final firebaseUser = await authInstance.currentUser;
      if (firebaseUser != null) {
        loggedInUser = firebaseUser;
        print("in GettingStarted and the logged in user's email is: " +
            loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  ProjectHomeState(Project project) {
    this.project = project;
  }

  Widget build(BuildContext context) {
    //print(project.getTitle());
    //print(project.getDescription());

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
                  Text('${project.getTitle()}',
                      style: TextStyle(color: Colors.black, fontSize: 35)),
                  // first round of text (prompt and text box)
                  Container(
                      color: boxColor,
                      margin: EdgeInsets.symmetric(
                          vertical: globalMargin, horizontal: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // area to display the description of the project
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.all(globalMargin),
                              child: Text('${project.getDescription()}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 22)),
                            ),
                          )
                        ],
                      )),

                  // section for display
                  Container(
                    child: Column(
                      children: <Widget>[
                        Center(
                          // Current Stage title
                          child: Text('Current Stage',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 30)),
                        ),
                        // show the project stage buttons
                        Column(
                            children: List.generate(project.getStages().length,
                                (index) {
                          // code for deciding whether or not the box should be active
                          bool active = false;
                          if (index <= project.getStage()) {
                            active = true;
                          }
                          // code for deciding box color
                          Color buttonColor = Colors.grey;
                          if (index < project.getStage()) {
                            buttonColor = headingColor;
                          } else if (index == project.getStage()) {
                            buttonColor = boxColor;
                          }

                          return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(
                                  horizontal: globalMargin * 4),
                              child: RaisedButton(
                                  color: buttonColor,
                                  child: Center(
                                    child: Text(
                                      '${project.getStages()[index]}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (active) {
                                      // code to switch which page it goes to
                                      switch (index) {
                                        case 0:
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Empathy(project)));
                                          break;
                                        case 1:
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Defining(project)));
                                          break;
                                        case 2:
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Brainstorming(project)));
                                          break;
                                        case 3:
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Voting1(project)));
                                          break;
                                        case 4:
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Designing(project)));
                                          break;
                                        default:
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      GettingStarted(project)));
                                      }
                                    }
                                  }));
                        }))
                      ],
                    ),
                  ),

                  // contact info
                  Container(
                      margin: EdgeInsets.symmetric(vertical: globalMargin),
                      padding: EdgeInsets.all(globalPadding),
                      width: MediaQuery.of(context).size.width,
                      color: boxColor,
                      child: Column(
                        children: <Widget>[
                          Text('Contact info:',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 22)),
                          Container(
                              padding: EdgeInsets.all(globalPadding),
                              child: Text(
                                  '${project.getCreator().getContact()}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)))
                        ],
                      )),
                ],
              )
            ])));
  }
}

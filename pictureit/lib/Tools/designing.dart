import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pictureit/Data/design.dart';
import 'package:pictureit/Data/project.dart';
import 'package:pictureit/Tools/brainstorming.dart';
import 'package:pictureit/Tools/createDesign.dart';

// color setups
const backgroundColor = Color(0xFFE7FBF4);
const headingColor = Colors.white;
const boxColor = Color(0xFF94DFD2);
const arrowColor = Color(0xFFFFF7BF);

// padding, margin, and border radius setup
const globalPadding = 15.0;
const globalMargin = 15.0;
const borderRadius = 10.0;

// limit for voting
const int voteLimit = 1;

class Designing extends StatefulWidget {
  Project project;

  Designing(Project project) {
    this.project = project;
  }

  @override
  DesigningState createState() => DesigningState(project);
}

class DesigningState extends State<Designing> {
  Project project;

  DesigningState(Project project) {
    this.project = project;
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
                    Text('Designing & Feedback',
                        style: TextStyle(color: Colors.black, fontSize: 35)),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: globalMargin),
                        child: Column(
                          children: <Widget>[
                            // Button for uploading project
                            Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: globalMargin),
                                child: RaisedButton(
                                    color: boxColor,
                                    splashColor: Colors.blueAccent,
                                    padding: EdgeInsets.all(20),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          // where the button will be leading to the next page
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CreateDesign(project)));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Icon(
                                          Icons.file_upload,
                                          color: arrowColor,
                                          size: 50,
                                        ),
                                        FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              "Upload Photo/Video\nof your prototype,\ntext file",
                                              style: TextStyle(
                                                  color: arrowColor,
                                                  fontSize: 20),
                                            ))
                                      ],
                                    ))),
                            // code to display all the designs in a column
                            Container(
                              child: Column(
                                  children: List.generate(
                                      project.getDesigns().length, (index) {
                                // variable for the design object at current index
                                Design design = project.getDesigns()[index];

                                // container for each seperate post
                                return Container(
                                    padding: EdgeInsets.all(globalPadding),
                                    margin: EdgeInsets.symmetric(
                                        vertical: globalMargin),
                                    color: boxColor,
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      children: <Widget>[
                                        // display the image
                                        Image.asset(design.getImage()),
                                        // display the text of the image
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: globalPadding),
                                            child: Text(design.getTitle(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 22))),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            // left side of bottom row
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal:
                                                          globalMargin / 2),
                                                  // pfp of user
                                                  child: design
                                                      .getUser()
                                                      .getPicture(),
                                                ),
                                                Container(
                                                  // name of user
                                                  child: Text(design
                                                      .getUser()
                                                      .getUserName()),
                                                ),
                                              ],
                                            ),

                                            // right side of bottom row
                                            Row(
                                              children: <Widget>[
                                                // display the number of comments
                                                Text(
                                                    '${design.getComments().length}'),
                                                Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                globalMargin /
                                                                    2),
                                                    child: Icon(Icons
                                                        .chat_bubble_outline))
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ));
                              })),
                            )
                          ],
                        ))
                  ])
            ])));
  }
}

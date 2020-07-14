import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pictureit/Elements/idea.dart';
import 'package:pictureit/Tools/brainstorming.dart';
import 'package:pictureit/Tools/voting.dart';

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

class Voting2 extends StatefulWidget {
  List<Idea> top3;

  Voting2(List<Idea> top3) {
    this.top3 = top3;
  }

  @override
  Voting2State createState() => Voting2State(top3);
}

class Voting2State extends State<Voting2> {
  // list of the top 3 ideas from the first voting phase
  List<Idea> top3;
  Idea top;

  bool checked = false;

  Voting2State(List<Idea> top3) {
    this.top3 = top3;
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
                  Text('Voting P1',
                      style: TextStyle(color: Colors.black, fontSize: 35)),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: globalMargin),
                      child: Column(children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(vertical: globalMargin),
                          child: Text(
                              "This is a list of all the prototype ideas that you and your team came up with! To narrow down the scope of the project, one idea needs to be decided on as the solution the group will be focusing on.",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: globalMargin),
                          child: Text(
                              "Please choose your top three ideas from the list!",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                        ),

                        // displaying all the ideas from the previous brainstorming session
                        Container(
                            margin: EdgeInsets.all(globalMargin),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: boxColor,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(borderRadius)),
                            ),
                            child: Column(
                                // create a list of children based on the number of ideas from the previous page
                                children: List.generate(top3.length, (index) {
                              var idea = top3[index];

                              // row containing idea and checkbox
                              return Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: globalMargin),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          idea.getIdeaName(),
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        // upon checking the checkbox, add it to the array
                                        Checkbox(
                                            value: idea.getChecked(),
                                            onChanged: (bool value) {
                                              setState(() {
                                                vote(top, idea);
                                                idea.setChecked(
                                                    !idea.getChecked());
                                              });
                                              print(top);
                                            })
                                      ]));
                            }))),
                      ])),

                  // Button for moving to the next page
                  Container(
                      margin: EdgeInsets.symmetric(vertical: globalMargin),
                      child: RaisedButton(
                          color: boxColor,
                          splashColor: Colors.blueAccent,
                          padding: EdgeInsets.all(20),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Brainstorming()));
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

// function for adding the new idea into the list, and removing the old ones if the list is over the cap
void vote(Idea top, Idea vote) {
  if (top is Idea && vote is Idea) {
    if (top != vote) {
      if (top != null) {
        top.setChecked(!top.getChecked());
        top = vote;
      }
      top = vote;
    }
  }
}

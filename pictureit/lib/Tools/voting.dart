import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pictureit/Tools/brainstorming.dart';

// color setups
const backgroundColor = Color(0xFFE7FBF4);
const headingColor = Colors.white;
const boxColor = Color(0xFF94DFD2);
const arrowColor = Color(0xFFFFF7BF);

// padding, margin, and border radius setup
const globalPadding = 15.0;
const globalMargin = 15.0;
const borderRadius = 10.0;

class Voting1 extends StatefulWidget {
  List<String> ideas;

  Voting1(List<String> ideas) {
    this.ideas = ideas;
  }

  @override
  Voting1State createState() => Voting1State(ideas);
}

class Voting1State extends State<Voting1> {
  List<String> ideas;
  List<String> votes = [];

  bool checked = false;

  Voting1State(List<String> ideas) {
    this.ideas = ideas;
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
                                children: List.generate(ideas.length, (index) {
                              // row containing idea and checkbox
                              return Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: globalMargin),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          ideas[index].toString(),
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        // upon checking the checkbox, add it to the array
                                        Checkbox(
                                            value: checked,
                                            onChanged: (bool value) {
                                              setState(() {
                                                votedList(votes,
                                                    ideas[index].toString());
                                                checked = !checked;
                                              });
                                              print(votes);
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
                                    builder: (context) => Voting1(ideas)));
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

void votedList(List<String> votes, String vote) {
  if (votes.contains(vote)) {
    votes.remove(vote);
  } else {
    votes.add(vote);
  }
}

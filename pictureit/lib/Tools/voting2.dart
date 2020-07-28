import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pictureit/Data/design.dart';
import 'package:pictureit/Data/idea.dart';
import 'package:pictureit/Tools/brainstorming.dart';
import 'package:pictureit/Tools/designing.dart';
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
  // list of the vote, using type list in order to work around a technial issue of not being able to set the instance variable through the method
  // also what will be passed onto the next page
  List<Idea> top = [];

  bool checked = false;

  Voting2State(List<Idea> top3) {
    this.top3 = top3;
    for (var i = 0; i < top3.length; i++) {
      top3[i].setChecked(false);
    }
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
                  Text('Voting P2',
                      style: TextStyle(color: Colors.black, fontSize: 35)),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: globalMargin),
                      child: Column(children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(vertical: globalMargin),
                          child: Text(
                              "This is a list of the top 3 ideas that were selected from the previous list of ideas",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: globalMargin),
                          child: Text(
                              "Please choose your favorite idea from these three options!",
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
                                              print('top: ' + top.toString());
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
                            List<Design> designs = [];
                            Navigator.push(
                                context,
                                // where the button will be leading to the next page
                                MaterialPageRoute(
                                    builder: (context) => Designing(designs)));
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

// function for having the top 1 vote
void vote(List<Idea> top, Idea vote) {
  if (top is List<Idea> && vote is Idea) {
    if (top.contains(vote)) {
      top.remove(vote);
    } else {
      top.add(vote);
      if (top.length > voteLimit) {
        top[0].setChecked(!top[0].getChecked());
        top.removeAt(0);
      }
    }
  } else {
    print("the types of the list and object don't match :(");
    print(top.runtimeType);
    print(vote.runtimeType);
  }
}

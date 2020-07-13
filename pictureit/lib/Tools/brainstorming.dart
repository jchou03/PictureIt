import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pictureit/Tools/gettingStarted.dart';
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

class Brainstorming extends StatelessWidget {
  // Create a text controller and use it to retrieve the current value of the TextField.
  final myController = TextEditingController();

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
                  Text('Brainstorming',
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
                                "This is a place for POSSIBLE solutions, including seemingly crazy ones, NOT for shooting ideas down. If you're more of a visual thinker, get a pad of sticky notes or paper and spend 10 minutes writing 1-10 ideas down.",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20)),
                          ),
                          Container(
                              margin: EdgeInsets.all(globalMargin),
                              child: Text(
                                'What are some possible solutions to the problem?',
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
                              controller: myController,
                              autocorrect: true,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText:
                                      ' • Describe the person affected here'),
                            ),
                          ),
                        ],
                      )),

                  // Button for moving to the next page
                  Container(
                      margin: EdgeInsets.symmetric(vertical: globalMargin),
                      child: RaisedButton(
                          color: boxColor,
                          splashColor: Colors.blueAccent,
                          padding: EdgeInsets.all(20),
                          onPressed: () {
                            // for moving the text forward
                            String ideas = myController.text;
                            List<String> ideaList = ideasList(ideas);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Voting1(ideaList)));
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

// returns a list of strings where each idea is seperated by a new line (this even works for longer inputs where the text wraps, but there isn't a direct new line input)
List<String> ideasList(String textInput) {
  print(textInput);
  var ideaArray = textInput.split('\n');
  print(ideaArray);
  return ideaArray;
}

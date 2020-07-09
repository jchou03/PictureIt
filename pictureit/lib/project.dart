import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// variable setup for the app
// color setups
const backgroundColor = Color(0xFFE7FBF4);
const headingColor = Colors.white;
const boxColor = Color(0xFF94DFD2);
const arrowColor = Color(0xFFFFF7BF);
// padding, margin, and border radius setup
const globalPadding = 15.0;
const globalMargin = 15.0;
const borderRadius = 10.0;

// variables for icon changing
var importantIcon = Icons.favorite_border;
var importantColor = Colors.black;

class Project extends StatelessWidget {
  String title;
  String description;
  String projectLeader;
  Image profilePic;
  Image image;
  int likes = 0;
  int numComments;

  Project(
    String title,
    String description,
    String projectLeader,
    Image profilePic,
    Image image,
  ) {
    this.title = title;
    this.description = description;
    this.projectLeader = projectLeader;
    this.profilePic = profilePic;
    this.image = image;
  }

  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(globalPadding),
      margin: EdgeInsets.all(globalMargin),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.white),
      // the column containing the content
      child: Column(children: <Widget>[
        Row(
          children: <Widget>[
            // the expanded class makes it so the text doesn't run off of the screen
            Expanded(child: Text(title)),
            // button for joining the project
            FlatButton(
              color: boxColor,
              textColor: arrowColor,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              onPressed: () {},
              child: Text('Join Project'),
            ),
          ],
        ),

        // add a margin to the image so it doesn't go right up to the text
        Container(
          margin: EdgeInsets.all(globalMargin),
          child: image,
          width: MediaQuery.of(context).size.width,
        ),

        // row to display pfp, name, and exclamation points
        Row(
          // to space between
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // left side of of the bar under
            Row(
              children: <Widget>[
                profilePic,
                Text(projectLeader),
              ],
            ),

            // right side of the bar under
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(importantIcon),
                  color: importantColor,
                  onPressed: () {
                    print("pressed");
/*                    setState(() {
                      if (importantColor == Colors.redAccent) {
                        importantColor = Colors.black;
                        importantIcon = Icons.favorite_border;
                        likes--;
                      } else {
                        importantColor = Colors.redAccent;
                        importantIcon = Icons.favorite;
                        likes++;
                      }
                    });*/
                  },
                )
              ],
            )
          ],
        ),

        // description of the project
        Text(description),
      ]),
    );
  }
}

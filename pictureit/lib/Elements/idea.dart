import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class for holding the data for ideas during voting
class Idea extends StatefulWidget {
  String idea;

  Idea(String idea) {
    this.idea = idea;
  }

  IdeaState createState() => IdeaState(idea);
}

class IdeaState extends State<Idea> {
  bool checked = false;
  String idea;

  IdeaState(String idea) {
    this.idea = idea;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          idea,
          style: TextStyle(),
        ),
        Checkbox(
            value: checked,
            onChanged: (bool value) {
              setState(() {
                checked = !checked;
              });
            })
      ],
    );
  }
}

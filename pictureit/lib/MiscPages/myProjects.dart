import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pictureit/Data/user.dart';

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
    return Scaffold();
  }
}

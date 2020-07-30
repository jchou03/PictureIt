import 'package:flutter/cupertino.dart';
import 'package:pictureit/Data/design.dart';
import 'package:pictureit/Data/idea.dart';
import 'package:pictureit/Data/user.dart';

// class to hold the data of the project
class Project {
  // each variable will hold the value that the user puts into each page
  String gettingStarted;
  String empathy1;
  String empathy2;
  String defining1;
  String defining2;
  List<Idea> ideas;
  List<Idea> top3;
  List<Idea> top;
  List<Design> designs;

  // overall project variables (like user creator)
  int stage;
  User creator;

  Project() {
    gettingStarted = "";
    empathy1 = "";
    empathy2 = "";
    defining1 = "";
    defining2 = "";
    ideas = [];
    top3 = [];
    top = [];
    designs = [];

    stage = 0;
    User defaultUser = new User('David',
        Image.asset('assets/images/Screenshot (437).png'), 'email@gmail.com');
    creator = defaultUser;
  }

  // specific constructor which lets you specify specific values for items
  Project.specific(
      String gettingStarted,
      String empathy1,
      String empathy2,
      String defining1,
      String defining2,
      List<Idea> ideas,
      List<Idea> top3,
      List<Idea> top,
      List<Design> designs,
      int stage) {
    this.gettingStarted = gettingStarted;
    this.empathy1 = empathy1;
    this.empathy2 = empathy2;
    this.defining1 = defining1;
    this.defining2 = defining2;
    this.ideas = ideas;
    this.top3 = top3;
    this.top = top;
    this.designs = designs;
    this.stage = stage;

    // defaults if they are null
    if (gettingStarted == null) this.gettingStarted = "";
    if (empathy1 == null) this.empathy1 = '';
    if (empathy2 == null) this.empathy2 = '';
    if (defining1 == null) this.defining1 = '';
    if (defining2 == null) this.defining2 = '';
    if (ideas == null) this.ideas = [];
    if (top3 == null) this.top3 = [];
    if (top == null) this.top = [];
    if (designs == null) this.designs = [];
    if (stage == null) this.stage = 0;
  }

  // getters for each variable
  String getGettingStarted() {
    return gettingStarted;
  }

  String getEmpathy1() {
    return empathy1;
  }

  String getEmpathy2() {
    return empathy2;
  }

  String getDefining1() {
    return defining1;
  }

  String getDefining2() {
    return defining2;
  }

  List<Idea> getIdeas() {
    return ideas;
  }

  List<Idea> getTop3() {
    return top3;
  }

  List<Idea> getTop() {
    return top;
  }

  List<Design> getDesigns() {
    return designs;
  }

  int getStage() {
    return stage;
  }

  User getCreator() {
    return creator;
  }

  // setters for each variable
  void setGettingStarted(String gettingStarted) {
    this.gettingStarted = gettingStarted;
  }

  void setEmpathy1(String empathy1) {
    this.empathy1 = empathy1;
  }

  void setEmpathy2(String empathy2) {
    this.empathy2 = empathy2;
  }

  void setDefining1(String defining1) {
    this.defining1 = defining1;
  }

  void setDefining2(String defining2) {
    this.defining2 = defining2;
  }

  void setIdeas(List<Idea> ideas) {
    this.ideas = ideas;
  }

  void setTop3(List<Idea> top3) {
    this.top3 = top3;
  }

  void setTop(List<Idea> top) {
    this.top = top;
  }

  void setDesigns(List<Design> designs) {
    this.designs = designs;
  }

  void setStage(int stage) {
    this.stage = stage;
  }

  void setCreator(User creator) {
    this.creator = creator;
  }
}

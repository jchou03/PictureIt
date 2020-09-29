import 'package:flutter/cupertino.dart';
import 'package:pictureit/Data/design.dart';
import 'package:pictureit/Data/idea.dart';
import 'package:pictureit/Data/user.dart';
import 'package:pictureit/Data/comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// class to hold the data of the project
// holds all user writing and selected ideas
class Project {
  // each variable will hold the value that the user puts into each page
  // stores string value of text on GettingStarted page
  String gettingStarted;
  // stores the value of the first text box on the Empathy page
  String empathy1;
  // stores the value of the second text box on the Empathy page
  String empathy2;
  // stores the value of the first text box on the Defining page
  String defining1;
  // stores the value of the second text box on the Defining page
  String defining2;
  // stores the text value of the Brainstorming page
  String brainstorming;
  // stores the List of Idea(s) that are created based on the parsed string above
  List<Idea> ideas;
  // stores the List of Idea(s) that are the top 3 ideas
  List<Idea> top3;
  // stores the top voted Idea
  List<Idea> top;
  // stores the List of Design(s) that are basically all the prototypes
  List<Design> designs;
  // Stored comments
  List<Comment> comments;
  // Time created
  DateTime time;

  // overall project variables (like user creator)
  // stores the stage that the project is on (as a number, 0 index)
  int stage;
  // stores the list of possible stages for the project (same for all projects)
  List<String> stages = [
    'Perspectives',
    'Define',
    'Brainstorm',
    'Voting',
    'Designing & Feedback'
  ];
  // stores the User that created the project
  User creator;
  // the title of the project
  String title;
  // the description of the project
  String description;

  // the list of collaborators
  List<User> collaborators;
  // the list of followers
  List<User> followers;

  Project() {
    gettingStarted = "";
    empathy1 = "";
    empathy2 = "";
    defining1 = "";
    defining2 = "";
    brainstorming = "";
    ideas = [];
    top3 = [];
    top = [];
    designs = [];

    stage = 0;
    User defaultUser = new User('David', 'password123',
        'assets/images/Screenshot (437).png', 'email@gmail.com');
    creator = defaultUser;
    title = 'Project Title';
    description = 'Project description';

    collaborators = [];
    followers = [];
  }

  // specific constructor which lets you specify specific values for items
  Project.specific(
      String gettingStarted,
      String empathy1,
      String empathy2,
      String defining1,
      String defining2,
      String brainstorming,
      List<Idea> ideas,
      List<Idea> top3,
      List<Idea> top,
      List<Design> designs,
      List<Comment> comments,
      DateTime time,
      int stage,
      User creator,
      String title,
      String description) {
    this.gettingStarted = gettingStarted;
    this.empathy1 = empathy1;
    this.empathy2 = empathy2;
    this.defining1 = defining1;
    this.defining2 = defining2;
    this.brainstorming = brainstorming;
    this.ideas = ideas;
    this.top3 = top3;
    this.top = top;
    this.designs = designs;
    this.comments = comments;
    this.time = time;
    this.stage = stage;
    this.creator = creator;
    this.title = title;
    this.description = description;
    this.collaborators = [];
    this.followers = [];

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
    if (creator == null)
      this.creator = new User('David', 'password123',
          'assets/images/Screenshot (437).png', 'email@gmail.com');
    if (title == null) this.title = 'Project Title';
    if (description == null) this.description = 'Project description';
    if (collaborators == null) this.collaborators = [];
    if (followers == null) this.followers = [];

    collaborators.add(creator);
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

  String getBrainstorming() {
    return brainstorming;
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

  List<String> getStages() {
    return stages;
  }

  User getCreator() {
    return creator;
  }

  String getTitle() {
    return title;
  }

  String getDescription() {
    return description;
  }

  List<User> getCollaborators() {
    return collaborators;
  }

  List<User> getFollowers() {
    return followers;
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

  void setBrainstorming(String brainstorming) {
    this.brainstorming = brainstorming;
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

  void setTitle(String title) {
    this.title = title;
  }

  void setDescription(String description) {
    this.description = description;
  }

  void setCollaborators(List<User> collaborators) {
    this.collaborators = collaborators;
  }

  void setFollowers(List<User> followers) {
    this.followers = followers;
  }
}

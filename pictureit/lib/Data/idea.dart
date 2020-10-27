import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class for holding the data for ideas during voting
class Idea {
  String ideaName;
  bool checked;
  String firebaseID;

  Idea(String ideaName) {
    this.ideaName = ideaName;
    checked = false;
    firebaseID = "";
  }

  Idea.customChecked(String ideaName, bool checked, String firebaseID) {
    this.ideaName = ideaName;
    this.checked = checked;
    this.firebaseID = firebaseID;
  }

  String getIdeaName() {
    return ideaName;
  }

  bool getChecked() {
    return checked;
  }

  String getFirebaseID() {
    return firebaseID;
  }

  void setIdeaName(String ideaName) {
    this.ideaName = ideaName;
  }

  void setChecked(bool checked) {
    this.checked = checked;
  }

  void setFirebaseID(String firebaseID) {
    this.firebaseID = firebaseID;
  }

  @override
  String toString() {
    return ideaName;
  }
}

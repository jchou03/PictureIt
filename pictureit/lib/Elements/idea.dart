import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class for holding the data for ideas during voting
class Idea {
  String ideaName;
  bool checked;

  Idea(String ideaName) {
    this.ideaName = ideaName;
    checked = false;
  }

  Idea.customChecked(String ideaName, bool checked) {
    this.ideaName = ideaName;
    this.checked = checked;
  }

  String getIdeaName() {
    return ideaName;
  }

  bool getChecked() {
    return checked;
  }

  void setIdeaName(String ideaName) {
    this.ideaName = ideaName;
  }

  void setChecked(bool checked) {
    this.checked = checked;
  }

  @override
  String toString() {
    return ideaName;
  }
}

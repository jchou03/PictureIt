import 'package:flutter/cupertino.dart';
import 'package:pictureit/Data/project.dart';

// data type to store data for a userName
class User {
  String userName;
  Image picture;
  String contact;
  List<Project> projects;
  List<Project> followedProjects;

  User(String userName, Image picture, String contact) {
    this.userName = userName;
    this.picture = picture;
    this.contact = contact;
    this.projects = [];
    this.followedProjects = [];
  }

  User.withProjects(String userName, Image picture, String contact,
      List<Project> projects, List<Project> followedProjects) {
    this.userName = userName;
    this.picture = picture;
    this.contact = contact;
    this.projects = projects;
    this.followedProjects = followedProjects;
  }

  String getUserName() {
    return userName;
  }

  Image getPicture() {
    return picture;
  }

  String getContact() {
    return contact;
  }

  List<Project> getProjects() {
    return projects;
  }

  List<Project> getFollowedProjects() {
    return followedProjects;
  }

  void setuserName(String userName) {
    this.userName = userName;
  }

  void setPicture(Image picture) {
    this.picture = picture;
  }

  void setContact(String contact) {
    this.contact = contact;
  }

  void setProjects(List<Project> projects) {
    this.projects = projects;
  }

  void setFollowedProjects(List<Project> followedProjects) {
    this.followedProjects = followedProjects;
  }

  String toString() {
    return userName;
  }
}

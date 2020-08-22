import 'package:flutter/cupertino.dart';
import 'package:pictureit/Data/project.dart';

// data type to store data for a userName
class User {
  String userName;
  String password;
  String picture;
  String contact;
  List<Project> projects;
  List<Project> followedProjects;

  User(String userName, String password, String picture, String contact) {
    this.userName = userName;
    this.password = password;
    this.picture = picture;
    this.contact = contact;
    this.projects = [];
    this.followedProjects = [];
  }

  User.withProjects(String userName, String password, String picture,
      String contact, List<Project> projects, List<Project> followedProjects) {
    this.userName = userName;
    this.password = password;
    this.picture = picture;
    this.contact = contact;
    this.projects = projects;
    this.followedProjects = followedProjects;
  }

  String getUserName() {
    return userName;
  }

  String getPassword() {
    return password;
  }

  String getPicture() {
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

  void setPassword(String password) {
    this.password = password;
  }

  void setPicture(String picture) {
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

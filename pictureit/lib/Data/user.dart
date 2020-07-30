import 'package:flutter/cupertino.dart';

// data type to store data for a userName
class User {
  String userName;
  Image picture;
  String contact;

  User(String userName, Image picture, String contact) {
    this.userName = userName;
    this.picture = picture;
    this.contact = contact;
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

  void setuserName(String userName) {
    this.userName = userName;
  }

  void setPicture(Image picture) {
    this.picture = picture;
  }

  void setContact(String contact) {
    this.contact = contact;
  }

  String toString() {
    return userName;
  }
}

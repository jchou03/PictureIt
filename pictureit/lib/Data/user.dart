import 'package:flutter/cupertino.dart';

// data type to store data for a user
class User {
  String user;
  Image picture;
  String contact;

  User(String user, Image picture, String contact) {
    this.user = user;
    this.picture = picture;
    this.contact = contact;
  }

  String getUser() {
    return user;
  }

  Image getPicture() {
    return picture;
  }

  String getContact() {
    return contact;
  }

  void setUser(String user) {
    this.user = user;
  }

  void setPicture(Image picture) {
    this.picture = picture;
  }

  void setContact(String contact) {
    this.contact = contact;
  }

  String toString() {
    return user;
  }
}

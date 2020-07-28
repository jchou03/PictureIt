import 'package:flutter/cupertino.dart';

// data type to store data for a user
class User {
  String user;
  Image picture;

  User(String user, Image picture) {
    this.user = user;
    this.picture = picture;
  }

  String getUser() {
    return user;
  }

  Image getPicture() {
    return picture;
  }

  void setUser(String user) {
    this.user = user;
  }

  void setPicture(Image picture) {
    this.picture = picture;
  }

  String toString() {
    return user;
  }
}

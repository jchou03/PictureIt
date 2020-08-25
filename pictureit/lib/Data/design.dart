import 'package:flutter/cupertino.dart';
import 'package:pictureit/Data/comment.dart';
import 'package:pictureit/Data/user.dart';

// this class is for holding data for the prototype/design
class Design {
  String title;
  String image;
  User user;
  int likes;
  List<Comment> comments;

  Design(String title, String image, User user, List<Comment> comments) {
    this.title = title;
    this.image = image;
    this.user = user;
    this.likes = 0;
    this.comments = comments;
  }

  String getTitle() {
    return title;
  }

  String getImage() {
    return image;
  }

  User getUser() {
    return user;
  }

  int getLikes() {
    return likes;
  }

  List<Comment> getComments() {
    return comments;
  }

  void setTitle(String title) {
    this.title = title;
  }

  void setImage(String image) {
    this.image = image;
  }

  void setUser(User user) {
    this.user = user;
  }

  void setLikes(int likes) {
    this.likes = likes;
  }

  void setComments(List<Comment> comments) {
    this.comments = comments;
  }
}

import 'package:pictureit/Data/user.dart';

// data type to store comments
class Comment {
  User user;
  String text;
  DateTime time;

  Comment(User user, String text, DateTime time) {
    this.user = user;
    this.text = text;
    this.time = time;
  }

  User getUser() {
    return user;
  }

  String getText() {
    return text;
  }

  DateTime getTime() {
    return time;
  }

  void setUser(User user) {
    this.user = user;
  }

  void setText(String text) {
    this.text = text;
  }
}

// working on formatting Firebase to store all the data types then work on uploading them to the database

import 'package:pictureit/Data/user.dart';

// data type to store comments
class Comment {
  User user;
  String text;

  Comment(User user, String text) {
    this.user = user;
    this.text = text;
  }

  User getUser() {
    return user;
  }

  String getText() {
    return text;
  }

  void setUser(User user) {
    this.user = user;
  }

  void setText(String text) {
    this.text = text;
  }
}

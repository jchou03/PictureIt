import 'package:flutter/material.dart';
import 'package:pictureit/Data/user.dart';

class CommentModel {
  final User user;
  final String comment;
  final DateTime time;

  const CommentModel({
    @required this.user,
    @required this.comment,
    @required this.time,
  });
}

import 'package:flutter/material.dart';
import 'package:pictureit/Comments/UserModel.dart';

class CommentModel {
  final UserModel user;
  final String comment;
  final DateTime time;

  const CommentModel({
    @required this.user,
    @required this.comment,
    @required this.time,
  });
}

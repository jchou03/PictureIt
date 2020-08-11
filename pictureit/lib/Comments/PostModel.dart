import 'package:flutter/material.dart';
import 'package:pictureit/Comments/UserModel.dart';
import 'package:pictureit/Comments/CommentModel.dart';

class PostModel {
  final String id;
  final String title;
  final String body;
  final String imageURL;
  final DateTime postTime;
  final List<CommentModel> comments;
  final int views;
  final UserModel author;

  const PostModel({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.imageURL,
    @required this.author,
    @required this.postTime,
    @required this.comments,
    @required this.views,
  });

  // String get postTimeFormatted => DateFormat.yMMMMEEEEd().format(postTime);
}

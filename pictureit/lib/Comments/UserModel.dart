import 'package:flutter/material.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String image;
  final DateTime joined;
  final int posts;

  const UserModel({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.image,
    @required this.joined,
    @required this.posts,
  });

  //String get postTimeFormatted => DateFormat.yMMMMEEEEd().format(joined);
}

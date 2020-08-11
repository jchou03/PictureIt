import 'package:flutter/material.dart';
import 'package:pictureit/Comments/PostCard.dart';
import 'package:pictureit/Comments/Test.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EnvisionIt"),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return PostCard(postData: Test.posts[0]);
        },
      ),
    );
  }
}

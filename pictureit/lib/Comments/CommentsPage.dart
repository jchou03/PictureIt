import 'package:flutter/material.dart';
import 'package:pictureit/Comments/InheritedPostModel.dart';
import 'package:pictureit/Data/comment.dart';
import 'package:pictureit/Comments/Test.dart';

class CommentsPageState extends StatefulWidget {
  @override
  createState() => new CommentsPageStates();
}

class CommentsPageStates extends State<CommentsPageState> {
  void addComment(List<Comment> comment, Comment val) {
    setState(() {
      comment.add(val);
    });
  }

  Widget buildCommentItem(String comment) {
    return ListTile(title: Text(comment));
  }

  @override
  Widget build(BuildContext context) {
    final List<Comment> comments =
        InheritedPostModel.of(context).postData.comments;
    return Scaffold(
        appBar: AppBar(title: Center(child: Text("EnvisionIt"))),
        body: Column(children: <Widget>[
          Expanded(child: ListView.builder(itemBuilder: (context, index) {
            if (index < comments.length) {
              return buildCommentItem(comments[index].text);
            }
          })),
          TextField(
            onSubmitted: (String submittedStr) {
              addComment(
                  comments,
                  new Comment(
                      Test.users[0], submittedStr, DateTime(2018, 5, 30)));
            },
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(20.0),
                hintText: "Add Comment"),
          )
        ]));
  }
}

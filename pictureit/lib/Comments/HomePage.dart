import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pictureit/Comments/Test.dart';
import 'package:pictureit/Data/comment.dart';
import 'dart:async';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("EnvisionIt"))),
      body: Post(),
    );
  }
}

class Post extends StatefulWidget {
  @override
  PostState createState() => PostState();
}

class PostState extends State<Post> {
  bool joined = false;
  bool showJoined = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Center(child: Text(Test.posts[0].title)),
      GestureDetector(
        onDoubleTap: () {
          setState(() {
            showJoined = true;
            joined = true;
            if (showJoined) {
              Timer(const Duration(milliseconds: 500), () {
                setState(() {
                  showJoined = false;
                });
              });
            }
          });
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset("assets/images/Screenshot (437).png"),
            showJoined
                ? Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 80.0,
                  )
                : Container()
          ],
        ),
      ),
      ListTile(
          contentPadding: EdgeInsets.all(10.0),
          leading: Row(children: [
            CircleImage(),
            Container(
                padding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                child: Text(
                  Test.users[0].userName,
                  style: TextStyle(
                      fontFamily: 'Robot',
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600),
                ))
          ]),
          trailing: Row(children: [
            IconButton(
              icon: Icon(Icons.comment, color: Colors.grey),
              onPressed: () {
                setState(() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CommentsPage()));
                });
              },
            ),
            IconButton(
              icon: Icon(joined ? Icons.add_box : Icons.cancel,
                  color: Colors.grey),
              onPressed: () {
                setState(() {
                  joined = !joined;
                });
              },
            ),
          ]))
    ]));
  }
}

class CircleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.0,
      height: 45.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage(Test.users[0].picture))),
    );
  }
}

class CommentsPage extends StatefulWidget {
  @override
  createState() => new CommentsPageState();
}

class CommentsPageState extends State<CommentsPage> {
  @override
  Widget build(BuildContext context) {
    final List<Comment> comments = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: new AppBar(title: Center(child: Text("Comments"))),
        body: Text("Comments Page"));
  }
}

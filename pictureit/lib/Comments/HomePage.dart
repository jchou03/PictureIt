import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pictureit/Comments/PostCard.dart';
import 'package:pictureit/Comments/Test.dart';
import 'package:pictureit/Data/user.dart';
import 'package:flutter/src/widgets/image.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Center(child: Text("EnvisionIt"))),
        body: Column(children: <Widget>[
          Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
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
                ],
              )),
          Image.asset(Test.posts[0].imageURL),
          ListTile(
              leading: Icon(
            Icons.lock,
            color: Colors.grey,
          ))
        ]));
  }
}

class CircleImage extends StatelessWidget {
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

//ListView.builder(
//    itemCount: 1,
//  itemBuilder: (BuildContext context, int index) {
//  return PostCard(postData: Test.posts[0]);

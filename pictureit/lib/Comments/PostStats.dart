import 'package:flutter/material.dart';
import 'package:pictureit/Data/project.dart';
import 'package:pictureit/Comments/InheritedPostModel.dart';

class PostStats extends StatelessWidget {
  const PostStats({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Project postData = InheritedPostModel.of(context).postData;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _ShowStat(
          icon: Icons.remove_red_eye,
          number: postData.followers.length + postData.collaborators.length,
          color: Colors.green[900],
        ),
      ],
    );
  }
}

class _ShowStat extends StatelessWidget {
  final IconData icon;
  final int number;
  final Color color;

  const _ShowStat({
    Key key,
    @required this.icon,
    @required this.number,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 2.0),
          child: Icon(icon, color: color),
        ),
        Text(number.toString()),
      ],
    );
  }
}

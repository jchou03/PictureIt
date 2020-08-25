import 'package:flutter/material.dart';
import 'package:pictureit/Data/user.dart';
import 'package:pictureit/Comments/InheritedUserModel.dart';

bool isLandscape(BuildContext context) =>
    MediaQuery.of(context).orientation == Orientation.landscape;

class UserDetails extends StatelessWidget {
  final User userData;

  const UserDetails({Key key, @required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InheritedUserModel(
      userData: userData,
      child: Container(
        child: Row(children: <Widget>[_UserImage(), _UserNameAndEmail()]),
      ),
    );
  }
}

class _UserNameAndEmail extends StatelessWidget {
  const _UserNameAndEmail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User userData = InheritedUserModel.of(context).userData;
    final TextStyle nameTheme = Theme.of(context).textTheme.subtitle;
    final TextStyle emailTheme = Theme.of(context).textTheme.body1;
    final int flex = isLandscape(context) ? 10 : 5;

    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(userData.userName, style: nameTheme),
            SizedBox(height: 2.0),
            Text(userData.contact, style: emailTheme),
          ],
        ),
      ),
    );
  }
}

class _UserImage extends StatelessWidget {
  const _UserImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User userData = InheritedUserModel.of(context).userData;
    return Expanded(
      flex: 1,
      child: CircleAvatar(backgroundImage: AssetImage(userData.picture)),
    );
  }
}

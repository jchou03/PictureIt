import 'package:flutter/material.dart';
import 'package:pictureit/Data/user.dart';

class InheritedUserModel extends InheritedWidget {
  final User userData;
  final Widget child;

  InheritedUserModel({Key key, @required this.userData, this.child})
      : super(key: key, child: child);

  static InheritedUserModel of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(InheritedUserModel)
        as InheritedUserModel);
  }

  @override
  bool updateShouldNotify(InheritedUserModel oldWidget) {
    return true;
  }
}

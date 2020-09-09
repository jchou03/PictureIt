import 'package:flutter/material.dart';
import 'package:pictureit/Data/project.dart';

class InheritedPostModel extends InheritedWidget {
  final Project postData;
  final Widget child;

  InheritedPostModel({
    Key key,
    @required this.postData,
    this.child,
  }) : super(key: key, child: child);

  static InheritedPostModel of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(InheritedPostModel)
        as InheritedPostModel);
  }

  @override
  bool updateShouldNotify(InheritedPostModel oldWidget) {
    return true;
  }
}

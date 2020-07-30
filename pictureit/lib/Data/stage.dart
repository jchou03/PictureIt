import 'package:flutter/cupertino.dart';

class Stage {
  String name;
  Widget page;

  Stage(String name, Widget page) {
    this.name = name;
    this.page = page;
  }

  String getName() {
    return name;
  }

  Widget getPage() {
    return page;
  }

  void setName(String name) {
    this.name = name;
  }

  void setPage(Widget page) {
    this.page = page;
  }
}

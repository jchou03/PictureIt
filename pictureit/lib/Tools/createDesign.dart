import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pictureit/Data/comment.dart';
import 'package:pictureit/Data/design.dart';
import 'package:pictureit/Data/project.dart';
import 'package:pictureit/Data/user.dart';
import 'package:pictureit/Tools/designing.dart';

// color setups
const backgroundColor = Color(0xFFE7FBF4);
const headingColor = Colors.white;
const boxColor = Color(0xFF94DFD2);
const arrowColor = Color(0xFFFFF7BF);

// padding, margin, and border radius setup
const globalPadding = 15.0;
const globalMargin = 15.0;
const borderRadius = 10.0;

class CreateDesign extends StatefulWidget {
  Project project;

  CreateDesign(Project project) {
    this.project = project;
  }

  CreateDesignState createState() => CreateDesignState(project);
}

class CreateDesignState extends State<CreateDesign> {
  Project project;
  List<Design> designs;

  CreateDesignState(Project project) {
    this.project = project;
    designs = project.getDesigns();
  }

  // Create a text controller and use it to retrieve the current value of the TextField.
  final myController = TextEditingController();

  // image picker variables
  File image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('PictureIt'),
          backgroundColor: headingColor,
        ),
        body: Container(
            padding: EdgeInsets.all(globalPadding),
            color: backgroundColor,
            width: MediaQuery.of(context).size.width,
            // listview so it can scroll
            child: ListView(children: <Widget>[
              Center(
                child: image == null
                    ? Text('No Image Selected')
                    : Image.file(image),
              ),
              RaisedButton(
                  child: Text('Pick Image from Phone'),
                  onPressed: () {
                    getImage();
                  }),
              // text box for title of prototype
              Container(
                color: boxColor,
                margin: EdgeInsets.symmetric(vertical: globalPadding),
                child: TextField(
                  minLines: 1,
                  maxLines: 5,
                  controller: myController,
                  autocorrect: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText:
                          'Please put the description of your prototype here'),
                ),
              ),

              // Button for moving to the next page
              Container(
                  margin: EdgeInsets.symmetric(vertical: globalMargin),
                  child: RaisedButton(
                      color: boxColor,
                      splashColor: Colors.blueAccent,
                      padding: EdgeInsets.all(20),
                      onPressed: () {
                        User testUser = new User(
                            'name',
                            Image.asset(
                              "assets/images/Screenshot (437).png",
                              height: 50,
                            ),
                            'contactMe@gmail.com');
                        List<Comment> comments = [];
                        Design design = new Design(myController.text,
                            Image.file(image), testUser, comments);
                        // update designs with new design
                        designs.add(design);
                        project.setDesigns(designs);

                        Navigator.push(
                            context,
                            // where the button will be leading to the next page
                            MaterialPageRoute(
                                builder: (context) => Designing(project)));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Post",
                            style: TextStyle(color: arrowColor, fontSize: 20),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: arrowColor,
                            size: 20,
                          )
                        ],
                      )))
            ])));
  }
}

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pictureit/Data/comment.dart';
import 'package:pictureit/Data/design.dart';
import 'package:pictureit/Data/project.dart';
import 'package:pictureit/Data/user.dart';
import 'package:pictureit/Tools/designing.dart';
import 'package:pictureit/Tools/gettingStarted.dart';

const backgroundColor = Color(0xFFE7FBF4);
const headingColor = Colors.white;
const boxColor = Color(0xFF94DFD2);
const arrowColor = Color(0xFFFFF7BF);

// padding, margin, and border radius setup
const globalPadding = 15.0;
const globalMargin = 15.0;
const borderRadius = 10.0;

class CreateProject extends StatefulWidget {
  User user;

  CreateProject(User user) {
    this.user = user;
  }

  CreateProjectState createState() => CreateProjectState(user);
}

class CreateProjectState extends State<CreateProject> {
  User user;

  CreateProjectState(User user) {
    this.user = user;
  }

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

  // variables for text retrieval
  String title = 'null title';
  String description = 'null description';

  // variables for checking if the person will lead project or not
  List<bool> leadingOptions = [false, false];

  Widget build(BuildContext context) {
    double textWidth = MediaQuery.of(context).size.width * 4 / 5;

    return Scaffold(
        // appbar is the header
        appBar: AppBar(
          title: Text('PictureIt'),
          backgroundColor: headingColor,
        ),
        // container for body of page
        body: Container(
          padding: EdgeInsets.all(globalPadding),
          color: backgroundColor,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // title
                  Text('New Post',
                      style: TextStyle(color: Colors.black, fontSize: 35)),
                  // the top part with instructions
                  Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(globalMargin),
                      padding: EdgeInsets.all(globalPadding),
                      child: Column(children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: globalMargin),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RaisedButton(
                                  color: boxColor,
                                  onPressed: () => {getImage()},
                                  child: Icon(Icons.add_a_photo)),
                              RaisedButton(
                                  color: boxColor,
                                  onPressed: () => {getImage()},
                                  child: Icon(Icons.attach_file)),
                            ],
                          ),
                        ),

                        //Icon(Icons.add_a_photo),
                        Container(
                          width: textWidth,
                          child: Text(
                              'Take a photo/video to show others what the problem looks like or upload a photo/video you already took',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18)),
                        ),
                      ])),
                  // displaying the current project
                  Text(
                    'Review your post before you submit',
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                  // horizontal line divider
                  Divider(color: boxColor, height: 10, thickness: 2),
                  Container(
                    margin: EdgeInsets.all(globalMargin),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          minLines: 1,
                          maxLines: 5,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText:
                                  'Please put the title of your project here'),
                          onChanged: (value) => {title = value},
                        ),

                        // project image
                        Container(
                          margin: EdgeInsets.symmetric(vertical: globalMargin),
                          child: Center(
                            child: image == null
                                ? Text('No Image Selected')
                                : Image.file(image),
                          ),
                        ),

                        // textfield for description
                        TextField(
                          minLines: 1,
                          maxLines: 5,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText:
                                  'Please put the description of your project here'),
                          onChanged: (value) => {description = value},
                        ),
                      ],
                    ),
                  ),
                  Divider(color: boxColor, height: 10, thickness: 2),

                  // checkbox area
                  Text('Are you willing to lead this challenge?',
                      style: TextStyle(color: Colors.black, fontSize: 24)),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 8,
                      ),
                      Checkbox(
                          value: leadingOptions[0],
                          onChanged: (bool value) => {
                                setState(() => {
                                      leadingOptions =
                                          changeLeading(leadingOptions, 0)
                                    })
                              }),
                      Container(
                          margin:
                              EdgeInsets.symmetric(vertical: globalMargin / 2),
                          width: MediaQuery.of(context).size.width * 2 / 3,
                          child: Text(
                            'Yes, I am willing to lead this challenge.',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ))
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 8,
                      ),
                      Checkbox(
                          value: leadingOptions[1],
                          onChanged: (bool value) => {
                                setState(() => {
                                      leadingOptions =
                                          changeLeading(leadingOptions, 1)
                                    })
                              }),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: globalMargin / 2),
                        width: MediaQuery.of(context).size.width * 2 / 3,
                        child: Text(
                          'No, I will let someone else lead the project. Just letting you know about it! :)',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      )
                    ],
                  ),

                  // Button for moving to the next page
                  Container(
                      margin: EdgeInsets.symmetric(vertical: globalMargin),
                      child: RaisedButton(
                          color: boxColor,
                          splashColor: Colors.blueAccent,
                          padding: EdgeInsets.all(20),
                          onPressed: () {
                            Project project = new Project();
                            project.setTitle(title);
                            project.setDescription(description);
                            if (leadingOptions[0]) {
                              project.setCreator(user);
                            }

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        GettingStarted(project)));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Next",
                                style:
                                    TextStyle(color: arrowColor, fontSize: 20),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: arrowColor,
                                size: 20,
                              )
                            ],
                          )))
                ],
              )
            ],
          ),
        ));
  }
}

// function to change whether or not the user is leading the project or not
List<bool> changeLeading(List<bool> leadingOptions, int changeIndex) {
  // check which one is currently checked, and unchecks the other option when trying to check an option
  switch (changeIndex) {
    case 0:
      if (leadingOptions[0]) {
        leadingOptions[0] = false;
      } else {
        leadingOptions[0] = true;
        if (leadingOptions[1]) {
          leadingOptions[1] = false;
        }
      }
      break;

    case 1:
      if (leadingOptions[1]) {
        leadingOptions[1] = false;
      } else {
        leadingOptions[1] = true;
        if (leadingOptions[0]) {
          leadingOptions[0] = false;
        }
      }
      break;
  }

  return leadingOptions;
}

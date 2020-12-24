import 'dart:io' as Io;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pictureit/Data/comment.dart';
import 'package:pictureit/Data/design.dart';
import 'package:pictureit/Data/project.dart';
import 'package:pictureit/Data/user.dart';
import 'package:pictureit/Tools/designing.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/services.dart';
import 'package:bitmap/bitmap.dart';

import 'dart:async';

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
  final authInstance = auth.FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  auth.User loggedInUser;
  Project project;
  List<Design> designs;

  // completer for stacktraces
  Completer<String> myCompleter = new Completer();

  CreateDesignState(Project project) {
    this.project = project;
    designs = project.getDesigns();
  }

  // Create a text controller and use it to retrieve the current value of the TextField.
  final myController = TextEditingController();

  // image picker variables
  Io.File image;
  double imageWidth;
  double imageHeight;
  final picker = ImagePicker();
  bool finishedPicking = true;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = Io.File(pickedFile.path);
        print("image is: " + image.toString());
        imageWidth = Image.file(image).width;

        imageHeight = Image.file(image).height;
      }
    });

    finishedPicking = true;
  }

  void getCurrentUser() async {
    try {
      final firebaseUser = await authInstance.currentUser;
      if (firebaseUser != null) {
        loggedInUser = firebaseUser;
        print("in createDesign and the logged in user's email is: " +
            loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
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
                    if (finishedPicking) {
                      finishedPicking = false;
                      getImage();
                    }
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
                      onPressed: () async {
                        // variables for keeping the chosen image's width and height
                        print("image is: " + image.toString());
                        print("Image.file(image) is: " +
                            Image.file(image).toString());
                        var decodedImage =
                            await decodeImageFromList(image.readAsBytesSync());

                        int imageWidth = decodedImage.width;
                        int imageHeight = decodedImage.height;
                        User testUser = new User(
                            'name',
                            'password123',
                            "assets/images/Screenshot (437).png",
                            'contactMe@gmail.com');
                        List<Comment> comments = [];
                        Design design = new Design(
                            myController.text, image.path, testUser, comments);
                        // update designs with new design
                        try {
                          designs.add(design);
                          project.setDesigns(designs);

                          /* Notice
                          This code hopefully uploads a bitmap to the cloud firestore
                        */
                          Future imageBitmap = await createImageBitmap(
                              imageWidth, imageHeight, image);

                          getCurrentUser();
                          // creating a new design in the Cloud Firestore to link to the project
                          Future designReference =
                              firestore.collection('Designs').add({
                            'title': myController.text,
                            'image': imageBitmap,
                            'user': loggedInUser,
                            'comments': comments
                          });

                          // get the designs already in the project, and add to the list
                          List<Future> designReferences = new List<Future>();

                          // get the list of current designs if they exist
                          firestore
                              .collection('Projects')
                              .doc(project.getFirebaseDocumentId())
                              .get()
                              .then((value) {
                            if (value.get('designs')) {
                              designReferences = value.get('designs');
                            }
                          });
                          // add the new deisng reference to the list of other design references
                          designReferences.add(designReference);
                          firestore
                              .collection('Projects')
                              .doc(project.getFirebaseDocumentId())
                              .set({
                            'designs': designReferences,
                          }, SetOptions(merge: true));
                        } catch (e, stacktrace) {
                          print("in catch");
                          myCompleter.completeError(e, stacktrace);
                        }

                        // await Navigator.push(
                        //     context,
                        //     // where the button will be leading to the next page
                        //     MaterialPageRoute(
                        //         builder: (context) => Designing(project)));
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

  Future createImageBitmap(
      int imageWidth, int imageHeight, Io.File image) async {
    String imageReference = image.path;
    print("the imageReference variable is equal to: " + imageReference);

    print("Image width is: " +
        imageWidth.toString() +
        " and Image height is: " +
        imageHeight.toString());

    // convert the design image to a Uint8list to convert into a bitmap to add into cloud firestore
    List<int> values = await Io.File(imageReference).readAsBytes();

    print("made it past byte conversion");

    print("image width is: " +
        Image.file(Io.File(imageReference)).width.toString());

    print("made it past Image.File(Io.File(imageReference)).width.toString()");

    //
    Bitmap bitmap = Bitmap.fromHeadful(imageWidth, imageHeight, values);

    print("Created bitmap, bitmap is: " + bitmap.content.toString());

    // currently crashing with the error
    // E/flutter (12706): [ERROR:flutter/lib/ui/ui_dart_state.cc(177)] Unhandled Exception: Invalid argument: Instance of 'Bitmap'
    // issue with bitmap creation that makes it invalid
    // the type Bitmap might be an invalid argument to pass in
    Future imageBitmap = firestore.collection("Images").add({
      'bitmap': bitmap,
    });
    return imageBitmap;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pictureit/Data/project.dart';
import 'package:pictureit/SignUp/LogIn/logIn.dart';
import 'package:pictureit/Tools/gettingStarted.dart';
import 'package:pictureit/Data/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

// color setups
const backgroundColor = Color(0xFFE7FBF4);
const headingColor = Colors.white;
const boxColor = Color(0xFF94DFD2);
const arrowColor = Color(0xFFFFF7BF);

// padding, margin, and border radius setup
const globalPadding = 15.0;
const globalMargin = 15.0;
const borderRadius = 10.0;

class SignUp extends StatefulWidget {
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  User user;
  final auth = FirebaseAuth.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showSpinner = false;

  SignUpState() {
    this.user = new User.empty();
  }

  Widget build(BuildContext context) {
    return OverlaySupport(
        child: MaterialApp(
            home: Scaffold(
                // appbar is the header
                appBar: AppBar(
                  title: Text('PictureIt'),
                  backgroundColor: headingColor,
                ),
                // container for body of page
                body: ModalProgressHUD(
                  inAsyncCall: showSpinner,
                  child: Container(
                      padding: EdgeInsets.all(globalPadding),
                      color: backgroundColor,
                      width: MediaQuery.of(context).size.width,
                      // listview so it can scroll
                      child: ListView(children: <Widget>[
                        // column of content
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            // title for the section
                            Text('Sign Up',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 35)),
                            // first round of text (prompt and text box)
                            Container(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // text box for user input
                                Container(
                                  color: boxColor,
                                  margin: EdgeInsets.symmetric(
                                      vertical: globalPadding,
                                      horizontal: globalPadding * 3),
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    controller: nameController,
                                    minLines: 1,
                                    maxLines: 1,
                                    autocorrect: true,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Name:'),
                                  ),
                                ),
                              ],
                            )),

                            // section for second prompt
                            Container(
                              child: Column(
                                children: <Widget>[
                                  // text field for user input
                                  Container(
                                    color: boxColor,
                                    margin: EdgeInsets.symmetric(
                                        vertical: globalPadding,
                                        horizontal: globalPadding * 3),
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.emailAddress,
                                      controller: emailController,
                                      minLines: 1,
                                      maxLines: 1,
                                      autocorrect: true,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Email:'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // second text box
                            // text box for user input

                            Container(
                              child: Column(
                                children: <Widget>[
                                  // text field for user input
                                  Container(
                                    color: boxColor,
                                    margin: EdgeInsets.symmetric(
                                        vertical: globalPadding,
                                        horizontal: globalPadding * 3),
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      obscureText: true,
                                      controller: passwordController,
                                      minLines: 1,
                                      maxLines: 1,
                                      autocorrect: true,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Password:'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // third text box
                            // text box for user input

                            // Button for moving to the next page
                            Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: globalMargin),
                                child: RaisedButton(
                                    color: boxColor,
                                    splashColor: Colors.blueAccent,
                                    padding: EdgeInsets.all(20),
                                    onPressed: () async {
                                      print("Sign up name is: " +
                                          nameController.text);
                                      print("Sign up email is: " +
                                          emailController.text);
                                      print("Sign up password is: " +
                                          passwordController.text);
                                      // set user data to match what is put in
                                      user.setuserName(nameController.text);
                                      user.setContact(emailController.text);
                                      user.setPassword(passwordController.text);

                                      // setstate for setting the state of the spinning progress wheel
                                      setState(() {
                                        showSpinner = true;
                                      });

                                      // implemented registration functionality
                                      try {
                                        final newUser = await auth
                                            .createUserWithEmailAndPassword(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text);
                                        if (newUser != null) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    GettingStarted(Project()),
                                              ));
                                        }
                                        setState(() {
                                          showSpinner = false;
                                        });
                                      } catch (e) {
                                        print(e);
                                        setState(() {
                                          showSpinner = false;
                                          print("stopped spinner: " +
                                              showSpinner.toString());
                                        });
                                        showSimpleNotification(
                                            Text(e.toString()),
                                            background: Colors.purple);
                                        print(
                                            "made it to the end of the catch");
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "Join the family!",
                                          style: TextStyle(
                                              color: arrowColor, fontSize: 20),
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
                      ])),
                ))));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pictureit/Data/project.dart';
import 'package:pictureit/MiscPages/projectHome.dart';
import 'package:pictureit/Tools/gettingStarted.dart';
import 'package:pictureit/Data/user.dart';
import 'package:firebase_auth/firebase_auth.dart';


// color setups
const backgroundColor = Color(0xFFE7FBF4);
const headingColor = Colors.white;
const boxColor = Color(0xFF94DFD2);
const arrowColor = Color(0xFFFFF7BF);

// padding, margin, and border radius setup
const globalPadding = 15.0;
const globalMargin = 15.0;
const borderRadius = 10.0;


class LogIn extends StatefulWidget {
  @override
  
  User user;

  
  LogInState createState() => LogInState();
 
}

class LogInState extends State<LogIn> {

    User user;
    final auth = FirebaseAuth.instance;
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

/*
    LogInState(User user) {
      this.user = user;
       emailController.text = user.getContact();
       passwordController.text = user.getPassword();
      
    }
    */
    Widget build(BuildContext context) {
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
            // listview so it can scroll
            child: ListView(
              children: <Widget>[
              // column of content
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // title for the section
                  Text('Sign Up',
                      style: TextStyle(color: Colors.black, fontSize: 35)),
                  // first round of text (prompt and text box)
                  Container(
                      
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        
                         

                  // section for second prompt
                  Container(
                    child: Column(
                      children: <Widget>[
                   
                        // text field for user input
                        Container(
                          color: boxColor,
                          margin: EdgeInsets.symmetric(vertical: globalPadding, horizontal: globalPadding * 3),
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            minLines: 1,
                            maxLines: 1,
                            autocorrect: true,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText:
                                    'Email:'),
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
                          margin: EdgeInsets.symmetric(vertical: globalPadding, horizontal: globalPadding * 3),
                          child: TextField(
                            obscureText: true,
                            controller: passwordController,
                            minLines: 1,
                            maxLines: 1,
                            autocorrect: true,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText:
                                    'Password:'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // third text box
                  // text box for user input

                  
                  // Button for moving to the next page
                  Container(
                      margin: EdgeInsets.symmetric(vertical: globalMargin),
                      child: RaisedButton(
                          color: boxColor,
                          splashColor: Colors.blueAccent,
                          padding: EdgeInsets.all(20),
                          onPressed: () async {
                            // implemented login functionality

                            
                  
                            user.setContact(emailController.text);
                            user.setPassword(passwordController.text);
                            try {
                                  final userLogIn = await auth.signInWithEmailAndPassword(email: user.getContact(), password: user.getPassword());
                              if (user != null) {
                                 Navigator.push(context,MaterialPageRoute(builder: (context) => ProjectHome(Project())));
                                 // other code from course used .pushNamed
                              }

                              // fix: if try to sign up with an existing account email, it won't let you continue to sign up with a new email after.
                              // The correct email is stored in Firebase, but does not move on to the Getting Started Page

                            }
                            catch(e) {
                              print(e);

                            }
                           
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Join the family!",
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
            )])])));
  }
}

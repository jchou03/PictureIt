//import 'dart:html';

import 'package:camera/camera.dart';
//import 'package:camera/new/camera.dart';
import 'package:flutter/material.dart';
import 'package:pictureit/Data/comment.dart';
import 'package:pictureit/Data/design.dart';
import 'package:pictureit/Data/idea.dart';
import 'package:pictureit/Data/project.dart';
import 'package:pictureit/Data/user.dart';
import 'package:pictureit/MiscPages/createProject.dart';
import 'package:pictureit/MiscPages/myProjects.dart';
import 'package:pictureit/MiscPages/pictureTest.dart';
import 'package:pictureit/MiscPages/projectHome.dart';
import 'package:pictureit/Tools/gettingStarted.dart';
import 'package:pictureit/tools/designing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Comments/HomePage.dart';
import 'SignUp/LogIn/logIn.dart';
import 'SignUp/LogIn/signUp.dart';
import 'Comments/Test.dart';

// variable setup for the app
// color setups
const backgroundColor = Color(0xFFE7FBF4);
const headingColor = Colors.white;
const boxColor = Color(0xFF94DFD2);
const arrowColor = Color(0xFFFFF7BF);
// padding, margin, and border radius setup
const globalPadding = 15.0;
const globalMargin = 15.0;
const borderRadius = 10.0;

// variables for icon changing
IconData importantIcon = Icons.favorite_border;
Color importantColor = Colors.blueAccent;

Future<void> main() async {
// Ensure that plugin services are initialized so that `availableCameras()`
// can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

// Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

// Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(MyApp(firstCamera));
}

class MyApp extends StatelessWidget {
  CameraDescription camera;
  MyApp(CameraDescription firstCamera) {
    this.camera = camera;
  }

  // test of the designing & feedback page
  List<Design> designs = [];

  // test input project
  Project testProject = new Project.specific(
      'test test',
      'empathy 1 test',
      'empathy 2 test',
      'defining 1 test',
      'defining 2 test',
      'brainstorming test',
      null,
      null,
      null,
      null,
      null,
      DateTime(2019, 6, 29),
      2,
      null,
      'Samtrans Busses',
      'SamTrans bus 260 has had very few passangers for the last 2 months, yet the bus is still running');
  // test user
  User testUser = createUser(true);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(testProject.getStage());
    return MaterialApp(
        title: 'PictureIt',
        //routes: {'/': (context) => MyApp()},
        theme: ThemeData(
          primaryColor: headingColor,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //home: ProjectHome(testProject));

        //home: HomePage());
        //home: SignUp(testUser));
        home: PictureTest(camera: camera));
  }
}

// function for creating a user with full details to test project
User createUser(bool withProjects) {
  if (withProjects) {
    User user = new User('Dave', 'password123',
        'assets/images/Screenshot (437).png', 'davedave@gmail.com');

    // list to store projects that the user is involved in
    List<Project> projects = [];
    // list to store projects the user is following
    List<Project> followedProjects = [];

    // list to store ideas that were brainstormed
    List<Idea> ideas = ideasList(
        'new route \nswitch large bus with smaller bus so new route \nsell bananas for money \nchange funding from unhelpful program to add new bus routes');

    List<Idea> top3 = [];
    top3.add(ideas[0]);
    top3.add(ideas[1]);
    top3.add(ideas[3]);

    List<Idea> top = [];
    top.add(top3[0]);

    // list to store designs
    List<Design> designs = [];
    Design design1 =
        new Design('new bus route', 'assets/images/route82.jpg', user, []);
    designs.add(design1);

    // 1st project user is involved in
    Project project1 = new Project.specific(
        'I first learned about this problem as I noticed that the busses were empty every day',
        'I know that schoolchildren are affected becasue it pulls resources away from the routes that they need more busses for',
        'I interviewed 3 people, one student, one buisness worker, and a banana. After talking through all of them, they feel like they bus routes are poorly designed',
        'This problem affects most residents living in the suburbs outside of EPA because they have less access to useful bus routes.',
        'This problem is happening because there were government officials who coerced into designing this route to prevent less low income people from having easy access to the city center',
        'new route \nswitch large bus with smaller bus so new route \nsell bananas for money \nchange funding from unhelpful program to add new bus routes',
        ideas,
        top3,
        top,
        designs,
        null,
        DateTime(2019, 6, 29),
        4,
        user,
        'SamTrans Busses',
        'SamTrans bus 260 has had very few passangers for the last 2 months, yet the bus is still running');

    // 2nd project user is involved in
    Project project2 = new Project.specific(
        'I\'ve been having issues with the ice cream in the city, where any ice cream that I get ',
        'I have been an ice cream connoisseur for years now, and I\'ve noticed that recently, all the ice cream in EPA is soft and melts super quickly.',
        'banana',
        'The people affected by this problem are children who need ice cream to develop their brains.',
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        DateTime(2019, 6, 29),
        1,
        user,
        'Hot Ice Cream',
        'There\'s an issue with hot ice cream all around the city where all the ice cream is hot and melts within 2 seconds');

    // add the project following
    projects.add(project1);
    projects.add(project2);
    followedProjects.add(project2);
    followedProjects.add(project1);

    user.setProjects(projects);
    user.setFollowedProjects(followedProjects);

    return user;
  }
}

// returns a list of strings where each idea is seperated by a new line (this even works for longer inputs where the text wraps, but there isn't a direct new line input)
List<Idea> ideasList(String textInput) {
  var ideaArray = textInput.split('\n');
  print(ideaArray);
  List<Idea> ideaObjects = [];
  for (int i = 0; i < ideaArray.length; i++) {
    ideaObjects.add(new Idea(ideaArray[i].toString()));
  }
  return ideaObjects;
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _likeCounter = 0;

  void _incrementLikeCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _likeCounter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called
    return Scaffold();
  }
}

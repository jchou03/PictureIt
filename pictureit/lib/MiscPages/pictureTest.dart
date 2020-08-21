import 'package:camera/camera.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show join;

const backgroundColor = Color(0xFFE7FBF4);
const headingColor = Colors.white;
const boxColor = Color(0xFF94DFD2);
const arrowColor = Color(0xFFFFF7BF);

// padding, margin, and border radius setup
const globalPadding = 15.0;
const globalMargin = 15.0;
const borderRadius = 10.0;

class PictureTest extends StatefulWidget {
  final CameraDescription camera;

  const PictureTest({
    Key key,
    @required this.camera,
  }) : super(key: key);

  PictureTestState createState() => PictureTestState();
}

class PictureTestState extends State<PictureTest> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      // get the specific camera from the list of cameras
      widget.camera,
      // definition of resolution to use
      ResolutionPreset.medium,
    );

    // initializes the controller
    _initializeControllerFuture = _controller.initialize();
    print('initializedControllerFuture state in initState(): ' +
        _initializeControllerFuture.toString());
  }

  @override
  void dispose() {
    //dispose of controller widget when done
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('pictureTest')),
      body: ListView(
        children: <Widget>[
          Text('test'),
          FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                print('in futureBuilder');
                if (snapshot.connectionState == ConnectionState.done) {
                  print('the connectionState is done');
                  return CameraPreview(_controller);
                } else {
                  print('the connectionState is not done');
                  return Center(child: CircularProgressIndicator());
                }
              }),
          FloatingActionButton(
            child: Icon(Icons.camera_alt),
            onPressed: () async {
              print('pressed camera button');
              try {
                print('entered try');
                print(_initializeControllerFuture);
                // something in _initializeControllerFuture is causing camera app to crash
                await _initializeControllerFuture;

                print('made it past initialization');
                final path = join((await getTemporaryDirectory()).path,
                    '${DateTime.now()}.png');
                print('controller is: ' + _controller.toString());
                // the controller isn't initialized when taking photos
                await _controller.takePicture(path);
              } catch (e) {
                print(e);
              }
            },
          )
        ],
      ),
    );
  }
}

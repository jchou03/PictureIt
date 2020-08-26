import 'package:camera/camera.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show join;
import 'package:pictureit/Data/user.dart';
import 'package:pictureit/MiscPages/createProject.dart';
import 'package:path/path.dart';

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
  final User user;

  const PictureTest({Key key, @required this.camera, @required this.user})
      : super(key: key);

  PictureTestState createState() => PictureTestState(user);
}

class PictureTestState extends State<PictureTest> {
  CameraController _controller;
  List cameras;
  int cameraIndex;
  String imgPath;
  Future<void> _initializeControllerFuture;
  User user;

  PictureTestState(User user) {
    this.user = user;
  }

  @override
  void initState() {
    super.initState();
    availableCameras().then((avalibleCameras) {
      cameras = avalibleCameras;

      // check if there are avalible cameras
      if (cameras.length > 0) {
        setState(() {
          // set chosen camera to first one
          cameraIndex = 0;
        });

        // initialize the new camera
        _initCameraController(cameras[cameraIndex]).then((void v) {});
      } else {
        print('no cameras');
      }
    }).catchError((err) {
      print('Error: $err.code\nError Message: $err.message');
    });
  }

  // function to initialize the camera controller
  Future _initCameraController(CameraDescription cameraDescription) async {
    // get rid of the old controller if it exists
    if (_controller != null) {
      await _controller.dispose();
    }

    _controller = CameraController(cameraDescription, ResolutionPreset.low);

    // update UI once controller is updated
    _controller.addListener(() {
      if (mounted) {
        setState(() {});
      }

      // print out if the controller has an error
      if (_controller.value.hasError) {
        print('Camera error ${_controller.value.errorDescription}');
      }
    });

    try {
      await _controller.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }
  }

  // function to display a camera exception
  void _showCameraException(CameraException e) {
    String errorText = 'Error: ${e.code}\nError Message: ${e.description}';
    print(errorText);

    print('Error: ${e.code}\n${e.description}');
  }

  Widget _cameraPreviewWidget() {
    if (_controller == null || !_controller.value.isInitialized) {
      return const Text(
        'Loading',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
        ),
      );
    }

    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: CameraPreview(_controller),
    );
  }

  Widget _cameraTogglesRowWidget() {
    if (cameras == null || cameras.isEmpty) {
      return Spacer();
    }

    CameraDescription selectedCamera = cameras[cameraIndex];
    CameraLensDirection lensDirection = selectedCamera.lensDirection;

    return Expanded(
        child: Align(
      alignment: Alignment.centerLeft,
      child: FlatButton.icon(
          onPressed: () {
            _onSwitchCamera();
          },
          icon: Icon(_getCameraLensIcon(lensDirection)),
          label: Text(
              '${lensDirection.toString().substring(lensDirection.toString().indexOf('.') + 1)}')),
    ));
  }

  // function to return the corresponding icon
  IconData _getCameraLensIcon(CameraLensDirection lensDirection) {
    switch (lensDirection) {
      case CameraLensDirection.back:
        return Icons.camera_rear;
        break;
      case CameraLensDirection.front:
        return Icons.camera_front;
        break;
      case CameraLensDirection.external:
        return Icons.camera;
        break;
      default:
        return Icons.device_unknown;
    }
  }

  // switch the camera from front to back
  void _onSwitchCamera() {
    cameraIndex = cameraIndex < cameras.length - 1 ? cameraIndex + 1 : 0;
    CameraDescription selectedCamera = cameras[cameraIndex];
    _initCameraController(selectedCamera);
  }

  // function for showing the button
  Widget _captureControlRowWidget(context) {
    return Expanded(
      child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              FloatingActionButton(
                child: Icon(Icons.camera),
                backgroundColor: Colors.blueGrey,
                onPressed: () {
                  _onCapturePressed(context);
                },
              )
            ],
          )),
    );
  }

  // function for taking the picture
  void _onCapturePressed(context) async {
    try {
      // Attempt to take a picture and log where it's been saved
      final path = join(
        // In this example, store the picture in the temp directory. Find
        // the temp directory using the `path_provider` plugin.
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );
      print(path);
      await _controller.takePicture(path);
      print('took picture');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CreateProject.withImage(user, path)));
    } catch (e) {
      print(e);
    }
    print('made it to the end of _onCapturePressed()');
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('PictureIt'),
        ),
        body: Container(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: _cameraPreviewWidget(),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _cameraTogglesRowWidget(),
                    _captureControlRowWidget(context),
                    Spacer()
                  ],
                ),
                SizedBox(height: 20.0)
              ],
            ),
          ),
        ));
  }
}

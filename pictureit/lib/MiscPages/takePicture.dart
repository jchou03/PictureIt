import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class TakePicture extends StatefulWidget {
  final CameraDescription camera;
  TakePicture({@required this.camera});

  @override
  TakePictureState createState() => TakePictureState();
}

class TakePictureState extends State<TakePicture> {
  CameraController _cameraController;
  Future<void> _initializeCameraControllerFuture;

  @override
  void initState() {
    _cameraController =
        CameraController(widget.camera, ResolutionPreset.medium);

    _initializeCameraControllerFuture = _cameraController.initialize();
  }

  void _takePicture(BuildContext context) async {
    try {
      await _initializeCameraControllerFuture;

      final path =
          join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');

      await _cameraController.takePicture(path);

      Navigator.pop(context, path);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('PictureIt'),
        ),
        body: FutureBuilder(
          future: _initializeCameraControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_cameraController);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}

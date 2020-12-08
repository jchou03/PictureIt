import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class Uploader extends StatefulWidget {
  final File file;

  Uploader({Key key, this.file}) : super(key: key);

  createState() => UploaderState();
}

class UploaderState extends State<Uploader> {
  final FirebaseStorage storage =
      FirebaseStorage(storageBucket: "gs://envisionit-74a6d.appspot.com");

  StorageUploadTask uploadTask;

  void startUpload() {
    String filePath = 'images/${DateTime.now()}.png';

    setState(() {
      uploadTask = storage.ref().child(filePath).putFile(widget.file);
    });
  }

  @override
  Widget build(BuildContext context) {}
}

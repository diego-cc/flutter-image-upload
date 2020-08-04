import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// Add text, styles and buttons to app's top bar
class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('My demo app'),
      backgroundColor: Colors.redAccent,
    );
  }
}

/// Parent class that includes all widgets of the app
class App extends StatelessWidget {
  final String title = "My demo app";
  static const primaryColour = Colors.red;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: title,
        theme: ThemeData(primaryColor: primaryColour),
        home: Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: Column(
              children: <Widget>[ImagePresenter()],
            )));
  }
}

/// Use this class to set constant properties to be used as fallback to _ImagePresenterState
class ImagePresenter extends StatefulWidget {
  const ImagePresenter({Key key}) : super(key: key);

  /// initial image to be loaded
  static const String defaultImageUrl =
      "https://cdn.pixabay.com/photo/2015/09/02/13/24/girl-919048_1280.jpg";

  @override
  _ImagePresenterState createState() => _ImagePresenterState();
}

/// Handles image uploads and renders the result
class _ImagePresenterState extends State<ImagePresenter> {
  String _imageUrl = ImagePresenter.defaultImageUrl;
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    /// Try changing the source property to ImageSource.camera
    final pickedImg = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      /// This null check avoids crashes if the user taps the "back" button when they are choosing an image
      if (pickedImg != null) {
        _image = File(pickedImg.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 20.0,
        ),
        RaisedButton(
            onPressed: getImage,
            textColor: Colors.white,
            color: Colors.green,
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
            child: Container(
                child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.cloud_upload,
                  size: 32.0,
                ),
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  "Upload a picture",
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.2,
                ),
              ],
            ))),
        SizedBox(
          height: 50.0,
        ),
        _image == null ? Image.network(_imageUrl) : Image.file(_image)
      ],
    );
  }
}

/// Entry point of the app
void main(List<String> args) {
  runApp(App());
}

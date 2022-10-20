// All about uploading an image and call our AI APIs from Render services

// Import goes here!!!
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:tflite/tflite.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
// import 'package:pytorch_mobile/pytorch_mobile.dart';

String txt = "";
String txt1 = "Upload or take an image of Thai Food";

class Dupload extends StatefulWidget {
  @override
  _DuploadState createState() => _DuploadState();
}

class _DuploadState extends State<Dupload> {
  Map<String, dynamic>? _outputs;
  XFile? _image;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;

    // loadModel().then((value) {
    //   setState(() {
    //     _loading = false;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text(
            "Upload Dish Image",
            style: TextStyle(
              fontSize: 19,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 29, 123, 224),
      ),
      body: new Container(
        child: Center(
          child: Column(
            children: <Widget>[
              _image == null
                  ? new Text(
                      txt1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32.0,
                      ),
                    )
                  : new Image.file(File(_image!.path),
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: MediaQuery.of(context).size.width * 0.8),
              new Text(
                txt,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: new Stack(
        children: <Widget>[
          Align(
              alignment: Alignment(1.0, 1.0),
              child: new FloatingActionButton(
                heroTag: 'camera',
                onPressed: () {
                  image_picker(0);
                },
                child: new Icon(Icons.camera_alt),
              )),
          Align(
              alignment: Alignment(1.0, 0.8),
              child: new FloatingActionButton(
                  heroTag: 'upload',
                  onPressed: () {
                    image_picker(1);
                  },
                  child: new Icon(Icons.file_upload))),
        ],
      ),
    );
  }

  // The function which will upload the image as a file
  void upload(File imageFile) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    String base = "https://render-for-fastai.onrender.com";

    var uri = Uri.parse(base + '/analyze');

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));

    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      const start = '{"results":"';
      const end = '"}';
      final startIndex = value.indexOf(start);
      final endIndex = value.indexOf(end, startIndex + start.length);
      // int l = value.length;
      txt = value.substring(startIndex + start.length, endIndex);
      setState(() {});
    });
  }

  void image_picker(int a) async {
    txt1 = "";
    final ImagePicker _picker = ImagePicker();
    setState(() {});
    debugPrint("Image Picker Activated");
    if (a == 0) {
      _image = (await _picker.pickImage(source: ImageSource.camera))!;
    } else {
      _image = (await _picker.pickImage(source: ImageSource.gallery))!;
    }

    txt = "Analysing...";
    debugPrint(_image.toString());
    upload(File(_image!.path));
    setState(() {});
  }
}

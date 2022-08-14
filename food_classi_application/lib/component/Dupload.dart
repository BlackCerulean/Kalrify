import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_classi_application/homescreen.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:tflite/tflite.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

import 'package:path/path.dart';
import 'package:async/async.dart';

String txt = "";
String txt1 = "Upload or take an image of Thai Food";

class Dupload extends StatefulWidget {
  @override
  _DuploadState createState() => _DuploadState();
}

class _DuploadState extends State<Dupload> {
  Map<String, dynamic> _outputs;
  XFile _image;
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
                  : new Image.file(File(_image.path),
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
      // body: _loading
      //     ? Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           // Container(
      //           //   alignment: Alignment.center,
      //           //   child: CircularProgressIndicator(
      //           //     backgroundColor: Colors.red,
      //           //   ),
      //           // ),
      //
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Container(
      //                 width: MediaQuery.of(context).size.width * 0.5,
      //                 height: MediaQuery.of(context).size.height * 0.2,
      //                 child: FloatingActionButton(
      //                   onPressed: pickImage,
      //                   backgroundColor: Color(0xFF8cb369),
      //                   child: Icon(
      //                     Icons.fastfood_rounded,
      //                     size: MediaQuery.of(context).size.width * 0.25,
      //                   ),
      //                 ),
      //
      //
      //               ),
      //             ],
      //           ),
      //         ],
      //
      //       )
      //     : Container(
      //         width: MediaQuery.of(context).size.width,
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Container(
      //               height: 300.0,
      //               width: 300.0,
      //               decoration: new BoxDecoration(
      //                 shape: BoxShape.circle,
      //               ),
      //               child: ClipRRect(
      //                 borderRadius: BorderRadius.circular(75.0),
      //                 child: (_image != null)
      //                     ? new Image.file(
      //                         _image,
      //                         fit: BoxFit.cover,
      //                       )
      //                     : Container(),
      //               ),
      //             ),
      //             SizedBox(
      //               height: 20,
      //             ),
      //             _outputs != null
      //                 ? Column(
      //                     children: [
      //                       Text("${_outputs["objects"][0]["result"]}",
      //                           style: TextStyle(
      //                             color: Colors.black,
      //                             fontSize: 30,
      //                           )),
      //                       Text(
      //                         "Confidence = ${_outputs["objects"][0]["score"]}",
      //                         style: TextStyle(
      //                           fontSize: 20,
      //                           color: Colors.red,
      //                         ),
      //                       )
      //                     ],
      //                   )
      //                 : Container(),
      //           ],
      //         ),
      //       ),
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
    //contentType: new MediaType('image', 'png'));

    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      const start = '{"results":"';
      const end = '"}';
      final startIndex = value.indexOf(start);
      final endIndex = value.indexOf(end, startIndex + start.length);
      int l = value.length;
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
      _image = await _picker.pickImage(source: ImageSource.camera);
    } else {
      _image = await _picker.pickImage(source: ImageSource.gallery);
    }

    txt = "Analysing...";
    debugPrint(_image.toString());
    upload(File(_image.path));
    setState(() {});
  }

  // Call api to use ML model from AI For Thai
  // pickImage() async {
  //   // ignore: deprecated_member_use
  //   var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   if (image == null) return null;
  //   setState(() {
  //     _loading = true;
  //     _image = image;
  //   });
  //   // File imagefile = File(image);
  //   Uint8List imageBytes = image.readAsBytesSync();
  //   // print(imageBytes);
  //   String base64String = base64.encode(imageBytes);
  //
  //   var body = json.encode({"file": base64String});
  //
  //   var response = await http.post(
  //     'https://api.aiforthai.in.th/thaifood',
  //     headers: {
  //       'Content-Type': 'application/json',
  //       "Apikey": "zKeCFpHoMX02P8HyaTjbXxsM61TS4woM"
  //     },
  //     body: body,
  //   );
  //   print(response.body);
  //   setState(() {
  //     _loading = false;
  //     _outputs = json.decode(response.body);
  //     print(_outputs);
  //     print(response.statusCode);
  //   });
  //   // classifyImage(image);
  // }

//   classifyImage(File image) async {
//     var output = await Tflite.runModelOnImage(
//       path: image.path,
//       numResults: 6,
//       threshold: 0.40,
//       imageMean: 127.5,
//       imageStd: 127.5,
//     );
//     setState(() {
//       _loading = false;
//       _outputs = output;
//       double dogruluk = _outputs[0]["confidence"];
//       print("${_outputs[0]["confidence"]}");
//     });
//   }

//   loadModel() async {
//     await Tflite.loadModel(
//       model: "assets/model_unquant.tflite",
//       labels: "assets/labels.txt",
//     );
//   }

//   @override
//   void dispose() {
//     Tflite.close();
//     super.dispose();
//   }
}

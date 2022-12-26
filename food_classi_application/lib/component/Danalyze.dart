// All about handling an image and call our AI APIs from Render services

// Import goes here
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_classi_application/decoration/circular_fab_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:async';

import '../homescreen.dart';

String foodName = "";
String txt1 = "Upload or take an image of Thai Food";
List database = [];

class Danalyze extends StatefulWidget {
// Image variable
  XFile? image;
  File imgpath;
  Danalyze(
      {Key? key,
      @required this.image,
      required this.imgpath,
      required this.token})
      : super(key: key);
  final String token;
  @override
  State<Danalyze> createState() => _DanalyzeState(token: token);
}

class _DanalyzeState extends State<Danalyze> {
  _DanalyzeState({required this.token});
  final String token;
  bool isLoading = false;

  final String url = 'http://kalrify.sit.kmutt.ac.th:3000/analyze/getAnalyze';

  Future<String> getDishInfo() async {
    var res = await http.get(
      Uri.parse(url),
      headers: {"Accept": "application/json", "food": foodName.toString()},
    );

    setState(() {
      var resBody = json.decode(res.body);
      database = resBody["analyze"];
    });

    return "Success!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(
                      token: token,
                    )),
          ),
        ),
        title: Center(
          child: Text(
            "Analysis of Dish Image",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.05,
            ),
          ),
        ),
        backgroundColor: Color(0xFF8cb369),
      ),
      body: Column(
        children: [
          Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Image.file(File(widget.image!.path),
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.8),
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.05),
                    child: Container(
                      child: Text(
                        foodName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          // Button for calling APIs to use analysis function
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.08,
              child: FloatingActionButton(
                child: isLoading
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(color: Colors.white),
                          const SizedBox(width: 25),
                          Text(
                            'Identifying...',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.06,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        "Identify",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                        ),
                      ),
                backgroundColor: Color(0xFF8cb369),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.05),
                ),
                onPressed: () async {
                  if (isLoading) return;
                  foodName = '';
                  database = [];
                  upload(widget.imgpath);
                  setState(() => isLoading = true);
                },
                heroTag: 'Analyzing',
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: CircularFabWidget(
        token: token,
      ),
    );
  }

  // The function which will upload the image as a file, send it via APIs call, and receive the response
  void upload(File imageFile) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    String base = "https://kalrify-fastai-ml.onrender.com";

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
      foodName = value.substring(startIndex + start.length, endIndex);
      this.getDishInfo();
      setState(() => isLoading = false);
    });
  }

  void initState() {
    super.initState();
  }
}

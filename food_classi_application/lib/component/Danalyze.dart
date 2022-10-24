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

String foodName = "";
String txt1 = "Upload or take an image of Thai Food";
List database = [];

class Danalyze extends StatefulWidget {
// Image variable
  XFile? image;
  File imgpath;
  Danalyze({Key? key, @required this.image, required this.imgpath})
      : super(key: key);

  @override
  State<Danalyze> createState() => _DanalyzeState();
}

class _DanalyzeState extends State<Danalyze> {
  bool isLoading = false;

  final String url = 'http://kalrify.sit.kmutt.ac.th:3000/analyze/getAnalyze';
  // List database = [];

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
        title: Center(
          child: Text(
            "Analysis of Dish Image",
            style: TextStyle(
              fontSize: 25,
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
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: Text(
                        foodName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
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
            padding: const EdgeInsets.all(20.0),
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
                            'Analysing...',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        "Analyze",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                backgroundColor: Color(0xFF8cb369),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                ),
                onPressed: () async {
                  if (isLoading) return;
                  foodName = '';
                  upload(widget.imgpath);
                  setState(() => isLoading = true);
                },
                heroTag: 'Analyzing',
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: CircularFabWidget(),
    );
  }

  // The function which will upload the image as a file, send it via APIs call, and receive the response
  void upload(File imageFile) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    String base = "https://kalrify-ml-services.onrender.com";

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
      setState(() => isLoading = false);
    });
  }

  void initState() {
    super.initState();
    this.getDishInfo();
  }
}

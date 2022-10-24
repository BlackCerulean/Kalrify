import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:food_classi_application/component/Dsearch.dart';
import 'package:food_classi_application/component/Danalyze.dart';
import 'package:food_classi_application/component/Udiary.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo goes here!!

          // Text field
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Text(
                "Home",
                style: TextStyle(fontSize: 50, color: Color(0xFFB9B9B9)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 20.0),
            child: Container(
              child: Text(
                '''Welcome to Kalrify 
                Please select the Method below to find the food information, or view the personal diary''',
                style: TextStyle(fontSize: 15, color: Color(0xFF8cb369)),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // List of Features start here
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
            child: Container(
              child: Text(
                "Features",
                style: TextStyle(fontSize: 50, color: Color(0xFFB9B9B9)),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Button link to list of dishes feature
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.05,
              child: FloatingActionButton(
                child: Text(
                  "List of the Dishes",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                backgroundColor: Color(0xFF8cb369),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return Dsearch();
                  }));
                },
                heroTag: 'DSearch',
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 2,
          ),

          // Button link to analyze image using taken picture
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.05,
              child: FloatingActionButton(
                child: Text(
                  "Take an Image",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                backgroundColor: Color(0xFF8cb369),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                ),
                onPressed: () {
                  image_picker(0, context);
                },
                heroTag: 'Dpicture',
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 2,
          ),

          // Button link to analyze image with uploaded picture
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.05,
              child: FloatingActionButton(
                child: Text(
                  "Upload an Image",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                backgroundColor: Color(0xFF8cb369),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                ),
                onPressed: () {
                  image_picker(1, context);
                },
                heroTag: 'Danalyze',
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 2,
          ),

          // Diary for user to manage
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.05,
              child: FloatingActionButton(
                child: Text(
                  "User Diary",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                backgroundColor: Color(0xFF8cb369),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return Udiary();
                  }));
                },
                heroTag: 'Udiary',
              ),
            ),
          )
        ],
      ),
    );
  }

  void image_picker(int a, BuildContext context) async {
    XFile? _image;
    final ImagePicker _picker = ImagePicker();
    // setState(() {});
    debugPrint("Image Picker Activated");
    if (a == 0) {
      _image = (await _picker.pickImage(
          source: ImageSource.camera,
          maxHeight: 512,
          maxWidth: 512,
          imageQuality: 80))!;
    } else {
      _image = (await _picker.pickImage(source: ImageSource.gallery))!;
    }

    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return Danalyze(
        image: _image,
        imgpath: File(_image!.path),
      );
    }));
    // debugPrint(_image.toString());
    // upload(File(_image!.path));
    // setState(() {});
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_classi_application/component/Login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:food_classi_application/component/Dsearch.dart';
import 'package:food_classi_application/component/Danalyze.dart';
import 'package:food_classi_application/component/Udiary.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.token});
  final String token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo goes here!!

          // Text field
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
            child: Container(
              child: Text(
                "Home",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.1,
                    color: Color(0xFFB9B9B9)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.04,
                vertical: 0),
            child: Column(
              children: [
                Container(
                  child: Text(
                    '''Welcome to Kalrify''',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        color: Color(0xFF8cb369)),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  child: Text(
                    'Please select the Method below to find the food information, or view the personal diary',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        color: Color(0xFF8cb369)),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),

          // List of Features start here
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
            child: Container(
              child: Text(
                "Features",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.1,
                    color: Color(0xFFB9B9B9)),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Button link to list of dishes feature
          Padding(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.04,
                0.0,
                MediaQuery.of(context).size.width * 0.04,
                MediaQuery.of(context).size.width * 0.04),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.06,
              child: FloatingActionButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, 0, MediaQuery.of(context).size.width * 0.01, 0),
                      child: Icon(Icons.list_outlined,
                          size: MediaQuery.of(context).size.width * 0.08),
                    ),
                    Text(
                      "List of the Dishes",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                      ),
                    ),
                  ],
                ),
                backgroundColor: Color(0xFF8cb369),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.03),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return Dsearch(
                      token: token,
                    );
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
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.04,
                0.0,
                MediaQuery.of(context).size.width * 0.04,
                MediaQuery.of(context).size.width * 0.04),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.06,
              child: FloatingActionButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, 0, MediaQuery.of(context).size.width * 0.01, 0),
                      child: Icon(Icons.photo_camera,
                          size: MediaQuery.of(context).size.width * 0.08),
                    ),
                    Text(
                      "Take an Image",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                      ),
                    ),
                  ],
                ),
                backgroundColor: Color(0xFF8cb369),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.03),
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
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.04,
                0.0,
                MediaQuery.of(context).size.width * 0.04,
                MediaQuery.of(context).size.width * 0.04),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.06,
              child: FloatingActionButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, 0, MediaQuery.of(context).size.width * 0.01, 0),
                      child: Icon(Icons.file_upload_outlined,
                          size: MediaQuery.of(context).size.width * 0.08),
                    ),
                    Text(
                      "Upload an Image",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                      ),
                    ),
                  ],
                ),
                backgroundColor: Color(0xFF8cb369),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.03),
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

          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
            child: Container(
              child: Text(
                "User",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.1,
                    color: Color(0xFFB9B9B9)),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Diary for user to manage
          Padding(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.04,
                0.0,
                MediaQuery.of(context).size.width * 0.04,
                MediaQuery.of(context).size.width * 0.04),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.06,
              child: FloatingActionButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, 0, MediaQuery.of(context).size.width * 0.01, 0),
                      child: Icon(Icons.book_outlined,
                          size: MediaQuery.of(context).size.width * 0.08),
                    ),
                    Text(
                      "User Diary",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                      ),
                    ),
                  ],
                ),
                backgroundColor: Color(0xFF8cb369),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.03),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return Udiary(
                      token: token,
                    );
                  }));
                },
                heroTag: 'Udiary',
              ),
            ),
          ),

          //Logout Button
          Padding(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.04,
                0.0,
                MediaQuery.of(context).size.width * 0.04,
                MediaQuery.of(context).size.width * 0.04),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.06,
              child: FloatingActionButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, 0, MediaQuery.of(context).size.width * 0.01, 0),
                      child: Icon(Icons.logout_outlined,
                          size: MediaQuery.of(context).size.width * 0.08),
                    ),
                    Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                      ),
                    ),
                  ],
                ),
                backgroundColor: Color(0xFFE4572E),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.03),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return LoginScreen();
                  }));
                },
                heroTag: 'Logout',
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
      foodName = '';
      return Danalyze(
        image: _image,
        imgpath: File(_image!.path),
        token: token,
      );
    }));
  }
}

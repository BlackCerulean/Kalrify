import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'Danalyze.dart';

class selectImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: FloatingActionButton(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.file_upload_outlined,
                                  size: MediaQuery.of(context).size.width * 0.3,
                                ),
                                const SizedBox(width: 25),
                                Text(
                                  "Upload Image",
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                            backgroundColor: Color(0xFF8cb369),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(32.0),
                            ),
                            onPressed: () async {
                              image_picker(1, context);
                            },
                            heroTag: 'image-select',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: FloatingActionButton(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.photo_camera,
                                  size: MediaQuery.of(context).size.width * 0.3,
                                ),
                                Text(
                                  "Take Photo",
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                            backgroundColor: Color(0xFF8cb369),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(32.0),
                            ),
                            onPressed: () async {
                              image_picker(0, context);
                            },
                            heroTag: 'photo-select',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
      _image = (await _picker.pickImage(source: ImageSource.camera))!;
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

class viewMealInfo extends StatelessWidget {
  const viewMealInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
          tag: 'view-meal-info',
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.62,
            child: Material(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              child: SingleChildScrollView(
                child: Container(),
              ),
            ),
          )),
    );
  }
}

// this class will hold the form data
class FormDiary {
  String mealType = '';
}

FormDiary _formDiary = FormDiary();

class addDiary extends StatelessWidget {
  String day;
  String month;
  String year;
  String hour;
  int minute;

  addDiary({
    Key? key,
    required this.day,
    required this.month,
    required this.year,
    required this.hour,
    required this.minute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: 'add-meal-diary',
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.62,
            child: Material(
              // color: AppColors.accentColor,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.05,
                            MediaQuery.of(context).size.width * 0.05,
                            MediaQuery.of(context).size.width * 0.05,
                            0),
                        child: Text(
                          'Add to your diary',
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffE4572E)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.05),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * 0.01),
                                  child: Text(
                                    'Dish Name: ',
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFb9b9b9),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * 0.01),
                                  child: Text(
                                    txt,
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                        color: Color(0xffE4572E)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * 0.01),
                                  child: Text(
                                    'Calories: ',
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFb9b9b9),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * 0.01),
                                  child: Text(
                                    '240' + ' kcal per dish',
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                        color: Color(0xffE4572E)),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(
                                          MediaQuery.of(context).size.width *
                                              0.01),
                                      child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.07,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.07,
                                          child: Icon(
                                            Icons.calendar_today_outlined,
                                            color: Color(0xffE4572E)
                                                .withOpacity(.5),
                                          )),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(
                                          MediaQuery.of(context).size.width *
                                              0.01),
                                      child: Text(
                                        day + '-' + month + '-' + year,
                                        style: TextStyle(
                                            color: Color(0xFFb9b9b9),
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(
                                          MediaQuery.of(context).size.width *
                                              0.07),
                                      child: SizedBox(),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(
                                          MediaQuery.of(context).size.width *
                                              0.01),
                                      child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.07,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.07,
                                          child: Icon(
                                            Icons.access_time,
                                            color: Color(0xffE4572E)
                                                .withOpacity(.5),
                                          )),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(
                                          MediaQuery.of(context).size.width *
                                              0.01),
                                      child: Text(
                                        hour +
                                            ':' +
                                            ((minute <= 9)
                                                    ? ('0' + minute.toString())
                                                    : minute)
                                                .toString(),
                                        style: TextStyle(
                                            color: Color(0xFFb9b9b9),
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04),
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  'Please select your meals type',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFb9b9b9),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * 0.05),
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            child: Row(
                                              children: [
                                                Radio(
                                                    value: 'Breakfast',
                                                    groupValue: 'null',
                                                    onChanged: (value) {}),
                                                Expanded(
                                                    child: Text('Breakfast'))
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            child: Row(
                                              children: [
                                                Radio(
                                                    value: 'Lunch',
                                                    groupValue: 'null',
                                                    onChanged: (value) {}),
                                                Text('Lunch')
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            child: Row(
                                              children: [
                                                Radio(
                                                    value: 'Dinner',
                                                    groupValue: 'null',
                                                    onChanged: (value) {}),
                                                Text('Dinner')
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            0,
                            0,
                            MediaQuery.of(context).size.height * 0.03,
                            MediaQuery.of(context).size.height * 0.4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: FloatingActionButton(
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.02,
                                  ),
                                ),
                                backgroundColor: Color(0xFF8cb369),
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                ),
                                onPressed: (() {}),
                                heroTag: null,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'Danalyze.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

// List database = [];

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

class Viewmeal extends StatefulWidget {
  @override
  State<Viewmeal> createState() => _ViewmealState();
}

class _ViewmealState extends State<Viewmeal> {
  bool isExecuted = false;
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
    print(database);
    return Center(
      child: Hero(
          tag: 'view-meal-info',
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.62,
            child: Material(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(36)),
              child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: database.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Flexible(
                            child: Column(
                              children: <Widget>[
                                // Dish Name
                                Center(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Center(
                                      child: Text(
                                        database[0]["FoodNameENG"] +
                                            "(" +
                                            database[0]["FoodNameTH"] +
                                            ")",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color:
                                                Color.fromRGBO(228, 87, 46, 1)),
                                      ),
                                    ),
                                  ),
                                ),
                                //                               // // Dish Image
                                //                               // Container(
                                //                               //   width: MediaQuery.of(context).size.width *
                                //                               //       0.5,
                                //                               //   height:
                                //                               //       MediaQuery.of(context).size.width *
                                //                               //           0.3,
                                //                               //   child: Image.asset(database[index].img),
                                //                               // ),
                                //                               // Calories
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Color.fromRGBO(
                                                          255, 170, 90, 1)))),
                                          child: Column(children: [
                                            Container(
                                              child: Text(
                                                "Energy",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 5),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10,
                                                                vertical: 10),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "Calories per dish: ",
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          228,
                                                                          87,
                                                                          46,
                                                                          1)),
                                                            ),
                                                            Text(
                                                              database[0]["Calories"]
                                                                      .toString() +
                                                                  " (Kcal) ",
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          140,
                                                                          179,
                                                                          105,
                                                                          1)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10,
                                                                vertical: 10),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "Portion: ",
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          228,
                                                                          87,
                                                                          46,
                                                                          1)),
                                                            ),
                                                            Text(
                                                              database[0]["Portion"]
                                                                      .toString() +
                                                                  " (Serving) ",
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          140,
                                                                          179,
                                                                          105,
                                                                          1)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ]),
                                        ),
                                      ),
                                      // Nutrients
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Container(
                                          child: Text(
                                            "Nutritions",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 5,
                                        ),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              // Nutrition Column 1
                                              Column(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 10),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Fat: ",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      228,
                                                                      87,
                                                                      46,
                                                                      1)),
                                                        ),
                                                        Text(
                                                          database[0]["Fat"]
                                                                  .toString() +
                                                              " (g.)",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      140,
                                                                      179,
                                                                      105,
                                                                      1)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 10),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Carbohydrate: ",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      228,
                                                                      87,
                                                                      46,
                                                                      1)),
                                                        ),
                                                        Text(
                                                          database[0]["Carb"]
                                                                  .toString() +
                                                              " (g.)",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      140,
                                                                      179,
                                                                      105,
                                                                      1)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // Nutrition Column 2
                                              Column(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 10),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Fat: ",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      228,
                                                                      87,
                                                                      46,
                                                                      1)),
                                                        ),
                                                        Text(
                                                          database[0]["Sodium"]
                                                                  .toString() +
                                                              " (mg.)",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      140,
                                                                      179,
                                                                      105,
                                                                      1)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 10),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Protein: ",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      228,
                                                                      87,
                                                                      46,
                                                                      1)),
                                                        ),
                                                        Text(
                                                          database[0]["Protein"]
                                                                  .toString() +
                                                              " (g.)",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      140,
                                                                      179,
                                                                      105,
                                                                      1)),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                                )
                              ],
                            ),
                          );
                        })),
              ),
            ),
          )),
    );
  }

  void initState() {
    super.initState();
    this.getDishInfo();
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
                                    foodName,
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
                                    database[0]["Calories"].toString() +
                                        ' kcal per dish',
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

// import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'AddDiary.dart';
import 'Danalyze.dart';
import 'dart:typed_data';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Udiary.dart';

// List database = [];

class selectImage extends StatelessWidget {
  const selectImage({super.key, required this.token});
  final String token;
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
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.06),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.04),
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
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.05),
                                Text(
                                  "Upload Image",
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                  ),
                                ),
                              ],
                            ),
                            backgroundColor: Color(0xFF8cb369),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(
                                  MediaQuery.of(context).size.width * 0.06),
                            ),
                            onPressed: () async {
                              image_picker(1, context);
                            },
                            heroTag: 'image-select',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.04),
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
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                  ),
                                ),
                              ],
                            ),
                            backgroundColor: Color(0xFF8cb369),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(
                                  MediaQuery.of(context).size.width * 0.06),
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
        // imageQuality: 80,
      ))!;
    } else {
      _image = (await _picker.pickImage(source: ImageSource.gallery))!;
    }

    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return Danalyze(
        image: _image,
        imgpath: File(_image!.path),
        token: token,
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
  // final String url = 'http://kalrify.sit.kmutt.ac.th:3000/analyze/getAnalyze';
  // List database = [];

  // Future<String> getDishInfo() async {
  //   var res = await http.get(
  //     Uri.parse(url),
  //     headers: {"Accept": "application/json", "food": foodName.toString()},
  //   );

  //   setState(() {
  //     var resBody = json.decode(res.body);
  //     database = resBody["analyze"];
  //   });

  //   return "Success!";
  // }

  @override
  Widget build(BuildContext context) {
    print(database);
    return Center(
      child: Hero(
          tag: 'view-meal-info',
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.67,
            child: Material(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.06)),
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: database.isEmpty
                    ? Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.02),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.65,
                          height: MediaQuery.of(context).size.height * 0.67,
                          child: Center(
                            child: Text(
                                'Please tap an "Identify" button and wait for the result before using this feature',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.045,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF8cb369))),
                          ),
                        ),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: database.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Flexible(
                            child: Column(
                              children: <Widget>[
                                // SizedBox(
                                //   height:
                                //       MediaQuery.of(context).size.height * 0.01,
                                // ),
                                // Dish Name
                                Center(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.01,
                                      // vertical:
                                      //     MediaQuery.of(context).size.width *
                                      //         0.02
                                    ),
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Text(
                                            database[0]["FoodNameENG"],
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.047,
                                                color: Color.fromRGBO(
                                                    228, 87, 46, 1)),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            "(" +
                                                database[0]["FoodNameTH"] +
                                                ")",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.047,
                                                color: Color.fromRGBO(
                                                    228, 87, 46, 1)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                // // Dish Image
                                Padding(
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * 0.01),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    height:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: new Image.memory(
                                      Uint8List.fromList(database[0]["Image"]
                                              ["data"]
                                          .cast<int>()),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // Calories
                                Padding(
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * 0.03),
                                  child: Container(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Color.fromRGBO(
                                                          140, 179, 105, 1)))),
                                          child: Column(children: [
                                            Container(
                                              child: Text(
                                                "Energy",
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.05,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.02),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets.all(
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.02),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "Calories per dish: ",
                                                              style: TextStyle(
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.04,
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
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.04,
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
                                                        padding: EdgeInsets.all(
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.02),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "Portion: ",
                                                              style: TextStyle(
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.04,
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
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.04,
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
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.02),
                                        child: Container(
                                          child: Text(
                                            "Nutritions",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.05,
                                                color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            MediaQuery.of(context).size.width *
                                                0.01),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              // Nutrition Column 1
                                              Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.01),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Fat: ",
                                                          style: TextStyle(
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.04,
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
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.04,
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
                                                    padding: EdgeInsets.all(
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.01),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Carbohydrate: ",
                                                          style: TextStyle(
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.04,
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
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.04,
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
                                                    padding: EdgeInsets.all(
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.01),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Sodium: ",
                                                          style: TextStyle(
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.04,
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
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.04,
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
                                                    padding: EdgeInsets.all(
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.01),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Protein: ",
                                                          style: TextStyle(
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.04,
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
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.04,
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
                        }),
              ),
            ),
          )),
    );
  }

  // void initState() {
  //   super.initState();
  //   this.getDishInfo();
  // }
}

// this class will hold the form data
class FormDiary {
  String mealType = '';
}

FormDiary _formDiary = FormDiary();

class addDiary extends StatefulWidget {
  String token;

  addDiary({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  State<addDiary> createState() => _addDiaryState(token: token);
}

class _addDiaryState extends State<addDiary> {
  _addDiaryState({required this.token});
  String token;
  String addUrl = 'http://kalrify.sit.kmutt.ac.th:3000/diary/addDiary';
  TextEditingController dateController = TextEditingController();
  String meal = "Breakfast";

  @override
  void initState() {
    super.initState();
    dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  Future addDiary(cal, engName, thName, fat, carb, protein, sodium, portion,
      date, meal) async {
    print(meal);
    var res = await http.post(
      Uri.parse(addUrl),
      headers: <String, String>{'Authorization': 'Bearer $token'},
      body: {
        "date_Now": date,
        "total_Cal": cal,
        "FoodNameENG": engName,
        "FoodNameTH": thName,
        "Fat": fat,
        "Carb": carb,
        "Protein": protein,
        "Sodium": sodium,
        "Portion": portion,
        "meal": meal,
      },
    );
    if (res.statusCode == 200) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Udiary(
                    token: token,
                  )));
    } else {
      print('Error');
    }
  }

  // bool isExecuted = false;
  @override
  Widget build(BuildContext context) {
    print(token);
    return database.isEmpty
        ? Center(
            child: Hero(
                tag: 'view-meal-info',
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Material(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width * 0.06)),
                        child: SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            child: Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.02),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                child: Center(
                                  child: Text(
                                      'Please tap an "Identify" button and wait for the result before using this feature',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.045,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF8cb369))),
                                ),
                              ),
                            ))))))
        : AddDiary(
            token: token,
            cal: database[0]["Calories"].toString(),
            engName: database[0]["FoodNameENG"].toString(),
            thaiName: database[0]["FoodNameTH"].toString(),
            fat: database[0]["Fat"].toString(),
            carb: database[0]["Carb"].toString(),
            protein: database[0]["Protein"].toString(),
            sodium: database[0]["Sodium"].toString(),
            portion: database[0]["Portion"].toString());
  }
}

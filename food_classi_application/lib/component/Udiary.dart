import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../homescreen.dart';
import 'DiaryList.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Udiary extends StatefulWidget {
  @override
  State<Udiary> createState() => _UdiaryState();
}

class _UdiaryState extends State<Udiary> {
  final String url = 'http://kalrify.sit.kmutt.ac.th:3000/diary/getDiary';
  final String img = 'http://kalrify.sit.kmutt.ac.th:3000/image/getImage';
  List database = [];
  List<int> dataimageList = [];
  String dataImage = "";
  List temp = [];
  int num = 0;
  var token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjY3NjM1MDA2fQ.REaJTMWlDkJRqxoR9YrZ2f8zwXE_0_y6kOcTdGFbqWk';

  Future<String> getDiaryData() async {
    var res = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    });

    setState(() {
      var resBody = json.decode(res.body);
      print(resBody);
      database = resBody["diary"];
      database = database.reversed.toList();
    });

    return "Success!";
  }

  Future<String> getImage(foodImage) async {
    print(foodImage);
    var res = await http.get(
      Uri.parse(img),
      headers: {"Accept": "application/json", "food": foodImage.toString()},
    );
    var resBody = json.decode(res.body);
    dataImage = resBody["image"]
        .toString()
        .replaceFirst("[{Image: {type: Buffer, data: ", "");
    dataImage = dataImage.substring(0, (dataImage.length - 3));
    dataimageList = dataImage
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split(',')
        .map<int>((e) {
      return int.parse(e);
    }).toList();

    return "Success!";
  }

  bool _showData = false;
  int maxCal = 2000;
  int eatCal = 1600;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          ),
        ),
        title: Center(
          child: Text(
            "User Diary Information",
            style: TextStyle(
              fontSize: 19,
            ),
          ),
        ),
        backgroundColor: Color(0xFF8cb369),
      ),
      body: Center(
        child: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Container(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "Date: " +
                        DateFormat("dd MMMM yyyy")
                            .format(DateTime.now())
                            .toString(),
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Color.fromRGBO(255, 170, 90, 1)))),
              child: new CircularPercentIndicator(
                radius: 100.0,
                animation: true,
                animationDuration: 1200,
                lineWidth: 15.0,
                percent: eatCal / maxCal,
                center: new Text(
                  (maxCal - eatCal).toString() + " Kcal left",
                  style: new TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0,
                      color: Color.fromRGBO(228, 87, 46, 1)),
                ),
                footer: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(children: [
                    new Text(
                      "Max calories per day: ",
                      style: new TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 17.0,
                          color: Color.fromRGBO(228, 87, 46, 1)),
                    ),
                    new Text(
                      eatCal.toString() + "/" + maxCal.toString() + " Kcal",
                      style: new TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 17.0,
                          color: Colors.grey),
                    ),
                  ]),
                ),
                circularStrokeCap: CircularStrokeCap.butt,
                backgroundColor: Color.fromARGB(226, 140, 179, 105),
                progressColor: Color.fromARGB(248, 228, 88, 46),
              ),
            ),
          ),
          // DiaryList(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: database.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildPlayerModelList(database[index]);
              },
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildPlayerModelList(item) {
    List dish_list = [];
    var resDish = json.decode(item["dishList"]);
    dish_list = resDish["body"];
    return Card(
      child: ListTileTheme(
        tileColor: const Color(0xFF8cb369),
        child: ExpansionTile(
          textColor: Colors.white,
          collapsedTextColor: Colors.white,

          // backgroundColor: Color.fromARGB(255, 255, 255, 255),
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              DateFormat("dd MMM yyyy")
                  .format(DateTime.parse(item["date"]))
                  .toString(),
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
            Text(
              (item["totalCal"]).toString() + "kcal",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
          ]),
          controlAffinity: ListTileControlAffinity.trailing,
          children: <Widget>[
            Container(
              constraints: BoxConstraints(
                maxHeight: double.infinity,
              ),
              margin: const EdgeInsets.all(20.0),
              // padding:
              //     EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: ListTileTheme(
                tileColor: Colors.white,
                child: Container(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: dish_list.length,
                    itemBuilder: (context, index) {
                      return FutureBuilder(
                          future: getImage(dish_list[index]["FoodNameENG"]),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              List<int> temp_list = dataimageList;
                              return GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(36.0),
                                      ),
                                      context: context,
                                      builder: (context) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: Column(
                                            children: [
                                              // Dish Name
                                              Center(
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                                  child: Center(
                                                    child: Text(
                                                      dish_list[index]
                                                              ["FoodNameENG"] +
                                                          "(" +
                                                          dish_list[index]
                                                              ["FoodNameTH"] +
                                                          ")",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Color.fromRGBO(
                                                              228, 87, 46, 1)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // Dish Image
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                child: new Image.memory(
                                                    Uint8List.fromList(
                                                        temp_list)),
                                              ),
                                              // Calories
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                    child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 20),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            border: Border(
                                                                bottom: BorderSide(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            255,
                                                                            170,
                                                                            90,
                                                                            1)))),
                                                        child: Column(
                                                            children: [
                                                              Container(
                                                                child: Text(
                                                                  "Energy",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20,
                                                                    vertical:
                                                                        5),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Container(
                                                                          padding: EdgeInsets.symmetric(
                                                                              horizontal: 10,
                                                                              vertical: 10),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Text(
                                                                                "Calories per dish: ",
                                                                                style: TextStyle(fontSize: 14, color: Color.fromRGBO(228, 87, 46, 1)),
                                                                              ),
                                                                              Text(
                                                                                dish_list[index]["Calories"].toString() + " (Kcal) ",
                                                                                style: TextStyle(fontSize: 14, color: Color.fromRGBO(140, 179, 105, 1)),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          padding: EdgeInsets.symmetric(
                                                                              horizontal: 10,
                                                                              vertical: 10),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Text(
                                                                                "Portion: ",
                                                                                style: TextStyle(fontSize: 14, color: Color.fromRGBO(228, 87, 46, 1)),
                                                                              ),
                                                                              Text(
                                                                                dish_list[index]["Portion"].toString() + " (Serving) ",
                                                                                style: TextStyle(fontSize: 14, color: Color.fromRGBO(140, 179, 105, 1)),
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
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10),
                                                      child: Container(
                                                        child: Text(
                                                          "Nutritions",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 20,
                                                        vertical: 5,
                                                      ),
                                                      child: Center(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            // Nutrition Column 1
                                                            Column(
                                                              children: [
                                                                Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          10,
                                                                      vertical:
                                                                          10),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        "Fat: ",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color: Color.fromRGBO(
                                                                                228,
                                                                                87,
                                                                                46,
                                                                                1)),
                                                                      ),
                                                                      Text(
                                                                        dish_list[index]["Fat"].toString() +
                                                                            " (g.)",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color: Color.fromRGBO(
                                                                                140,
                                                                                179,
                                                                                105,
                                                                                1)),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          10,
                                                                      vertical:
                                                                          10),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        "Carbohydrate: ",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color: Color.fromRGBO(
                                                                                228,
                                                                                87,
                                                                                46,
                                                                                1)),
                                                                      ),
                                                                      Text(
                                                                        dish_list[index]["Carb"].toString() +
                                                                            " (g.)",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color: Color.fromRGBO(
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
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          10,
                                                                      vertical:
                                                                          10),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        "Fat: ",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color: Color.fromRGBO(
                                                                                228,
                                                                                87,
                                                                                46,
                                                                                1)),
                                                                      ),
                                                                      Text(
                                                                        dish_list[index]["Sodium"].toString() +
                                                                            " (mg.)",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color: Color.fromRGBO(
                                                                                140,
                                                                                179,
                                                                                105,
                                                                                1)),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          10,
                                                                      vertical:
                                                                          10),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        "Protein: ",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color: Color.fromRGBO(
                                                                                228,
                                                                                87,
                                                                                46,
                                                                                1)),
                                                                      ),
                                                                      Text(
                                                                        dish_list[index]["Protein"].toString() +
                                                                            " (g.)",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color: Color.fromRGBO(
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
                                      });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Color.fromRGBO(
                                                  255, 170, 90, 1)))),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      child: new Image.memory(
                                          Uint8List.fromList(temp_list)),
                                      backgroundColor: Colors.transparent,
                                    ),
                                    title: Text(
                                      dish_list[index]["FoodNameENG"],
                                      style: TextStyle(
                                          color: Color.fromRGBO(228, 87, 46, 1),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    subtitle: Text(
                                        dish_list[index]["Calories"]
                                                .toString() +
                                            " kcal",
                                        style: TextStyle(
                                            color: Color(0xFF8cb369),
                                            fontSize: 15)),
                                  ),
                                ),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void initState() {
    super.initState();
    this.getDiaryData();
    // this.getImage("");
  }
}

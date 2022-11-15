import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../homescreen.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Udiary extends StatefulWidget {
  const Udiary({super.key, required this.token});
  final String token;
  @override
  State<Udiary> createState() => _UdiaryState(token: token);
}

class _UdiaryState extends State<Udiary> {
  _UdiaryState({required this.token});
  final String token;
  final String url = 'http://kalrify.sit.kmutt.ac.th:3000/diary/getDiary';
  final String img = 'http://kalrify.sit.kmutt.ac.th:3000/image/getImage';
  final String profile = 'http://kalrify.sit.kmutt.ac.th:3000/user/getProfile';
  final String totalCal =
      'http://kalrify.sit.kmutt.ac.th:3000/diary/getTotalcal';
  final String delDiary = 'http://kalrify.sit.kmutt.ac.th:3000/diary/delDiary';
  final String findDish =
      'http://kalrify.sit.kmutt.ac.th:3000/diary/findDishlist';

  List database = [];
  List<int> dataimageList = [];
  String dataImage = "";
  List temp = [];
  int num = 0;
  List profileData = [];
  List totalcalData = [];
  int maxCal = 0;
  int eatCal = 0;
  TextEditingController dateController = TextEditingController();

  Future<String> getDiaryData() async {
    var res = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    });

    setState(() {
      var resBody = json.decode(res.body);
      // print(resBody);
      database = resBody["diary"];
      database = database.reversed.toList();
    });

    return "Success!";
  }

  Future<String> getImage(foodImage) async {
    // print(foodImage);
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

  Future<String> getProfileData() async {
    var res = await http.get(Uri.parse(profile), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    });
    print('Get Profile');
    print(json.decode(res.body));

    var resBody = json.decode(res.body);
    // print(resBody);
    profileData = resBody["user"];

    return "Success!";
  }

  Future<String> getTotalCalData() async {
    var date = DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();
    var res = await http.get(
      Uri.parse(totalCal),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
        'date': date,
      },
    );
    print('Get Total');
    print(json.decode(res.body));

    var resBody = json.decode(res.body);
    // print(resBody);
    totalcalData = resBody["diary"];
    eatCal = totalcalData[0]["totalCal"];

    return "Success!";
  }

  Future<String> delDish(id, index, cal) async {
    print(id);
    print(index);
    print(cal);
    var res = await http.post(
      Uri.parse(delDiary),
      headers: <String, String>{'Authorization': 'Bearer $token'},
      body: {
        "dishID": id.toString(),
        "dishIndex": index.toString(),
        "cal": cal.toString()
      },
    );
    print(res);
    print(res.statusCode);

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
    return "Success!";
  }

  Future<String> findDishList(date) async {
    var res = await http.get(Uri.parse(findDish), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      "date": date.toString()
    });

    setState(() {
      var resBody = json.decode(res.body);
      // print(resBody);
      database = resBody["dishList"];
    });

    return "Success!";
  }

  // bool _showData = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getTotalCalData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return FutureBuilder(
                future: getProfileData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (profileData[0]["gender"] == "male") {
                      print('male');
                      maxCal = (66.47 +
                              (13.75 * profileData[0]["weight"]) +
                              (5.003 * profileData[0]["height"]) -
                              (6.755 * profileData[0]["age"]))
                          .toInt();
                    } else {
                      print('female');
                      maxCal = (655.1 +
                              (9.563 * profileData[0]["weight"]) +
                              (1.850 * profileData[0]["height"]) -
                              (4.676 * profileData[0]["age"]))
                          .toInt();
                    }

                    double percentCal = eatCal.toDouble() / maxCal.toDouble();
                    String remainCal =
                        (maxCal - eatCal).toString() + " Kcal left";
                    if (percentCal > 1) {
                      percentCal = 1.0;
                      remainCal = "No calories left";
                    }

                    return Scaffold(
                      appBar: AppBar(
                        leading: IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen(token: token)),
                          ),
                        ),
                        title: Center(
                          child: Text(
                            "User Diary Information",
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                            ),
                          ),
                        ),
                        backgroundColor: Color(0xFF8cb369),
                      ),
                      body: Center(
                        child: ListView(children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.05),
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
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.05),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Color.fromRGBO(
                                              255, 170, 90, 1)))),
                              child: new CircularPercentIndicator(
                                radius: 100.0,
                                animation: true,
                                animationDuration: 1200,
                                lineWidth:
                                    MediaQuery.of(context).size.width * 0.04,
                                percent: percentCal,
                                center: new Text(
                                  remainCal,
                                  style: new TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                      color: Color.fromRGBO(228, 87, 46, 1)),
                                ),
                                footer: Padding(
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * 0.05),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        new Text(
                                          "Max calories per day: ",
                                          style: new TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.045,
                                              color: Color.fromRGBO(
                                                  228, 87, 46, 1)),
                                        ),
                                        new Text(
                                          eatCal.toString() +
                                              "/" +
                                              maxCal.toString() +
                                              " Kcal",
                                          style: new TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.045,
                                              color: Colors.grey),
                                        ),
                                      ]),
                                ),
                                circularStrokeCap: CircularStrokeCap.butt,
                                backgroundColor:
                                    Color.fromARGB(226, 140, 179, 105),
                                progressColor: Color.fromARGB(248, 228, 88, 46),
                              ),
                            ),
                          ),
                          // DiaryList,
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 0.0),
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
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
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
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.042,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              (item["totalCal"]).toString() + "kcal",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.042,
                  fontWeight: FontWeight.w500),
            ),
          ]),
          controlAffinity: ListTileControlAffinity.trailing,
          children: <Widget>[
            Container(
              constraints: BoxConstraints(
                maxHeight: double.infinity,
              ),
              margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
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
                                        return SingleChildScrollView(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.05),
                                            child: Column(
                                              children: [
                                                // Dish Name
                                                Center(
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal:
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.02,
                                                        vertical: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.01),
                                                    child: Center(
                                                      child: Text(
                                                        dish_list[index][
                                                                "FoodNameENG"] +
                                                            "(" +
                                                            dish_list[index]
                                                                ["FoodNameTH"] +
                                                            ")",
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.047,
                                                            color:
                                                                Color.fromRGBO(
                                                                    228,
                                                                    87,
                                                                    46,
                                                                    1)),
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
                                                  padding: EdgeInsets.all(
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.02),
                                                  child: Container(
                                                      child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal:
                                                                MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.05),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              border: Border(
                                                                  bottom: BorderSide(
                                                                      color: Color.fromRGBO(
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
                                                                            MediaQuery.of(context).size.width *
                                                                                0.05,
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          MediaQuery.of(context).size.width *
                                                                              0.05,
                                                                      vertical: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.01),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          Container(
                                                                            padding:
                                                                                EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02, vertical: MediaQuery.of(context).size.width * 0.02),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Text(
                                                                                  "Calories per dish: ",
                                                                                  style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04, color: Color.fromRGBO(228, 87, 46, 1)),
                                                                                ),
                                                                                Text(
                                                                                  dish_list[index]["Calories"].toString() + " (Kcal) ",
                                                                                  style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04, color: Color.fromRGBO(140, 179, 105, 1)),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            padding:
                                                                                EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02, vertical: MediaQuery.of(context).size.width * 0.02),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Text(
                                                                                  "Portion: ",
                                                                                  style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04, color: Color.fromRGBO(228, 87, 46, 1)),
                                                                                ),
                                                                                Text(
                                                                                  dish_list[index]["Portion"].toString() + " (Serving) ",
                                                                                  style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04, color: Color.fromRGBO(140, 179, 105, 1)),
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
                                                            top: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.02),
                                                        child: Container(
                                                          child: Text(
                                                            "Nutritions",
                                                            style: TextStyle(
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.05,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          horizontal:
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.05,
                                                          vertical: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.01,
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
                                                                            MediaQuery.of(context).size.width *
                                                                                0.01,
                                                                        vertical:
                                                                            MediaQuery.of(context).size.width *
                                                                                0.01),
                                                                    child: Row(
                                                                      children: [
                                                                        Text(
                                                                          "Fat: ",
                                                                          style: TextStyle(
                                                                              fontSize: MediaQuery.of(context).size.width * 0.04,
                                                                              color: Color.fromRGBO(228, 87, 46, 1)),
                                                                        ),
                                                                        Text(
                                                                          dish_list[index]["Fat"].toString() +
                                                                              " (g.)",
                                                                          style: TextStyle(
                                                                              fontSize: MediaQuery.of(context).size.width * 0.04,
                                                                              color: Color.fromRGBO(140, 179, 105, 1)),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            MediaQuery.of(context).size.width *
                                                                                0.02,
                                                                        vertical:
                                                                            MediaQuery.of(context).size.width *
                                                                                0.02),
                                                                    child: Row(
                                                                      children: [
                                                                        Text(
                                                                          "Carbohydrate: ",
                                                                          style: TextStyle(
                                                                              fontSize: MediaQuery.of(context).size.width * 0.04,
                                                                              color: Color.fromRGBO(228, 87, 46, 1)),
                                                                        ),
                                                                        Text(
                                                                          dish_list[index]["Carb"].toString() +
                                                                              " (g.)",
                                                                          style: TextStyle(
                                                                              fontSize: MediaQuery.of(context).size.width * 0.04,
                                                                              color: Color.fromRGBO(140, 179, 105, 1)),
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
                                                                            MediaQuery.of(context).size.width *
                                                                                0.01,
                                                                        vertical:
                                                                            MediaQuery.of(context).size.width *
                                                                                0.01),
                                                                    child: Row(
                                                                      children: [
                                                                        Text(
                                                                          "Fat: ",
                                                                          style: TextStyle(
                                                                              fontSize: MediaQuery.of(context).size.width * 0.04,
                                                                              color: Color.fromRGBO(228, 87, 46, 1)),
                                                                        ),
                                                                        Text(
                                                                          dish_list[index]["Sodium"].toString() +
                                                                              " (mg.)",
                                                                          style: TextStyle(
                                                                              fontSize: MediaQuery.of(context).size.width * 0.04,
                                                                              color: Color.fromRGBO(140, 179, 105, 1)),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            MediaQuery.of(context).size.width *
                                                                                0.02,
                                                                        vertical:
                                                                            MediaQuery.of(context).size.width *
                                                                                0.02),
                                                                    child: Row(
                                                                      children: [
                                                                        Text(
                                                                          "Protein: ",
                                                                          style: TextStyle(
                                                                              fontSize: MediaQuery.of(context).size.width * 0.04,
                                                                              color: Color.fromRGBO(228, 87, 46, 1)),
                                                                        ),
                                                                        Text(
                                                                          dish_list[index]["Protein"].toString() +
                                                                              " (g.)",
                                                                          style: TextStyle(
                                                                              fontSize: MediaQuery.of(context).size.width * 0.04,
                                                                              color: Color.fromRGBO(140, 179, 105, 1)),
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
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(
                                                            0,
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.02,
                                                            0,
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.05),
                                                        child:
                                                            FloatingActionButton
                                                                .extended(
                                                          label: Text(
                                                              'Delete from Diary'), // <-- Text
                                                          backgroundColor:
                                                              Colors.red,
                                                          icon: Icon(
                                                            // <-- Icon
                                                            Icons.delete,
                                                            size: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.051,
                                                          ),
                                                          onPressed: () => delDish(
                                                              item["id"],
                                                              index,
                                                              dish_list[index]
                                                                  ["Calories"]),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                                )
                                              ],
                                            ),
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
                                        radius:
                                            MediaQuery.of(context).size.width *
                                                0.08,
                                      ),
                                      title: Text(
                                        dish_list[index]["FoodNameENG"],
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(228, 87, 46, 1),
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.043),
                                      ),
                                      subtitle: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                "Cal: " +
                                                    dish_list[index]["Calories"]
                                                        .toString() +
                                                    " kcal",
                                                style: TextStyle(
                                                    color: Color(0xFF8cb369),
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.04)),
                                            Text(
                                                "Time: " +
                                                    dish_list[index]["Meal"]
                                                        .toString(),
                                                style: TextStyle(
                                                    color: Color(0xFF8cb369),
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.04)),
                                          ]),
                                    )),
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
    dateController.text = "";
    // this.getImage("");
  }
}

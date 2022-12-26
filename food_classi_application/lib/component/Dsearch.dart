import 'package:flutter/material.dart';
import 'package:food_classi_application/component/AddDiary.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import '../decoration/hero_dialog_route.dart';
import '../homescreen.dart';

class Dsearch extends StatefulWidget {
  const Dsearch({super.key, required this.token});

  final String token;

  @override
  State<Dsearch> createState() => _DsearchState(token: token);
}

class _DsearchState extends State<Dsearch> {
  _DsearchState({required this.token});

  final String addUrl = 'http://kalrify.sit.kmutt.ac.th:3000/diary/addDiary';
  List database = [];
  bool isExecuted = false;
  List items = [];
  final TextEditingController searchController = TextEditingController();
  final String token;
  final String url = 'http://kalrify.sit.kmutt.ac.th:3000/dish/getDish';

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    searchController.dispose();
    super.dispose();
  }

  Future<String> getDishData() async {
    print('search: ' + token);
    var res = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    });

    setState(() {
      var resBody = json.decode(res.body);
      database = resBody["dish"];
      items.addAll(database);
    });

    return "Success!";
  }

  void filterSearchResults(String query) {
    List dummySearchList = [];
    dummySearchList.addAll(database);
    if (query.isNotEmpty) {
      List dummyListData = [];
      for (var i = 0; i < database.length; i++) {
        if (database[i]['FoodNameENG'].contains(query) ||
            database[i]['FoodNameTH'].contains(query)) {
          dummyListData.add(database[i]);
        }
      }
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    }
    if (query.isEmpty) {
      setState(() {
        items.clear();
        items.addAll(dummySearchList);
      });
    }
  }

  void initState() {
    super.initState();
    this.getDishData();
  }

  @override
  Widget build(BuildContext context) {
    if (database.isNotEmpty) {
      print(Uint8List.fromList(database[0]["Image"]["data"].cast<int>()));
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen(token: token)),
          ),
        ),
        title: Center(
          child: Text(
            "Search Dish Information",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.05,
            ),
          ),
        ),
        backgroundColor: Color(0xFF8cb369),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                child: TextField(
                  onChanged: (value) {
                    value = searchController.text;
                    filterSearchResults(value);
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.width * 0.04),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width * 0.07),
                          borderSide: BorderSide(
                              width:
                                  MediaQuery.of(context).size.width * 0.007)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width * 0.07),
                          borderSide: BorderSide(
                              width: MediaQuery.of(context).size.width * 0.003,
                              color: Theme.of(context).primaryColor)),
                      hintText: "Search any dish name",
                      prefixIcon: Icon(
                        Icons.search,
                        size: MediaQuery.of(context).size.width * 0.07,
                      ),
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              isExecuted = false;
                              searchController.clear();
                              items.clear();
                              items.addAll(database);
                            });
                          })),
                ),
              ),
              Container(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.04,
                      vertical: MediaQuery.of(context).size.width * 0.05),
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          showModalBottomSheet<dynamic>(
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width * 0.07),
                              ),
                              context: context,
                              builder: (context) => Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.6,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.015,
                                        ),
                                        // Dish Name
                                        Center(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.03,
                                                vertical: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.02),
                                            child: Column(
                                              children: [
                                                Center(
                                                  child: Text(
                                                    items[index]["FoodNameENG"],
                                                    style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
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
                                                        items[index]
                                                            ["FoodNameTH"] +
                                                        ")",
                                                    style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
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
                                              Uint8List.fromList(items[index]
                                                      ["Image"]["data"]
                                                  .cast<int>())),
                                        ),
                                        // Calories
                                        Padding(
                                          padding: EdgeInsets.all(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03),
                                          child: Container(
                                              child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.05),
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
                                                  child: Column(children: [
                                                    Container(
                                                      child: Text(
                                                        "Energy",
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.05,
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(
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
                                                              0.01),
                                                      child: Row(
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Container(
                                                                padding: EdgeInsets.symmetric(
                                                                    horizontal: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.05,
                                                                    vertical: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.01),
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      "Calories per dish: ",
                                                                      style: TextStyle(
                                                                          fontSize: MediaQuery.of(context).size.width *
                                                                              0.04,
                                                                          color: Color.fromRGBO(
                                                                              228,
                                                                              87,
                                                                              46,
                                                                              1)),
                                                                    ),
                                                                    Text(
                                                                      items[index]["Calories"]
                                                                              .toString() +
                                                                          " (Kcal) ",
                                                                      style: TextStyle(
                                                                          fontSize: MediaQuery.of(context).size.width *
                                                                              0.04,
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
                                                                    horizontal: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.02,
                                                                    vertical: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.02),
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      "Portion: ",
                                                                      style: TextStyle(
                                                                          fontSize: MediaQuery.of(context).size.width *
                                                                              0.04,
                                                                          color: Color.fromRGBO(
                                                                              228,
                                                                              87,
                                                                              46,
                                                                              1)),
                                                                    ),
                                                                    Text(
                                                                      items[index]["Portion"]
                                                                              .toString() +
                                                                          " (Serving) ",
                                                                      style: TextStyle(
                                                                          fontSize: MediaQuery.of(context).size.width *
                                                                              0.04,
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
                                                        0.01),
                                                child: Container(
                                                  child: Text(
                                                    "Nutritions",
                                                    style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.05,
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.05,
                                                  vertical:
                                                      MediaQuery.of(context)
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
                                                                horizontal: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.01,
                                                                vertical: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.01),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  "Fat: ",
                                                                  style: TextStyle(
                                                                      fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.04,
                                                                      color: Color.fromRGBO(
                                                                          228,
                                                                          87,
                                                                          46,
                                                                          1)),
                                                                ),
                                                                Text(
                                                                  items[index][
                                                                              "Fat"]
                                                                          .toString() +
                                                                      " (g.)",
                                                                  style: TextStyle(
                                                                      fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.04,
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
                                                                horizontal: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.01,
                                                                vertical: 0),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  "Carbohydrate: ",
                                                                  style: TextStyle(
                                                                      fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.04,
                                                                      color: Color.fromRGBO(
                                                                          228,
                                                                          87,
                                                                          46,
                                                                          1)),
                                                                ),
                                                                Text(
                                                                  items[index][
                                                                              "Carb"]
                                                                          .toString() +
                                                                      " (g.)",
                                                                  style: TextStyle(
                                                                      fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.04,
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
                                                                horizontal: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.01,
                                                                vertical: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.01),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  "Sodium: ",
                                                                  style: TextStyle(
                                                                      fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.04,
                                                                      color: Color.fromRGBO(
                                                                          228,
                                                                          87,
                                                                          46,
                                                                          1)),
                                                                ),
                                                                Text(
                                                                  items[index][
                                                                              "Sodium"]
                                                                          .toString() +
                                                                      " (mg.)",
                                                                  style: TextStyle(
                                                                      fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.04,
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
                                                                horizontal: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.01,
                                                                vertical: 0),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  "Protein: ",
                                                                  style: TextStyle(
                                                                      fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.04,
                                                                      color: Color.fromRGBO(
                                                                          228,
                                                                          87,
                                                                          46,
                                                                          1)),
                                                                ),
                                                                Text(
                                                                  items[index][
                                                                              "Protein"]
                                                                          .toString() +
                                                                      " (g.)",
                                                                  style: TextStyle(
                                                                      fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.04,
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
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              0,
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.02,
                                              0,
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.01),
                                          child: FloatingActionButton.extended(
                                            label: Text(
                                                'Add to Diary'), // <-- Text
                                            backgroundColor: Color(0xFF8cb369),
                                            icon: Icon(
                                              // <-- Icon
                                              Icons.note_alt,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.06,
                                            ),
                                            onPressed: () {
                                              print("data: ");
                                              print(items[index]);
                                              Navigator.of(context).push(
                                                  HeroDialogRoute(
                                                      builder: (context) {
                                                return AddDiary(
                                                  cal: items[index]["Calories"]
                                                      .toString(),
                                                  engName: items[index]
                                                          ["FoodNameENG"]
                                                      .toString(),
                                                  thaiName: items[index]
                                                          ["FoodNameTH"]
                                                      .toString(),
                                                  fat: items[index]["Fat"]
                                                      .toString(),
                                                  carb: items[index]["Carb"]
                                                      .toString(),
                                                  protein: items[index]
                                                          ["Protein"]
                                                      .toString(),
                                                  sodium: items[index]["Sodium"]
                                                      .toString(),
                                                  portion: items[index]
                                                          ["Portion"]
                                                      .toString(),
                                                  token: token,
                                                );
                                              }));
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            child: new Image.memory(Uint8List.fromList(
                                items[index]["Image"]["data"].cast<int>())),
                            backgroundColor: Colors.transparent,
                            radius: MediaQuery.of(context).size.width * 0.08,
                          ),
                          title: Text(
                            items[index]["FoodNameENG"],
                            style: TextStyle(
                                color: Color.fromRGBO(228, 87, 46, 1),
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.043),
                          ),
                          subtitle: Text(
                              items[index]["Calories"].toString() + " Kcal",
                              style: TextStyle(
                                  color: Color(0xFF8cb369),
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.04)),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

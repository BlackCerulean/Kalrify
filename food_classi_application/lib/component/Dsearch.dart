import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Dsearch extends StatefulWidget {
  @override
  State<Dsearch> createState() => _DsearchState();
}

class _DsearchState extends State<Dsearch> {
  final TextEditingController searchController = TextEditingController();
  bool isExecuted = false;
  final String url = 'http://kalrify.sit.kmutt.ac.th:3000/dish/getDish';
  List database = [];

  Future<String> getDishData() async {
    var res =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});

    setState(() {
      var resBody = json.decode(res.body);
      database = resBody["dish"];
    });

    return "Success!";
  }

  List<DishList> dishStock = [
    DishList(
        name: "Pad Ka Prao Gai",
        calories: 234.3,
        carbo: 11.8,
        fat: 13.2,
        protein: 18.0,
        img: 'assets/PadKaPraoGai.jpg'),
    DishList(
        name: "Kao Mok Gai",
        calories: 904.6,
        carbo: 81.8,
        fat: 38.4,
        protein: 55.7,
        img: 'assets/KaoMokGai.jpg'),
    DishList(
        name: "Kao Moo Dang",
        calories: 521,
        carbo: 71.3,
        fat: 16.5,
        protein: 21.9,
        img: "assets/KaoMooDang.jpg"),
    DishList(
        name: "Kao Moo Kratiam",
        calories: 343,
        carbo: 46,
        fat: 3,
        protein: 33,
        img: "assets/KaoMooKratiam.jpg"),
    DishList(
        name: "Kao Pad Kung",
        calories: 538.1,
        carbo: 43.4,
        fat: 24.4,
        protein: 34.5,
        img: "assets/KaoPadKung.jpg"),
    DishList(
        name: "Yum Woon Sen",
        calories: 427.3,
        carbo: 30.4,
        fat: 17.2,
        protein: 40.9,
        img: "assets/YumWoonSen.jpg"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Search Dish Information",
            style: TextStyle(
              fontSize: 19,
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
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 15.0),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(width: 0.8)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
                              width: 0.8,
                              color: Theme.of(context).primaryColor)),
                      hintText: "Search any dish name",
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 30,
                      ),
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              isExecuted = false;
                              searchController.clear();
                            });
                          })),
                ),
              ),
              Container(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: database.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(36.0),
                              ),
                              context: context,
                              builder: (context) {
                                return Padding(padding: const EdgeInsets.only(top: 20), 
                                child:Column(
                                  children: [
                                    // Dish Name
                                    Center(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Center(
                                          child: Text(
                                            database[index]["FoodNameENG"] +
                                                "(" +
                                                database[index]["FoodNameTH"] +
                                                ")",
                                            style: TextStyle(fontSize: 18, color: Color.fromRGBO(228, 87, 46, 1)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // // Dish Image
                                    // Container(
                                    //   width: MediaQuery.of(context).size.width *
                                    //       0.5,
                                    //   height:
                                    //       MediaQuery.of(context).size.width *
                                    //           0.3,
                                    //   child: Image.asset(database[index].img),
                                    // ),
                                    // Calories
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Color.fromRGBO(
                                                              255,
                                                              170,
                                                              90,
                                                              1)))),
                                              child: Column(children: [
                                                Container(
                                                  child: Text(
                                                    "Energy",
                                                    style:
                                                        TextStyle(fontSize: 20, color: Colors.grey),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20,
                                                      vertical: 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        10),
                                                            child: Row(children: [
                                                              Text(
                                                              "Calories per dish: ",
                                                              style: TextStyle(
                                                                  fontSize: 14, color: Color.fromRGBO(228, 87, 46, 1)),
                                                            ),
                                                            Text(
                                                                  database[index]
                                                                          [
                                                                          "Calories"]
                                                                      .toString() +
                                                                  " (Kcal) ",
                                                              style: TextStyle(
                                                                  fontSize: 14, color: Color.fromRGBO(140, 179, 105, 1)),
                                                            ),
                                                            ],
                                                            ),
                                                          ),
                                                          Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        10),
                                                            child: Row(children: [
                                                              Text(
                                                              "Portion: ",
                                                              style: TextStyle(
                                                                  fontSize: 14, color: Color.fromRGBO(228, 87, 46, 1)),
                                                            ),
                                                            Text(
                                                              database[index]
                                                                          [
                                                                          "Portion"]
                                                                      .toString() +
                                                                  " (Serving) ",
                                                              style: TextStyle(
                                                                  fontSize: 14, color: Color.fromRGBO(140, 179, 105, 1)),
                                                            ),
                                                            ],),
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
                                                const EdgeInsets.only(top: 10),
                                            child: Container(
                                              child: Text(
                                                "Nutritions",
                                                style: TextStyle(fontSize: 20, color: Colors.grey),
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
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  // Nutrition Column 1
                                                  Column(
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10,
                                                                vertical: 10),
                                                        child: Row(children: [
                                                          Text(
                                                          "Fat: ",
                                                          style: TextStyle(
                                                              fontSize: 14, color: Color.fromRGBO(228, 87, 46, 1)),
                                                        ),
                                                        Text(
                                                          database[index]
                                                                      ["Fat"]
                                                                  .toString() +
                                                              " (g.)",
                                                          style: TextStyle(
                                                              fontSize: 14, color: Color.fromRGBO(140, 179, 105, 1)),
                                                        ),
                                                        ],),
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10,
                                                                vertical: 10),
                                                        child: Row(children: [
                                                          Text(
                                                          "Carbohydrate: ",
                                                          style: TextStyle(
                                                              fontSize: 14, color: Color.fromRGBO(228, 87, 46, 1)),
                                                        ),
                                                        Text(
                                                          database[index]
                                                                      ["Carb"]
                                                                  .toString() +
                                                              " (g.)",
                                                          style: TextStyle(
                                                              fontSize: 14, color: Color.fromRGBO(140, 179, 105, 1)),
                                                        ),
                                                        ],),
                                                      ),
                                                    ],
                                                  ),
                                                  // Nutrition Column 2
                                                  Column(
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10,
                                                                vertical: 10),
                                                        child: Row(children: [
                                                          Text(
                                                          "Fat: ",
                                                          style: TextStyle(
                                                              fontSize: 14, color: Color.fromRGBO(228, 87, 46, 1)),
                                                        ),
                                                        Text(
                                                          database[index]
                                                                      ["Sodium"]
                                                                  .toString() +
                                                              " (mg.)",
                                                          style: TextStyle(
                                                              fontSize: 14, color: Color.fromRGBO(140, 179, 105, 1)),
                                                        ),
                                                        ],),
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10,
                                                                vertical: 10),
                                                        child: Row(children: [
                                                          Text(
                                                          "Protein: ",
                                                          style: TextStyle(
                                                              fontSize: 14, color: Color.fromRGBO(228, 87, 46, 1)),
                                                        ),
                                                        Text(
                                                          database[index][
                                                                      "Protein"]
                                                                  .toString() +
                                                              " (g.)",
                                                          style: TextStyle(
                                                              fontSize: 14, color: Color.fromRGBO(140, 179, 105, 1)),
                                                        ),
                                                        ],),
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
                                ),);
                              });
                        },
                        child: ListTile(
                          // leading: CircleAvatar(
                          //   child: Image.asset(database[index].img),
                          //   backgroundColor: Colors.transparent,
                          // ),
                          title: Text(
                            database[index]["FoodNameENG"],
                            style: TextStyle(
                                color: Color.fromRGBO(228, 87, 46, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          subtitle: Text(
                              database[index]["Calories"].toString() + " Kcal",
                              style: TextStyle(
                                  color: Color(0xFF8cb369), fontSize: 15)),
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

  void initState() {
    super.initState();
    this.getDishData();
  }
}

class DishList {
  String name, img;
  double? calories, fat, carbo, protein;

  DishList(
      {required this.name,
      required this.img,
      this.calories,
      this.carbo,
      this.fat,
      this.protein});
}

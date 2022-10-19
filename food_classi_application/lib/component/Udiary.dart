import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'DiaryList.dart';

class Udiary extends StatefulWidget {
  @override
  State<Udiary> createState() => _UdiaryState();
}

class _UdiaryState extends State<Udiary> {
  bool _showData = false;
  int maxCal = 2000;
  int eatCal = 1700;
  List<DiaryDish> diary = [
    DiaryDish(date: "1/Oct/2022", dish: [
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
    ]),
    DiaryDish(date: "2/Oct/2022", dish: [
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
    ]),
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
      body: Center(
        child: ListView(children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(20.0),
              child: new CircularPercentIndicator(
                radius: 100.0,
                animation: true,
                animationDuration: 1200,
                lineWidth: 15.0,
                percent: eatCal / maxCal,
                center: new Text(
                  "300 Kcal left",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                footer: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: new Text(
                    "Max calories per day: " +
                        eatCal.toString() +
                        "/" +
                        maxCal.toString() +
                        " Kcal",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17.0),
                  ),
                ),
                circularStrokeCap: CircularStrokeCap.butt,
                backgroundColor: Color.fromARGB(226, 140, 179, 105),
                progressColor: Color.fromARGB(248, 228, 88, 46),
              )),
          // DiaryList(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: diary.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildPlayerModelList(diary[index]);
              },
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildPlayerModelList(DiaryDish item) {
    return Card(
      child: ListTileTheme(
        tileColor: const Color(0xFF8cb369),
        child: ExpansionTile(
          textColor: Colors.white,
          collapsedTextColor: Colors.white,

          // backgroundColor: Color.fromARGB(255, 255, 255, 255),
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          Text(
            item.date,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
          ),
          Text(
            "1000Kcal",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
          ),
        ]
      ),
          
          // trailing: Text(
          //   "1000Kcal",
          //   style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
          // ),
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
                    shrinkWrap: true,
                    itemCount: item.dish.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Text(
                                        item.dish[index].name,
                                        style: TextStyle(fontSize: 30),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.3,
                                      child: Image.asset(item.dish[index].img),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Text(
                                              "Energy",
                                              style: TextStyle(fontSize: 30),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10,
                                                              vertical: 10),
                                                      child: Text(
                                                        "Calories: " +
                                                            item.dish[index]
                                                                .calories
                                                                .toString() +
                                                            " (Kcal) ",
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              "Nutritions",
                                              style: TextStyle(fontSize: 30),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 5,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Column(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10,
                                                              vertical: 10),
                                                      child: Text(
                                                        "Fat: " +
                                                            item.dish[index].fat
                                                                .toString() +
                                                            " (g.)",
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10,
                                                              vertical: 10),
                                                      child: Text(
                                                        "Carbohydrate: " +
                                                            item.dish[index]
                                                                .carbo
                                                                .toString() +
                                                            " (g.)",
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10,
                                                              vertical: 10),
                                                      child: Text(
                                                        "Protein: " +
                                                            item.dish[index]
                                                                .protein
                                                                .toString() +
                                                            " (g.)",
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                    )
                                  ],
                                );
                              });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Color.fromRGBO(255, 170, 90, 1)))),
                          child: Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Image.asset(item.dish[index].img),
                                backgroundColor: Colors.transparent,
                              ),
                              title: Text(
                                item.dish[index].name,
                                style: TextStyle(
                                    color: Color(0xFF8cb369),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              subtitle: Text(
                                  item.dish[index].calories.toString() +
                                      " Kcal",
                                  style: TextStyle(
                                      color: Color(0xFF8cb369), fontSize: 15)),
                            ),
                          ),
                        ),
                      );
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
}

class DiaryDish {
  String date;
  List<DishList> dish;
  bool isExpanded;

  DiaryDish({
    required this.date,
    required this.dish,
    this.isExpanded = false,
  });
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

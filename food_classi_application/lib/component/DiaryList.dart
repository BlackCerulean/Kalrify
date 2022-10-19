import 'package:flutter/material.dart';

// stores ExpansionPanel state information
class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

class DiaryList extends StatefulWidget {
  // right now it only accepts title, but you can add more
  // arguments to be accepted by this widget

  @override
  _DiaryListState createState() => _DiaryListState();
}

class _DiaryListState extends State<DiaryList> {
  // responsible for toggle
  bool _showData = false;

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
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          diary[index].isExpanded = !diary[index].isExpanded;
        });
      },
      expandedHeaderPadding: EdgeInsets.all(6),
      dividerColor: Colors.teal,
      elevation: 1,
      children: diary.map<ExpansionPanel>((DiaryDish item) {
        return ExpansionPanel(
          backgroundColor: const Color(0xFF8cb369),
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              textColor: Color.fromRGBO(255, 255, 255, 1),
              title: Text(item.date),
            );
          },
          body: Container(
            color: Color.fromRGBO(255, 255, 255, 1),
            child: Column(
              children: <Widget>[
                Container(
                  constraints: BoxConstraints(
                    maxHeight: double.infinity,
                  ),
                  margin: const EdgeInsets.all(20.0),
                  // padding:
                  //     EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child:
                                            Image.asset(item.dish[index].img),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10,
                                                                vertical: 10),
                                                        child: Text(
                                                          "Fat: " +
                                                              item.dish[index]
                                                                  .fat
                                                                  .toString() +
                                                              " (g.)",
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
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
                                                        padding: EdgeInsets
                                                            .symmetric(
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
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
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

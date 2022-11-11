// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_classi_application/component/Danalyze.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:food_classi_application/component/Udiary.dart';



class AddDiary extends StatefulWidget {
  
  String cal;
  String engName;
  String thaiName;
  String fat;
  String carb;
  String protein;
  String sodium;
  String portion;
  String day;
  String month;
  String year;
  String hour;
  int minute;
  String token;

  AddDiary({
    super.key,
    required this.token,
    required this.cal,
    required this.engName,
    required this.thaiName,
    required this.fat,
    required this.carb,
    required this.protein,
    required this.sodium,
    required this.portion,
    required this.day,
    required this.month,
    required this.year,
    required this.hour,
    required this.minute,
  });

  @override
  State<AddDiary> createState() => _AddDiaryState(token: token, cal: cal, carb: carb, engName: engName, thaiName: thaiName, fat: fat, portion: portion, protein: protein, sodium: sodium, day: day, month: month, year: year, hour: hour, minute: minute);
}

class _AddDiaryState extends State<AddDiary> {
  _AddDiaryState({required this.token,
  required this.cal,
    required this.engName,
    required this.thaiName,
    required this.fat,
    required this.carb,
    required this.protein,
    required this.sodium,
    required this.portion,
    required this.day,
    required this.month,
    required this.year,
    required this.hour,
    required this.minute,
  });

  String token;
  String cal;
  String engName;
  String thaiName;
  String fat;
  String carb;
  String protein;
  String sodium;
  String portion;
  String day;
  String month;
  String year;
  String hour;
  int minute;
  
   String addUrl = 'http://kalrify.sit.kmutt.ac.th:3000/diary/addDiary';
    Future addDiary(
      cal, engName, thName, fat, carb, protein, sodium, portion) async {
    var date = DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();
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
      },
    );
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
  // bool isExecuted = false;
  @override
  Widget build(BuildContext context) {
    print(token);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: 'add-meal-diary',
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
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
                                        MediaQuery.of(context).size.width *
                                            0.05,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(
                                            MediaQuery.of(context).size.width *
                                                0.01),
                                        child: Text(
                                          'Dish Name: ',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFb9b9b9),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            MediaQuery.of(context).size.width *
                                                0.01),
                                        child: Text(
                                          engName,
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04,
                                              color: Color(0xffE4572E)),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            MediaQuery.of(context).size.width *
                                                0.01),
                                        child: Text(
                                          'Calories: ',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFb9b9b9),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            MediaQuery.of(context).size.width *
                                                0.01),
                                        child: Text(
                                          cal +
                                              ' kcal per dish',
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04,
                                              color: Color(0xffE4572E)),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
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
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.01),
                                            child: Text(
                                              widget.day +
                                                  '-' +
                                                  widget.month +
                                                  '-' +
                                                  widget.year,
                                              style: TextStyle(
                                                  color: Color(0xFFb9b9b9),
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.04),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.07),
                                            child: SizedBox(),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
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
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.01),
                                            child: Text(
                                              widget.hour +
                                                  ':' +
                                                  ((widget.minute <= 9)
                                                          ? ('0' +
                                                              widget.minute
                                                                  .toString())
                                                          : widget.minute)
                                                      .toString(),
                                              style: TextStyle(
                                                  color: Color(0xFFb9b9b9),
                                                  fontSize:
                                                      MediaQuery.of(context)
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
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFb9b9b9),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            MediaQuery.of(context).size.width *
                                                0.05),
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
                                                          onChanged:
                                                              (value) {}),
                                                      Expanded(
                                                          child:
                                                              Text('Breakfast'))
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
                                                          onChanged:
                                                              (value) {}),
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
                                                          onChanged:
                                                              (value) {}),
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
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    child: FloatingActionButton(
                                      child: Text(
                                        'Save',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                        ),
                                      ),
                                      backgroundColor: Color(0xFF8cb369),
                                      shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(20.0),
                                      ),
                                      onPressed: () => addDiary(
                                              cal,
                                              engName,
                                              thaiName,
                                              fat,
                                              carb,
                                              protein,
                                              sodium,
                                              portion,
                                            
                                      ),
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
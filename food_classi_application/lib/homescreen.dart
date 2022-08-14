import 'package:flutter/material.dart';
import 'package:food_classi_application/component/Dsearch.dart';
import 'package:food_classi_application/component/Dupload.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.1,
              child: FloatingActionButton(
                child: Text(
                  "Upload Dish Image",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Color(0xFF8cb369),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return Dupload();
                  }));
                },
                heroTag: 'Dupload',
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 2,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.1,
              child: FloatingActionButton(
                child: Text(
                  "List of the Dishes",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Color(0xFF8cb369),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return Dsearch();
                  }));
                },
                heroTag: 'Search',
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 2,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.1,
              child: FloatingActionButton(
                child: Text(
                  "User Diary",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Color(0xFF8cb369),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                ),
                onPressed: () {},
                heroTag: 'Diary',
              ),
            ),
          )
        ],
      ),
    );
  }
}

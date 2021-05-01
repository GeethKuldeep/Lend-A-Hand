import 'package:flutter/material.dart';

import 'Community.dart';
import 'newProfile.dart';
import 'new_request.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'Home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;

  _getPage(int page) {
    switch (page) {
      case 0:
        return Community();
      case 1:
        return NewRequest();
      case 2:
        return newProfile();
    }
  }

  var color1 = Color(0xffA99CF0);
  var color6 = Color(0xFFFCACEF1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.add,
            size: 45,
          ),
          foregroundColor: color6,
          onPressed: () {
            setState(() {
              currentPage = 1;
            });
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8.0,
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 65,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlatButton(
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        currentPage = 0;
                      });
                    },
                    child: Icon(Icons.home_work, color: color6, size: 35)),
                FlatButton(
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        currentPage = 2;
                      });
                    },
                    child: Icon(Icons.person, color: color6, size: 35)),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Center(
            child: _getPage(currentPage),
          ),
        ),
      ),
    );
  }
}

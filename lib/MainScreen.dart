import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

FirebaseDatabase database = FirebaseDatabase.instance;

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    Column(
      children: [
        Expanded(
            child: FirebaseAnimatedList(
                duration: Duration(milliseconds: 100),
                query: database.reference().child("sunrise"),
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                        Animation<double> animation, int index) =>
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      shadowColor: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FadeInImage.assetNetwork(
                              fadeInDuration: Duration(milliseconds: 100),
                              fadeOutDuration: Duration(milliseconds: 100),
                              placeholder: "assets/images/splash.png",
                              imageCacheHeight: 1000,
                              imageCacheWidth: 1000,
                              image: snapshot.child("img").value.toString()),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              snapshot.child("title").value.toString(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Text(
                              snapshot.child("desc").value.toString(),
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 15,),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Text(
                              snapshot.child("school").value.toString(),
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 11, color: Colors.grey),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )))
      ],
    ),
    Text(
      'Index 1: Business',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: GradientText(
          "SUNRISE",
          colors: const [
            Colors.deepOrange,
            Colors.orangeAccent,
          ],
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.search,
                color: Colors.black,
                size: 26.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

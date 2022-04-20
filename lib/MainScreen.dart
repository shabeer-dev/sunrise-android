import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:sunrise/login.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

FirebaseDatabase database = FirebaseDatabase.instance;
final user = FirebaseAuth.instance.currentUser;
const dialog = YYDialog;

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    Column(
      children: [
        Expanded(
          child: FirebaseAnimatedList(
            duration: const Duration(milliseconds: 100),
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
                      fadeInDuration: const Duration(milliseconds: 100),
                      fadeOutDuration: const Duration(milliseconds: 100),
                      placeholder: "assets/images/splash.png",
                      imageCacheHeight: 1000,
                      imageCacheWidth: 1000,
                      image: snapshot.child("img").value.toString()),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          snapshot.child("title").value.toString(),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.only(right: 10.0),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.more_vert,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Text(
                      snapshot.child("desc").value.toString(),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Text(
                      snapshot.child("school").value.toString(),
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Card(
          child: Row(
            children: [
              Container(
                child: const Image(
                  image: AssetImage("assets/images/logo.png"),
                  height: 50,
                  width: 50,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Your Profile",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
              Container(
                alignment: Alignment.center,
                child: PopupMenuButton(
                  icon: const Icon(Icons.more_vert),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      child: Text("Login"),
                      value: 1,
                    ),
                    const PopupMenuItem(
                      child: Text("shabeer"),
                      value: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            children: const [
              Text("Upload"),
            ],
          ),
        )
      ],
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  var yyDialogue = YYDialog();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    YYDialog.init(context);
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
            child: PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(
                  child: Text("Login"),
                  value: 1,
                ),
                const PopupMenuItem(
                  child: Text("Logout"),
                  value: 2,
                ),
                const PopupMenuItem(
                  child: Text("Contact"),
                  value: 3,
                ),
                const PopupMenuItem(
                  child: Text("About"),
                  value: 4,
                )
              ],
              onSelected: (value) {
                value == 1
                    ? {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        )
                      }
                    : value == 2
                        ? {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Logout?")))
                          }
                        : value == 3
                            ? {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Contact?")))
                              }
                            : {
                                yyDialogue.build(context)
                                  ..width = 250
                                  ..height = 250
                                  ..borderRadius = 15
                                  ..widget(
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: [
                                            const Text(
                                              "ABOUT",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blueGrey,
                                                  fontSize: 18),
                                            ),
                                            const SizedBox(
                                              height: 25,
                                            ),
                                            const Text(
                                              "NSS UNIT : MPM / HSE / SFU  58 \n \nDeveloped by \nMuhammed Shabeer OP \n \nvalanchery higher secondary school",
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: ElevatedButton(
                                                onPressed: () {},
                                                child: Row(
                                                  children: const [
                                                    Text("Share"),
                                                    Spacer(),
                                                    Icon(Icons.share)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                  ..show(),
                              };
              },
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: user != null
          ? BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.school),
                  label: 'Profile',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.amber[800],
              onTap: _onItemTapped,
            )
          : null,
    );
  }
}

import 'package:ev_homegrid/navigation%20pages/history_page.dart';
import 'package:ev_homegrid/navigation%20pages/home_page.dart';
import 'package:ev_homegrid/navigation%20pages/ownder_page.dart';
import 'package:ev_homegrid/navigation%20pages/profile_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({ Key? key }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    HomePage(),
    OwnerPage(),
    HistoryPage(),
    ProfilePage()
  ];
  int _currentIndex = 0;
  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color.fromARGB(30, 0, 0, 0),
              blurRadius: 12,
            ),
          ],
        ),
        child: BottomNavigationBar(
          unselectedFontSize: 0,
          selectedFontSize: 0,
          type: BottomNavigationBarType.shifting,
          backgroundColor: Colors.white,
          iconSize: 21,
          onTap: onTap,
          currentIndex: _currentIndex,
          selectedItemColor: Colors.black87,
          unselectedItemColor: Colors.grey.withOpacity(0.5),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          
          items: [
          BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_sharp),label: 'Owner'),
          BottomNavigationBarItem(icon: Icon(Icons.history),label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile')
        ]),
      ),
    );
  }
}
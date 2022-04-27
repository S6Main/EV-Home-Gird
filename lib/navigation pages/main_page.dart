import 'package:ev_homegrid/navigation%20pages/history_page.dart';
import 'package:ev_homegrid/navigation%20pages/home_page.dart';
import 'package:ev_homegrid/navigation%20pages/ownder_page.dart';
import 'package:ev_homegrid/navigation%20pages/profile/profile_page.dart';
import 'package:ev_homegrid/navigation pages/profile/profile_page.dart';
import 'package:flutter/material.dart';


//v2
import '../_v2/_widgets/BottonNavBar.dart';
import '../_v2/componets/globals.dart' as globals;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  List pages = [HomePage(), OwnerPage(), HistoryPage(), ProfilePage()];
  
  static int _currentIndex = 0;
  
  @override
  void initState() {
    super.initState();
    infoPrint();
  }

  void infoPrint(){
    print('is LoggedIn: ${globals.isLoggedIn}');
    print('is Online: ${globals.isOnline}');
  }
  void TapNavBar() {
    setState(() {
      _currentIndex = globals.currentIndex;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: pages[_currentIndex],
        bottomNavigationBar: BottomNavBar(),
        
        // backgroundColor: Colors.white,
        // body: pages[_currentIndex],
        // bottomNavigationBar: Container(
        //   decoration: BoxDecoration(
        //     boxShadow: <BoxShadow>[
        //       BoxShadow(
        //         color: Color.fromARGB(30, 0, 0, 0),
        //         blurRadius: 12,
        //       ),
        //     ],
        //   ),
        //   child: 
          
              // BottomNavigationBar(
              //     unselectedFontSize: 0,
              //     selectedFontSize: 0,
              //     type: BottomNavigationBarType.shifting,
              //     backgroundColor: Colors.white,
              //     iconSize: 25,
              //     onTap: onTap,
              //     currentIndex: _currentIndex,
              //     selectedItemColor: Colors.black,
              //     unselectedItemColor: Colors.black.withOpacity(0.5),
              //     showSelectedLabels: false,
              //     showUnselectedLabels: false,
              //     elevation: 0,
              //     items: [
              //       BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Home'),
              //       BottomNavigationBarItem(
                        
              //           icon: Icon(Icons.bar_chart_sharp), label: 'Owner'),
              //       BottomNavigationBarItem(
              //           icon: Icon(Icons.history), label: 'History'),
              //     ]),
        // ),
      ),
    );
  }
}


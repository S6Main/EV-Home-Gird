import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ev_homegrid/navigation%20pages/history_page.dart';
import 'package:ev_homegrid/navigation%20pages/home_page.dart';
import 'package:ev_homegrid/navigation%20pages/profile/profile_page.dart';

import '../../navigation pages/main_page.dart';
import '../componets/globals.dart' as globals;
import 'package:ev_homegrid/navigation pages/main_page.dart';

class BottomNavBar extends StatefulWidget {
  //from
    Function callback;
    BottomNavBar(this.callback);
  //-

  //const BottomNavBar({Key? key,}) : super(key: key);

  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List pages = [HomePage(),HistoryPage(), ProfilePage()];

  @override
  void initState() {
    super.initState();
  }
  void onTap(int index) {
    setState(() {
      globals.currentIndex = index;
    });
    this.widget.callback(index); //
  }

  

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(left: 15, right: 15,bottom: 15,top: 10),
        //padding: const EdgeInsets.only(left: 12, right: 12,bottom: 15, top: 10),
      child: Container(
          decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color.fromARGB(15, 0, 0, 0),
              blurRadius: 12,
            ),
          ],),
        height: 85,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          child: BottomNavigationBar(
            currentIndex: globals.currentIndex,
            backgroundColor: Colors.white,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            iconSize: 20,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black.withOpacity(0.2),
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/images/Home_v2.png",),),
                label: 'Home',
                backgroundColor: Colors.grey[700],
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/images/Category_v2.png"),),
                label: 'Componets',
                backgroundColor: Colors.grey[700],
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/images/Profile_v2.png"),),
                label: 'Profile',
                backgroundColor: Colors.grey[800],
              ),
            ],
            onTap: onTap
          ),
        ),
      ),
    );
  }
}
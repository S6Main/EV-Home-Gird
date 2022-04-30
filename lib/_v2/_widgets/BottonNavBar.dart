import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ev_homegrid/navigation%20pages/history_page.dart';
import 'package:ev_homegrid/navigation%20pages/home_page.dart';
import 'package:ev_homegrid/navigation%20pages/profile/profile_page.dart';

import '../../navigation pages/main_page.dart';
import '../componets/SlideLeftRoute.dart';
import '../componets/globals.dart' as globals;
import 'package:ev_homegrid/navigation pages/main_page.dart';

import '../stage_0/wallet_page.dart';

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

    if(index == 1 && !globals.isLoggedIn){
      CustomDialogAccessIssue();
    }
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
  void CustomDialogAccessIssue() {
    showDialog(
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.0),
        context: context,
        builder: (BuildContext ctx) {
          return Stack(
            children :<Widget>[

              Container(
              child: BackdropFilter(
                blendMode: BlendMode.srcOver,
                filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                child: Container(
                  color: Color(0xFFC4C4C4).withOpacity(0.5),
                  child: AlertDialog(
                    titlePadding: EdgeInsets.zero,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            32.0,
                          ),
                        ),
                      ),

                    title:  
                    Stack(
                        children: [
                          
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Center(
                                  child: Text('Access denied !',
                                          style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 0, 0, 0)),
                                          )),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(color: Colors.transparent, height: 40,width: 40,
                            child: Stack(
                              children: [
                                Positioned(
                                  right: 0,
                                  child:  Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: new BorderRadius.circular(20.0),
                                    onTap: (() {
                                      Navigator.of(context).pop();
                                    }),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      color: Colors.transparent,
                                      child: Image.asset('assets/images/closeIcon_v2.png')
                                    ),
                                  ),
                                ),)
                              ],
                            ),),)
                        ],
                      ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 20),
                    //   child: Center(
                    //     child: Text('Network Error',
                    //             style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 0, 0, 0)),
                    //             )),
                    // ),
                    content: Builder(
                      builder: (context) {

                        return Container(
                          height: 130,
                          width: 280,
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20,right:20),
                              child: Text('You are not authorized to access this page. Want to sign in ?',textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color: Color.fromARGB(255, 0, 0, 0)),),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 23),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xFFFFFFFF),
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      side: new  BorderSide(color: Colors.black.withOpacity(0.2)), 
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 18,
                                        bottom: 18
                                      ),
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black,
                                          fontFamily: 'Comfortaa',
                                          fontWeight: FontWeight.bold,
                                        ),
                                        ),
                                    ),
                                    ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(context, SlideLeftRoute(page: WalletPage()),);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xFFFEDE00),
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 18,
                                        bottom: 18
                                      ),
                                      child: const Text(
                                        'Sign in',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black,
                                          fontFamily: 'Comfortaa',
                                          fontWeight: FontWeight.bold,
                                        ),
                                        ),
                                    ),
                                    ),
                                
                                ],
                              ),
                            ),
                          ],),
                        );
                      },
                    ),
                    
                  ),
                ),
              ),
            ),

            
            ]);
        });
  }

}
import 'dart:ui';

import 'package:ev_homegrid/main.dart';
import 'package:ev_homegrid/navigation%20pages/history_page.dart';
import 'package:ev_homegrid/navigation%20pages/home_page.dart';
import 'package:ev_homegrid/navigation%20pages/profile/profile_page.dart';
import 'package:ev_homegrid/navigation pages/profile/profile_page.dart';
import 'package:flutter/material.dart';


//v2
import '../_v2/_widgets/BottonNavBar.dart';
import '../_v2/componets/globals.dart' as globals;

GlobalKey _key = GlobalKey();

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  List pages = [HomePage(), HistoryPage(), ProfilePage()];
  final List<Widget> _pages = [HomePage(), HistoryPage(), ProfilePage()];
  late BottomNavBar _bottomNavBar;
  int _currentIndex = 0;
  bool _canShow = false;
  bool? _terms = false;
  
  @override
  void initState() {
    super.initState();
    infoPrint();
    readName();
    _bottomNavBar = BottomNavBar(this.callback);
  }
  void readName(){
    if(globals.isOnline && globals.isLoggedIn && globals.isFirstTime && globals.currentIndex == 0){
      _canShow = true;
    }
  }
  void callback(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  void infoPrint(){
    print('is LoggedIn: ${globals.isLoggedIn}');
    print('is Online: ${globals.isOnline}');
    print('current index : ${globals.currentIndex}');
    print('isFirstTime: ${globals.isFirstTime}');
    print('terms accepted: ${globals.termsAccepted}');
  }
  
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 1000), () => _canShow ? CustomDialogAskName() : null);
    return Material(
      child: Center(
        child: Scaffold(
              resizeToAvoidBottomInset: true,
              //body: pages[_currentIndex],
              bottomNavigationBar: BottomNavBar(this.callback),
              body: IndexedStack(
                index: _currentIndex,
                children: <Widget>[..._pages]
              ),
            ),
      ),
    );
  }
  void CustomDialogAskName() {
    TextEditingController _nameController = new TextEditingController();
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
                  alignment: Alignment.center,
                  color: Color(0xFFC4C4C4).withOpacity(0.5),
                  child: StatefulBuilder(builder: (context, _setState) => AlertDialog(
                      titlePadding: EdgeInsets.zero,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              32.0,
                            ),
                          ),
                        ),

                      title:  Stack(
                        children: [
                          
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Center(
                                  child: Text('About you',
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
                      content: Builder(
                        builder: (context) {

                          return Container(
                            height: 170,
                            width: 280,
                            child: Column(children: [
                              Container(height: 45,
                              decoration: BoxDecoration(
                                  color: Color(0xFFF6F7F6),
                                  borderRadius:  BorderRadius.circular(10),
                                ),
                              child: TextField(
                                maxLength: 42,
                                readOnly: false,
                                controller: _nameController,
                                style: TextStyle(fontSize: 15.5,color: Color.fromARGB(255, 0, 0, 0)),
                                onTap: () async {

                                },
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 15,color: Color(0xFFBFBFBF)),
                            hintText: 'what do we call you ?',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 20,top: 7,bottom: 15),
                            counterText: '',
                          ),
                        ),
                              ),
                              
                              Padding(
                                padding: const EdgeInsets.only(top: 25),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Container(width: 25,height: 25, color: Colors.transparent,
                                      child: Checkbox(
                                              shape:RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(4),
                                                  side: BorderSide(color: Colors.black54)
                                                ),
                                              checkColor: Colors.transparent,
                                              value: _terms,
                                              activeColor: Colors.black,
                                              onChanged: (bool? value) {
                                                _setState(() {
                                                  _terms = value;
                                                });
                                              },
                                            ),
                                      ),
                                    ),
                                    Text('Terms and Conditions',
                                        style: TextStyle(decoration: TextDecoration.underline,
                                          fontSize: 13,fontWeight: FontWeight.normal, color: Color.fromARGB(255, 0, 0, 0)),),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 10, bottom: 10),
                                child: ElevatedButton(
                                  onPressed: _terms! ? () {
                                      setState(() {
                                        globals.isFirstTime = false;
                                        globals.termsAccepted = true;
                                        globals.name = _nameController.text;
                                        _canShow = false;
                                      });
                                      Navigator.of(ctx).pop();
                                  } : null,
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFFFEDE00),
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 50,
                                      right: 50,
                                      top: 18,
                                      bottom: 18
                                    ),
                                    child: const Text(
                                      'Lets start...',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontFamily: 'Comfortaa',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      ),
                                  ),
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
            ),

            

              // Align(
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Container(
              //         width: 330,
              //         height: 40,
              //         child: Row(
              //           children: [
              //             Expanded(child: Container(
              //               color: Colors.transparent,
              //             ),),
              //             Material(
              //               color: Colors.transparent,
              //               child: InkWell(
              //                 borderRadius: new BorderRadius.circular(20.0),
              //                 onTap: (() {
              //                   Navigator.of(context).pop();
              //                 }),
              //                 child: Container(
              //                   width: 40,
              //                   height: 40,
              //                   color: Colors.transparent,
              //                   child: Image.asset('assets/images/closeIcon_v2.png')
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       SizedBox(height: 240),
                    
              //     ],
              //   ),
              // ),
            ]);
        }
        );
        // print('key: ${_key.currentContext!.findRenderObject()}');
        // RenderBox renderBox = _key.currentContext!.findRenderObject()! as RenderBox;
        // Offset position = renderBox.localToGlobal(Offset.zero);
        // print('postion is $position');

  }
}


import 'dart:ui';

import 'package:ev_homegrid/constants.dart';
import 'package:flutter/material.dart';
import 'package:ev_homegrid/_v2/componets/globals.dart' as globals;
import 'package:flutter/rendering.dart';

import '../componets/SlideLeftRoute.dart';
import '../stage_0/wallet_page.dart';
import 'package:expansion_widget/expansion_widget.dart';
import 'dart:math' as math;
import 'package:styled_text/styled_text.dart';

import '../web3dart/ethereum_utils.dart';



class HistoryPage extends StatefulWidget {

  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> with TickerProviderStateMixin{
  int _index = 0;
  Color _selected = Colors.black;
  Color _selectedBlue = Color(0xFF0AB0BD);
  Color _unSelected = Colors.black.withOpacity(0.3);

  String _text = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Leo sed aliquam diam ullamcorper elementum. Nisi, consequat amet enim quam lacus, curabitur nisi libero, vehicula. Placerat malesuada ut sit.';

  String _text2 = 'Amazing, very interesting novel by Sara Taylor. Must read for everyone!';
  String _text3 = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Leo sed aliquam diam ullamcorper elementum. Nisi, consequat amet enim quam lacus, curabitur nisi libero, vehicula. Placerat malesuada ut sit.';

  late final _tabController = new TabController(vsync: this, length: 3);
  EthereumUtils ethUtils = EthereumUtils(); //web3dart
  List<Widget> _notifications = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _notifications.add(NotificationCard(text: _text2),);
    // addNotifications();
    ethUtils.initial(); //web3dart
    getNotificationDetails();
  }

  void getNotificationDetails(){
    String title = '';
    String address = '';
    String text = '';
    ethUtils.getNotifications(globals.publicKey).then((value) {
      if(value[0].length > 0){
        for(int i  = 0; i < value[0].length; i++){
          title = value[0][i];
          address = value[1][i];
          text = value[2][i];
          addNotifications(title, address, text);
        }
      }
    });
  }
  

  void addNotifications(String _title, String _address, String _text){

    _address = _address.substring(0, 6) + '...' + _address.substring(_address.length - 4, _address.length);
    _notifications.add(NotificationCard(title: _title, address: _address, text: _text));
    setState(() {
      
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25, top: 50),
        height: double.infinity,
        width: double.infinity,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child:Container(
              color: Colors.transparent,
              child: TabBarView(
                controller: _tabController,
                children: [
                  new SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    // child: Text('History', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal,color: Colors.black),),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        HistoryCard(text: _text),
                        HistoryCard(text: _text),
                        HistoryCard(text: _text),
                        HistoryCard(text: _text),
                        HistoryCard(text: _text),
                        HistoryCard(text: _text),
                        HistoryCard(text: _text),
                      ],
                    )
                  ),
                  Container(
                    child: Stack(
                      children: [
                        Visibility(
                          visible: _notifications.length < 1,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            alignment: Alignment.center,
                            child: Text('empty', style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal,color: Colors.black.withOpacity(0.1)),)),
                        ),
                        
                        new SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            // child: Text('History', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal,color: Colors.black),),
                            child:
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: _notifications,
                                  //  [
                                  //   NotificationCard(text: _text2),
                                  //   NotificationCard(text: _text2),
                                  //   NotificationCard(text: _text2),
                                  //   NotificationCard(text: _text2),
                                  //   NotificationCard(text: _text2),
                                  // ],
                                ),
                          ),
                      ],
                    ),
                  ),
                  new SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    // child: Text('Favorite', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal,color: Colors.black),),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FavouriteCard(text3: _text3),
                        FavouriteCard(text3: _text3),
                        FavouriteCard(text3: _text3),
                      ]
                    ),
                  ),
                ]
              )
            )
            ),
            SizedBox(height: 20,width: double.infinity,),
            Container(
              height: 40,
              width: double.infinity,
              color: Colors.transparent,
              child: 
              Container(
                padding: EdgeInsets.only(left: 25, right: 25),
                color: Colors.transparent,
                width: double.infinity,
                height :40,
                child: TabBar(
                  controller: _tabController,
                  indicatorWeight: 2.5,
                  indicatorColor: _selectedBlue,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: _selected,
                  unselectedLabelColor: _unSelected,
                  labelPadding: EdgeInsets.only(left: 2,right: 2),
                  labelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,),
                  tabs:const <Widget> [
                    Tab(
                      text: 'History',
                    ),
                    Tab(
                      text: 'Notifications',
                    ),
                    Tab(
                      text: 'Favourite',
                    ),
                  ],
              ),
              ),
              
            )
          ],
        ),
      ),
      );
  }
}

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    Key? key,
    required String text,
  }) : _text = text, super(key: key);

  final String _text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20  ),),
        color: Color(0xFFFFFFFF),
        shadowColor: Colors.black.withOpacity(0.1),
        elevation: 2,
        child: ExpansionWidget(
            initiallyExpanded: false,
            titleBuilder:
                (double animationValue, _, bool isExpaned, toogleFunction) {
              return InkWell(
                radius: 150,
                borderRadius: BorderRadius.circular(20),
                splashColor: Color(0xFF0D99FF).withOpacity(0.1),
                  onTap: () => toogleFunction(animated: true),
                  child: Container(
                      width: double.infinity,
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        Container(
                          padding: EdgeInsets.all(15),
                          width: 100,
                          height: 100,
                          child: Container(
                              alignment: Alignment.center,
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black.withOpacity(0.2),
                              ),
                            ),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.transparent,
                            height: 100,
                            child: Stack(
                                children: [
                                  Positioned(
                                    top: 15,
                                    child: Text('0.086 ETH', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700,color: Color(0xFF2B2D41)),)),
                                  Positioned(
                                    top: 35,
                                    child: Text('Omar Torff', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700,color: Color(0xFFE5E6EB)),)),
                                  Positioned(
                                    bottom: 15,
                                    child: Text('0xB.00000..b8', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700,color: Color(0xFFE5E6EB)),),
                                  ),
                                ],
                            ),
                        ),),
                        Container(
                          alignment: Alignment.bottomRight,
                          padding: EdgeInsets.only(right: 35,bottom: 15),
                          child: Text('07:30 am', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800,color: Color(0xFFE5E6EB)),),
                        )
                      ]),
                      )
                  );
            },
            content: Container(
                      padding: EdgeInsets.only(top: 10, bottom: 15),
                      width: double.infinity,
                      height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 35,
                            width: double.infinity,
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 18,),
                                Container(
                                  width: 70,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.transparent,
                                    border: Border.all(color: Color(0xFF2A2A2A).withOpacity(0.25), width: 1.2),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(width: 2,),
                                      Icon(Icons.star, color: Color(0xFFFFE033), size: 25,),
                                      Text('4.3', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.black.withOpacity(0.5)),),
                                      SizedBox(width: 2,),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 15,),
                                Container(
                                  width: 70,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.transparent,
                                    border: Border.all(color: Color(0xFF2A2A2A).withOpacity(0.25), width: 1.2),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('\$0.99', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.black.withOpacity(0.5)),),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 5,),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(bottom: 15,left: 20,right: 20),
                              child: Text(_text, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300,color: Colors.black.withOpacity(0.2)),),
                            )
                          )
                        ],
                      )
                      )
            ),
      ),
    );
  }
}

class NotificationCard extends StatefulWidget {
  const NotificationCard({
    Key? key,
     required this.title, required this.address,required this.text,
  }) :super(key: key);

  final String address;
  final String title;
  final String text;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
   bool isExpanded = false;
   bool _menuIcon = false;
   bool _menuVisible = false;
   bool _isCardTapable = true;
   bool _isOpened = false;

   Color _unopenedColor = Color(0xFF000000);
    Color _openedColor = Color(0xFF000000).withOpacity(0.4);
  
  void _onTap(){
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),),
        color: Color(0xFFFFFFFF),
        shadowColor: Colors.black.withOpacity(0.1),
        elevation: 2,
        child: Stack(
          children: [
            
            AbsorbPointer(
              absorbing: !_isCardTapable,
              child: ExpansionWidget(
                  initiallyExpanded: false,
                  onExpansionChanged: (isExpanded) {
                    if(_isOpened == false && isExpanded == true){
                      _isOpened = true;
                    }
                    isExpanded = !isExpanded;
                    _menuIcon = !_menuIcon;
                    _onTap();
                  },
                  titleBuilder:
                      (double animationValue, _, bool isExpaned, toogleFunction) {
                    return InkWell(
                      radius: 150,
                      borderRadius: BorderRadius.circular(20),
                      splashColor: Color(0xFF0D99FF).withOpacity(0.1),
                        onTap: () => toogleFunction(animated: true),
                        child: 
                            
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 25, right: 20, top: 30, bottom: 30),
                                width: double.infinity,
                                height: 110,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                      color: Colors.transparent,
                                      width: double.infinity,
                                      height: 60,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: 5,
                                            left: 5,
                                            child: Text(widget.title,style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600,
                                            color: _isOpened ? _openedColor : _unopenedColor 
                                            ))),
                                          Positioned(
                                            top: 35,
                                            left: 5,
                                            child: Text(widget.address,style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300,color: Colors.black.withOpacity(0.6))))
                                        ],
                                      ),
                                    )
                                  
                                  
                                ),
                          
                        );
                  },
                  content: Container(
                            padding: EdgeInsets.only( bottom: 15,left: 25, right: 25),
                            width: double.infinity,
                            height: 80,
                            color: Colors.transparent,
                            child: Text(widget.text, style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.4)),),
                            )
                  ),
            ),
                SizedBox(
              width: double.infinity,
              height: 120,
              child: Stack(children: [
                Visibility(
                            visible: _menuIcon,
                            child: Positioned(
                              right: 0,
                              top: 0,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  print('tapped on menu');
                                  _menuVisible = !_menuVisible;
                                  _menuIcon = !_menuIcon;
                                  _isCardTapable = false;
                                  _onTap();
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  color: Colors.transparent,
                                  child: Image.asset('assets/images/menuIcon_v2.png')
                                  ),
                              ),
                            ),
                          ),
                Visibility(
                            visible: _menuVisible,
                            child: Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                width: 120,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xFF000000).withOpacity(0.1),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      offset: Offset(0.0, 0.0), //(x,y)
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 39,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight:Radius.circular(20)),
                                            color: Colors.white
                                          ),
                                          // child:  Center(child: Text('remove', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,color: Color(0xFF2B2D41)),)),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              _menuIcon = !_menuIcon;
                                              _menuVisible = !_menuVisible;
                                              _isCardTapable = true;
                                              _onTap();
                                              print('tapped on remove');
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.white,
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight:Radius.circular(20)),
                                              ),
                                            ),
                                            child: Text('Remove', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,color: Color(0xFF2B2D41)),),
                                          ),
                                        ),
                                        Container(height: 2,
                                        color: Colors.white,
                                        padding: EdgeInsets.only(left: 10, right: 10),
                                          child: Divider(
                                            color: Color(0xFF2A2A2A).withOpacity(0.1),
                                            thickness: 1,
                                            height: 10,
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 39,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight:Radius.circular(20)),
                                            color: Colors.white
                                          ),
                                          // child:Center(child: Text('mark unread', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,color: Color(0xFF2B2D41)),)),
                                          child: ElevatedButton(
                                            onPressed: () {
                                               _menuIcon = !_menuIcon;
                                              _menuVisible = !_menuVisible;
                                              _isCardTapable = true;
                                              _isOpened = false;
                                              _onTap();
                                              print('tapped on mark unread');
                                            },

                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.white,
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:  BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight:Radius.circular(20)),
                                              
                                              ),
                                            ),
                                            child: Text('mark unread', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,color: Color(0xFF2B2D41)),),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
              ],)
            ),
          ],
        ),
            ),
      
    );
  }
}

class FavouriteCard extends StatefulWidget {
  const FavouriteCard({
    Key? key,
    required String text3,
  }) : text3 = text3, super(key: key);

  final String text3;

  @override
  State<FavouriteCard> createState() => _FavouriteCardState();
}

class _FavouriteCardState extends State<FavouriteCard> {
  bool isExpanded = false;
  bool isFavorite = true;
  Color redColor = Color(0xFFE61800);
  Color greyColor = Color(0xFFAFAFAF);
   
  void _onTap(){
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),),
        color: Color(0xFFFFFFFF),
        shadowColor: Colors.black.withOpacity(0.1),
        elevation: 2,
        child: Stack(
          children: [
            AbsorbPointer(
              absorbing: false,
              child: ExpansionWidget(
                  initiallyExpanded: false,
                  onExpansionChanged: (isExpanded) {
                    isExpanded = !isExpanded;
                    _onTap();
                  },
                  titleBuilder:
                      (double animationValue, _, bool isExpaned, toogleFunction) {
                    return InkWell(
                      radius: 150,
                      borderRadius: BorderRadius.circular(20),
                      splashColor: Color(0xFF0D99FF).withOpacity(0.1),
                        onTap: () => toogleFunction(animated: true),
                        child: 
                            
                            Container(
                              alignment: Alignment.centerLeft,
                                width: double.infinity,
                                height: 150,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                      color: Colors.transparent,
                                      width: double.infinity,
                                      height: 150,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            child: Container(alignment: Alignment.center,
                                            color: Colors.transparent,
                                            width: 150,
                                            height: 150,
                                            child: Container(
                                              width: 120,
                                              height: 120,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(16),
                                                color: Colors.black12,
                                              ),
                                            ),
                                            )
                                            ),
                                         Padding(
                                           padding: const EdgeInsets.only(left: 160,top: 15, bottom: 15,right: 15),
                                           child: Container(
                                             width: double.infinity,
                                             height: double.infinity,
                                             color: Colors.transparent,
                                              child: Stack(
                                                children: [
                                                  Text('Street', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900,color: Color(0xFFB6E13D)),),
                                                  Positioned(
                                                    top: 30,
                                                    child:StyledText(
                                                      text: '<title>3 Birrel\nAvenue </title>',
                                                      tags: {
                                                        'title':StyledTextTag(
                                                              style:TextStyle(fontWeight: FontWeight.w900, fontSize: 35, color: Colors.black,height: 0.8),)
                                                      },
                                                      ),),
                                                  Positioned(
                                                    bottom: 0,
                                                    left: 0,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          child: Icon(Icons.location_on, color: Color(0xFFB6E13D),size: 20,),
                                                        ),
                                                        Text('10 Mtr Left', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500,color: Color(0xFFBDBDBD),wordSpacing: 0.2),),
                                                      ],
                                                    )
                                                  )
                                                ],
                                              )
                                           ),
                                         )
                                        ],
                                      ),
                                    )
                                  
                                  
                                ),
                          
                        );
                  },
                  content: Container(
                      padding: EdgeInsets.only(top: 10, bottom: 15),
                      width: double.infinity,
                      height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 35,
                            width: double.infinity,
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 18,),
                                Container(
                                  width: 70,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.transparent,
                                    border: Border.all(color: Color(0xFF2A2A2A).withOpacity(0.25), width: 1.2),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(width: 2,),
                                      Icon(Icons.star, color: Color(0xFFFFE033), size: 25,),
                                      Text('4.3', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.black.withOpacity(0.5)),),
                                      SizedBox(width: 2,),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 15,),
                                Container(
                                  width: 70,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.transparent,
                                    border: Border.all(color: Color(0xFF2A2A2A).withOpacity(0.25), width: 1.2),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('\$0.99', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.black.withOpacity(0.5)),),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 5,),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(bottom: 15,left: 20,right: 20),
                              child: Text(widget.text3, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300,color: Colors.black.withOpacity(0.2)),),
                            )
                          )
                        ],
                      )
                      )
                  ),
            ),
            Positioned(
              right: 20,
              top: 15,
              child: Container(
                width: 30,
                height: 30,
                child: IconButton(icon:  Icon(Icons.favorite,
                  color: isFavorite ? redColor : greyColor,
                  size: 25,),
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },),
                ),
              ),   
          ],
        ),
            ),
      
    );
  }
}


 
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ev_homegrid/_v2/componets/globals.dart' as globals;

import '../_v2/componets/SlideLeftRoute.dart';
import '../_v2/stage_0/wallet_page.dart';

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

  late final _tabController = new TabController(vsync: this, length: 3);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
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
              color: Colors.white,
              child: TabBarView(
                controller: _tabController,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text('History', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal,color: Colors.black),),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text('Notifications', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal,color: Colors.black),),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text('Favorite', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal,color: Colors.black),),
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
                      text: 'Favorite',
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
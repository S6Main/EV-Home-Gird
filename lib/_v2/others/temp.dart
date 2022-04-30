// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:ev_homegrid/_v2/componets/globals.dart' as globals;

// import '../_v2/componets/SlideLeftRoute.dart';
// import '../_v2/stage_0/wallet_page.dart';

// class HistoryPage extends StatefulWidget {

//   const HistoryPage({Key? key}) : super(key: key);

//   @override
//   State<HistoryPage> createState() => _HistoryPageState();
// }

// class _HistoryPageState extends State<HistoryPage> {
//   int _index = 0;
//   Color _selected = Colors.black;
//   Color _selectedBlue = Color(0xFF0AB0BD);
//   Color _unSelected = Colors.black.withOpacity(0.3);
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         alignment: Alignment.center,
//         child: Container(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               SizedBox(
//                 height: 10,
//               ),
//               Container(
//                 child: Container(
//                   width: double.infinity,
//                   height: 600,
//                   color: Colors.blueAccent,
//                 ),
//               ),
              
//               Container(
//                 padding: EdgeInsets.only(left: 50, right: 50),
//                 color: Colors.transparent,
//                 width: double.infinity,
//                 height :40,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.only(top: 7),
//                       alignment: Alignment.bottomCenter,
//                       width: 100,
//                       height: 40,
//                       child: Column(
//                         children: [
//                           Text('History', style: TextStyle(color: (_index == 0) ? _selected: _unSelected, 
//                           fontSize: 16,fontWeight: FontWeight.w600,),textAlign: TextAlign.center,),
//                           Padding(
//                             padding: const EdgeInsets.only(left:35,right: 35),
//                             child: Divider(
//                               thickness: 2.5,
//                             color: (_index == 0) ? _selectedBlue: _unSelected, 
//                         ),
//                           )

//                         ],
//                       ),
//                     ),

//                     Container(
//                       padding: EdgeInsets.only(top: 7),
//                       alignment: Alignment.center,
//                       color: Colors.transparent,
//                       width: 100,
//                       height: 40,
//                       child: Column(
//                         children: [
//                           Text('Notifications', style: TextStyle(color: (_index == 1) ? _selected: _unSelected, 
//                           fontSize: 16,fontWeight: FontWeight.w600,),textAlign: TextAlign.center,),
//                           Padding(
//                             padding: const EdgeInsets.only(left:35,right: 35),
//                             child: Divider(
//                               thickness: 2.5,
//                             color: (_index == 1) ? _selectedBlue: _unSelected, 
//                         ),
//                           )

//                         ],
//                       ),
//                     ),

//                     Container(
//                       padding: EdgeInsets.only(top: 7),
//                       alignment: Alignment.center,
//                       color: Colors.transparent,
//                       width: 100,
//                       height: 40,
//                       child: Column(
//                         children: [
//                           Text('Favorite', style: TextStyle(color: (_index == 2) ? _selected: _unSelected, 
//                           fontSize: 16,fontWeight: FontWeight.w600,),textAlign: TextAlign.center,),
//                           Padding(
//                             padding: const EdgeInsets.only(left:35,right: 35),
//                             child: Divider(
//                               thickness: 2.5,
//                             color: (_index ==2) ? _selectedBlue: _unSelected, 
//                         ),
//                           )

//                         ],
//                       ),
//                     ),
                    
                    
//                   ],
//                 ),
//               )
//             ],
//           ),
//         )
//       ),
//       );
//   }
//   }
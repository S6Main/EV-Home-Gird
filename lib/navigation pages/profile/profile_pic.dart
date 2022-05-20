import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ev_homegrid/components/custom_profilepic_button.dart';
import '../../_v2/componets/globals.dart' as globals;

class ProfilePic extends StatefulWidget {
  const ProfilePic({Key? key}) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  late AssetImage _imageToShow;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imageToShow = AssetImage('assets/images/profiles_V2/Sample-0.png');
    startTimer();
    
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: MediaQuery.of(context).size.height * .144,
        width: MediaQuery.of(context).size.height * .15,
        decoration: BoxDecoration(
          // color: Colors.red,
          border: Border.all(
            width: 4.0,
            color: Colors.white,
          ),
          boxShadow: [
            BoxShadow(
              spreadRadius: 2.0,
              blurRadius: 5.0,
              color: Colors.blue.withOpacity(0.1),
            ),
          ],
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          backgroundImage: _imageToShow,
          // backgroundImage: AssetImage('assets/images/profiles_V2/Sample-0.png'),
          backgroundColor: Color.fromARGB(255, 233, 233, 233),
          // radius: 60.0,
        ),
      ),
    ]);
  }
  void startTimer() {
    print('started timer');
    Duration sec = Duration(seconds: 5);
    Timer.periodic(sec, (timer) {
      if(globals.userProfile != -1){
        timer.cancel();
        print('cancelled timer');
        updateImage();
      }
    });
  }
  void updateImage() {
    setState ((){ 
          _imageToShow = new AssetImage('assets/images/profiles_V2/Sample-${globals.userProfile}.png');
      });
  } 
}

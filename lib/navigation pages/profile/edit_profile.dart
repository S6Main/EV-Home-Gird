import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ev_homegrid/constants.dart';
import 'profile_pic.dart';
import 'package:ev_homegrid/components/custom_profilepic_button.dart';
import 'package:ev_homegrid/components/custom_card.dart';
import 'vehicle/my_vehicle.dart';
import '../../_v2/componets/globals.dart' as globals;


class EditUserProfile extends StatefulWidget {
  const EditUserProfile({Key? key}) : super(key: key);

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {

  String _name = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
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
          _name = globals.userName;
      });
  } 
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: Column(
        children: [
          Column(
            children: [
              ProfilePic(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
            ],
          ),
          SizedBox(
            // padding:
            //     EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
            // color: Colors.red,
            height: MediaQuery.of(context).size.height * .085,
            width: MediaQuery.of(context).size.height * 1,
            child: Stack(
              // overflow: Overflow.visible,
              fit: StackFit.expand,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Text(_name, style: kProfileSubtitleStyle),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * .0095,
                    // ),
                    // Text(
                    //   'email@gmail.com',
                    //   style: kProfileSubtitleStyle,
                    // ),
                  ],
                ),
                
              ],
            ),
          ),
          Container(
            // color: Colors.amber,
            height: MediaQuery.of(context).size.height * 0.46,
            width: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.01,
              horizontal: 20.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomCard(
                  leadingIconData: Icons.electric_moped,
                  cardTitle: 'My Vehicle',
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyVehicle()));
                  },
                ),
                CustomCard(
                  leadingIconData: Icons.favorite_rounded,
                  cardTitle: 'My Favorites',
                  onPressed: () {},
                ),
                CustomCard(
                  leadingIconData: Icons.help_rounded,
                  cardTitle: 'Help & Support',
                  onPressed: () {},
                ),
                CustomCard(
                  leadingIconData: Icons.info_rounded,
                  cardTitle: 'About',
                  onPressed: () {},
                ),
                // CustomCard(
                //   leadingIconData: Icons.handshake_rounded,
                //   cardTitle: 'Connect With us',
                //   onPressed: () {},
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.080,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    elevation: 1.0,
                    color: Color(0xFFF5F6F9),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
                      // leading:
                      title: Text(
                        'Connect With Us',
                        textAlign: TextAlign.justify,
                        style: kCardTitleTextStyle,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.facebook_rounded,
                            size: 28.0,
                          ),
                          Icon(
                            Icons.facebook_rounded,
                            size: 28.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(
          //   height: MediaQuery.of(context).size.height * .02,
          // ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                // color: Colors.red,
                height: MediaQuery.of(context).size.height * 0.05,
                // width: MediaQuery.of(context).size.width,
                width: double.infinity,

                child: Align(
                  // alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      height: 55.0,
                      width: 220.0,
                      decoration: BoxDecoration(
                        color: kThemeColor,
                        borderRadius:
                            BorderRadius.circular(kBorderCircleRadius),
                      ),
                      child: Text(
                        'Log out',
                        style: kButtonTextStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

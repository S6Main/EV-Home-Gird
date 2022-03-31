import 'package:flutter/material.dart';
import 'package:ev_homegrid/constants.dart';
import 'profile_pic.dart';
import 'package:ev_homegrid/components/custom_profilepic_button.dart';
import 'package:ev_homegrid/components/custom_card.dart';
import 'my_vehicle.dart';

class EditUserProfile extends StatefulWidget {
  const EditUserProfile({Key? key}) : super(key: key);

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                  Text('Name', style: kProfileSubtitleStyle),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .0095,
                  ),
                  Text(
                    'email@gmail.com',
                    style: kProfileSubtitleStyle,
                  ),
                ],
              ),
              Positioned(
                child: CustomProfilePicButton(
                  iconData: Icons.edit,
                  onPressed: () {},
                ),
                bottom: 12, //to move down, decrease the value.
                right: 30,
              )
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
              CustomCard(
                leadingIconData: Icons.handshake_rounded,
                cardTitle: 'Connect With us',
                onPressed: () {},
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
              // color: Colors.red,
              // margin: EdgeInsets.only(
              //     bottom: MediaQuery.of(context).size.height * 0.001),
              child: Align(
                // alignment: Alignment.bottomCenter,
                child: RawMaterialButton(
                  constraints: BoxConstraints.tightFor(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * .06),
                  elevation: 6.0,
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginPage()),
                    // );
                  },
                  fillColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    // side: BorderSide(color: Colors.black),

                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

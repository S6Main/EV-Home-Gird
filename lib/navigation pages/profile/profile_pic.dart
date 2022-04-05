import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ev_homegrid/components/custom_profilepic_button.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({Key? key}) : super(key: key);

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
          backgroundImage: AssetImage('assets/images/femaleAvatar.png'),
          backgroundColor: Colors.blue,
          // radius: 60.0,
        ),
      ),
      Positioned(
        bottom: 10,
        right: 0,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.height * 0.05,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 4.0,
              color: Colors.white,
            ),
          ),
          child: CustomProfilePicButton(
            iconData: FontAwesomeIcons.camera,
            onPressed: () {}, //TODO: implement onPressed;
          ),
        ),
      )
    ]);
  }
}

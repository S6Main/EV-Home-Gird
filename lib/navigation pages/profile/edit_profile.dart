import 'package:ev_homegrid/navigation%20pages/profile/sample_avatar.dart';
import 'package:flutter/material.dart';
import 'package:ev_homegrid/constants.dart';
import 'package:flutter/rendering.dart';
import 'profile_pic.dart';
import 'package:ev_homegrid/components/custom_profilepic_button.dart';
import 'package:ev_homegrid/components/custom_card.dart';
import 'vehicle/my_vehicle.dart';
import 'ev_owner/owner_page.dart';

class EditUserProfile extends StatefulWidget {
  const EditUserProfile({Key? key}) : super(key: key);

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  var myList = [
    "assets/images/avtar.png",
    "assets/images/avtar2.jpg",
    "assets/images/avtar3.jpg",
    "assets/images/avtar4.jpg",
    "assets/images/avtar5.jpg",
    "assets/images/avtar1.jpg",
    "assets/images/avtar8.jpg",
    "assets/images/avtar9.jpg"
  ];

  String image_url = 'assets/images/avtar.png';
  bool hide_list = false;

  void changeProfilePicture(new_url) {
    setState(() {
      image_url = new_url;
    });
  }

  void changeAvatarListVisibility() {
    setState(() {
      hide_list = !hide_list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: [
            InkWell(
              child: ProfilePic(image_url: image_url),
              onTap: () {
                changeAvatarListVisibility();
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),
            SizedBox(
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
                      Text('Name', style: kProfileSubtitleStyle),
                    ],
                  ),
                  Positioned(
                    child: CustomProfilePicButton(
                      iconData: Icons.edit,
                      onPressed: () {},
                    ),
                    bottom: 20, //to move down, decrease the value.
                    right: 30,
                  ),
                ],
              ),
            ),
            if (hide_list)
              Container(
                margin: EdgeInsets.all(10.0),
                height: 70.0,
                child: ListView.separated(
                  itemCount: 8,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 10,
                    );
                  },
                  itemBuilder: (_, i) => InkWell(
                    child: SampleAvatar(
                      image_url: myList[i],
                    ),
                    onTap: () {
                      changeProfilePicture(myList[i]);
                      changeAvatarListVisibility();
                    },
                  ),
                  scrollDirection: Axis.horizontal,
                ),
              ),
            Container(
              // color: Colors.amber,
              height: MediaQuery.of(context).size.height * 0.36,
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
                    leadingIconData: Icons.person_rounded,
                    cardTitle: 'Owner Page',
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => OwnerInfo()));
                    },
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
                              Icons.whatsapp_rounded,
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
            Padding(
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
          ],
        ),
      ),
    );
  }
}

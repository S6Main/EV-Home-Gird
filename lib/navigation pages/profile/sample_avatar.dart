import 'package:flutter/material.dart';

class SampleAvatar extends StatelessWidget {
  final String image_url;

  SampleAvatar({
    this.image_url = 'assets/images/femaleAvatar.png',
  });

  Widget build(BuildContext context) {
    return Container(
      width: 70.0,
      height: 70.0,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
      child: CircleAvatar(
        backgroundImage: AssetImage(this.image_url),
      ),
    );
  }
}

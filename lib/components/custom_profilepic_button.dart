// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:ev_homegrid/constants.dart';

class CustomProfilePicButton extends StatelessWidget {
  const CustomProfilePicButton(
      {required this.iconData, required this.onPressed});

  final IconData iconData;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 0,
      fillColor: kThemeColor,
      shape: CircleBorder(),
      child: Icon(iconData, size: 15.0, color: Colors.black),
      onPressed: onPressed,
      constraints: BoxConstraints.tightFor(width: 25.0, height: 25.0),
    );
  }
}

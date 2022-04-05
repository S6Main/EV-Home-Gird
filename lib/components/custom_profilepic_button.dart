// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class CustomProfilePicButton extends StatelessWidget {
  const CustomProfilePicButton(
      {required this.iconData, required this.onPressed});

  final IconData iconData;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 1.0,
      fillColor: Colors.blue,
      shape: CircleBorder(),
      child: Icon(iconData, size: 15.0, color: Colors.black),
      onPressed: onPressed,
      constraints: BoxConstraints.tightFor(width: 25.0, height: 25.0),
    );
  }
}

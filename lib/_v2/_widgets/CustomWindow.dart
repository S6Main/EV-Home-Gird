import 'package:flutter/material.dart';

class CustomWindow extends StatelessWidget {
  const CustomWindow({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: 100,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(4),
            ),)
        ),
      ],
    );
  }
}
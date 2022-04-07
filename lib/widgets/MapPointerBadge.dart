
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import  'package:ev_homegrid/globals.dart';

class MapPointerBadge extends StatelessWidget {

  bool isSelected  = false;

  MapPointerBadge({ required this.isSelected });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      decoration: BoxDecoration(
        color: this.isSelected ? Globals.MAIN_COLOR :Colors.white,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset.zero,
          )
        ]
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(image: AssetImage('assets/images/avatar.png'),
                 fit: BoxFit.cover
                 ),
                 border: Border.all(
                   color: this.isSelected ? Colors.white :Globals.MAIN_COLOR,
                   width: 1
                 )
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Roman Jaquez',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: this.isSelected ? Colors.white :Colors.grey,
                  ),
                ),
                Text('Mi location',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: this.isSelected ? Colors.white :Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.my_location,
            color: this.isSelected ? Colors.white :Globals.MAIN_COLOR,
            size: 40,)
        ],
      ),
      );
  }
}


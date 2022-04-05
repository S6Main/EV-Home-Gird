import 'package:flutter/material.dart';
import 'package:ev_homegrid/constants.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {Key? key,
      this.leadingIconData,
      required this.cardTitle,
      required this.onPressed})
      : super(key: key);

  final IconData? leadingIconData;
  final String cardTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.amberAccent,
      height: MediaQuery.of(context).size.height * 0.080,
      child: Card(
        color: Color(0xFFF5F6F9),
        child: ListTile(
          leading: Icon(
            leadingIconData,
            size: 30.0,
            // color: Colors.blueGrey.shade700,
          ),
          title: Text(
            cardTitle,
            textAlign: TextAlign.justify,
            style: kCardTitleTextStyle,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 25.0,
            ),
            onPressed: onPressed,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}

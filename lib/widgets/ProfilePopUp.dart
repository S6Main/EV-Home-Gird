import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../navigation pages/main_page.dart';

Widget BuildPopupDialog(BuildContext context) {
  return AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))),
    contentPadding: EdgeInsets.only(top: 10.0),
    content: Container(
      width: 300.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Nick Name :",
                style: TextStyle(fontSize: 18.0),
              ),
              Row(children: <Widget>[
                Text("Roman Jaquez", style: TextStyle(fontSize: 16.0)),
              ])
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Divider(
            color: Colors.grey,
            height: 4.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Wallet Address :", style: TextStyle(fontSize: 18.0)),
              Row(children: <Widget>[
                Text("d148aseb", style: TextStyle(fontSize: 16.0)),
              ])
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Divider(
            color: Colors.grey,
            height: 4.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Vehicle Type :",
                style: TextStyle(fontSize: 18.0),
              ),
              Row(children: <Widget>[
                Text("EV", style: TextStyle(fontSize: 16.0)),
              ])
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          InkWell(
            onTap: () {
              // showDialog(
              //   context: context,
              //   //builder: (BuildContext context) => MainPage(),
              // );
              Navigator.of(context).pop();
            },
            child: Container(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: Text(
                "Close",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

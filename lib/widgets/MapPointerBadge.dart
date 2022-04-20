// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ev_homegrid/globals.dart';
import '../navigation pages/main_page.dart';
import 'SrcDestPg.dart';

class MapPointerBadge extends StatelessWidget {
  bool isSelected = false;

  MapPointerBadge({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      decoration: BoxDecoration(
          color: this.isSelected ? Globals.MAIN_COLOR : Colors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset.zero,
            )
          ]),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => _buildPopupDialog(context),
              );
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                    image: AssetImage('assets/images/avatar.png'),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                      color:
                          this.isSelected ? Colors.white : Globals.MAIN_COLOR,
                      width: 1)),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Roman Jaquez',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: this.isSelected ? Colors.white : Colors.grey,
                  ),
                ),
                Text(
                  'Mi location',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: this.isSelected ? Colors.white : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: new Icon(Icons.search_rounded, size: 40),
            color: this.isSelected ? Colors.white : Globals.MAIN_COLOR,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SrcDestpg()),
              );
            },
          )
        ],
      ),
    );
  }
}

//Popup Dialog Box
Widget _buildPopupDialog(BuildContext context) {
  return AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0))),
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
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32.0),
                    bottomRight: Radius.circular(32.0)),
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

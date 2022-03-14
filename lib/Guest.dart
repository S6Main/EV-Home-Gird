import 'package:flutter/material.dart';


class Guest extends StatefulWidget {
  Guest({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _GuestState createState() => _GuestState();
}

class _GuestState extends State<Guest> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MetaMask'),
        ),
        body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 500,
                ),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: Text(
                    "MetaMask: This Page for BlockChain",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),),
              ],
            )));
  }
}
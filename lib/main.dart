import 'package:flutter/material.dart';
import 'Guest.dart';
import 'MetaMask.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EV Home Grid',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //MyHomePage({Key key, this.title}) : super(key: key);
  //final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('EV Home Grid'),
      ),*/
      body: Center(
      child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
      SizedBox(
        height: 550,
      ),
      SizedBox(
      width: 330,
      height: 40,
      child: ElevatedButton.icon(
          icon: Icon(
            Icons.format_textdirection_l_to_r,
            color: Colors.black,
            size: 30.0,
          ),
          label: Text('METAMASK'),
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 255, 255, 255),
              onPrimary: Color.fromARGB(255, 0, 0, 0),
              shadowColor: Color.fromARGB(68, 0, 0, 0),
              side: BorderSide(width: 1.5, color: Color.fromARGB(75, 0, 0, 0)),
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              minimumSize: Size(100, 40), //////// HERE
            ),
            onPressed: () {},
          )
    ),
    SizedBox(
      height: 16,
    ),
    SizedBox(
      width: 330,
      height: 40,
      child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
              onPrimary: Colors.white,
              shadowColor: Color.fromARGB(255, 65, 65, 65),
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              minimumSize: Size(100, 40), //////// HERE
            ),
            onPressed: () {
              //code on press
            },
            child: Text('GUEST'),
          )
      ,),
    ],)));
  }
}

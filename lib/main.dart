import 'package:ev_homegrid/icons/custom_icon.dart';
import 'package:ev_homegrid/navigation%20pages/home_page.dart';
import 'package:flutter/material.dart';
import 'Guest.dart';
import 'MetaMask.dart';
import 'navigation pages/main_page.dart';
import 'navigation pages/pop_pages/side_page.dart';
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
      //home: MyHomePage(),
      home: MainPage(),
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
            CustomIcon.account_balance_wallet,
            size: 24,
            color: Color.fromARGB(255,66, 165, 245),
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
              Navigator.push(context,
              MaterialPageRoute(builder: (context) =>  Guest()),
              );
            },
            child: Text('GUEST'),
          )
      ,),
    ],)));
  }
}

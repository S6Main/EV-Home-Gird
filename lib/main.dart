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
        height: 500,
      ),
      SizedBox(
      width: 300,
      height: 50,
      child: RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
        onPressed: () {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  MetaMask()),
          );
        },
        color: Colors.orange,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Text(
          "MetaMask",
          style: TextStyle(color: Colors.black, fontSize: 18),

        ),
      ),
    ),
    SizedBox(
      height: 16,
    ),
    SizedBox(
      width: 300,
      height: 50,
      child: RaisedButton(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  Guest()),
        );
      },
    color: Colors.blue,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Text(
        "Guest",
        style: TextStyle(color: Colors.white, fontSize: 18),
     ),),),
    ],)));
  }
}

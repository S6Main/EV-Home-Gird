import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
            child: Row(
              children: [
                Icon(Icons.menu, size: 25, color: Colors.black54,),
                Expanded(child: Container(
                  alignment: Alignment.center,
                  child: Text('New Berlin, WI 53151, USA', style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black26),),
                )),
                Icon(Icons.search, size: 25, color: Colors.black54,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
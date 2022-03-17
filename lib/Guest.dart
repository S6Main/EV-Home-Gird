import 'package:flutter/material.dart';

//create a class names gust and extends the stateless widget
class Guest extends StatelessWidget {
  //create a method named build
  @override
  Widget build(BuildContext context) {
    //return a Scaffold
    return Scaffold(
      //create an app bar
      appBar: AppBar(
        //create a title
        backgroundColor: Colors.white,
        elevation: 2.5,
        toolbarHeight: 70,
        shadowColor: Color.fromARGB(90, 87, 87, 87),
        title: Text('Guest'),
        //add a search button in app bar
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      //create a body
      body: Center(
        //create a text widget
        child: Text('This is Guest Page',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            )),
      ),
    );
  }
}

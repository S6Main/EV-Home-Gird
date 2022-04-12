// main.dart
import 'package:flutter/material.dart';

import '../navigation pages/main_page.dart';

class SrcDestpg extends StatelessWidget {
  const SrcDestpg({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40.0,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: 'Source',
                    contentPadding: const EdgeInsets.all(20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
                onChanged: (value) {
                  // do something
                },
              ),
              SizedBox(
                height: 30.0,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: 'Destination',
                    contentPadding: const EdgeInsets.all(20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
                onChanged: (value) {
                  // do something
                },
              ),
              SizedBox(
                height: 50.0,
              ),
              SizedBox(
                width: 330,
                height: 55,
                child: ElevatedButton.icon(
                  icon: Icon(
                    Icons.search,
                    size: 24,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Search',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 15, 3, 3),
                    onPrimary: Color.fromARGB(255, 0, 0, 0),
                    shadowColor: Color.fromARGB(68, 0, 0, 0),
                    side: BorderSide(
                        width: 1.5, color: Color.fromARGB(19, 0, 0, 0)),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    minimumSize: Size(100, 40), //////// HERE
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

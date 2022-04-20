import 'package:ev_homegrid/widgets/search.dart';
import 'package:flutter/material.dart';

class SrcDestpg extends StatelessWidget {
  const SrcDestpg({Key? key}) : super(key: key);

  get child => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.blue)),
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.my_location_rounded,
                  color: Colors.green,
                ),
                suffix: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Search()),
                    );
                  },
                ),
                hintText: 'Search...',
                border: InputBorder.none),
          ),
        ),
        bottom: PreferredSize(
            child: Container(
              width: 300,
              height: 40,
              alignment: Alignment.topRight,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.blue)),
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.location_on,
                      color: Colors.red,
                    ),
                    suffix: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Search()),
                        );
                      },
                    ),
                    hintText: 'Search...',
                    border: InputBorder.none),
              ),
            ),
            preferredSize: Size.fromHeight(2.0)),
      ),
    );
  }
}

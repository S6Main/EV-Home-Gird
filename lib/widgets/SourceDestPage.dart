import 'package:flutter/material.dart';
import 'package:place_picker/place_picker.dart';

class SourceDestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SourceDestPageState();
}

class SourceDestPageState extends State<SourceDestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Picker Example')),
      body: Center(
        child: ElevatedButton(
          child: Text("Pick Delivery location"),
          onPressed: () {
            showPlacePicker();
          },
        ),
      ),
    );
  }

  void showPlacePicker() async {
    LocationResult result = await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PlacePicker("AIzaSyCV_x2q82h5TjN5py9HS7Fx7bxV1Wgr_K8")));

    // Handle the result in your way
    print(result);
  }
}
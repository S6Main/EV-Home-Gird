import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pop_pages/side_page.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';


class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  static const _initialPosition = CameraPosition(target: LatLng(37.42796133580664, -122.085749655962),zoom: 14.4746);
  GoogleMapController? _googleMapController;

  //markers
  late Marker _origin;
  late Marker _destination;

  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //backgroundColor: Color.fromARGB(255, 155, 95, 95),
     body: GoogleMap(
       myLocationButtonEnabled: false,
       zoomControlsEnabled: false,
       initialCameraPosition: _initialPosition,
       //onMapCreated: (controller) => _googleMapController = controller,
       onMapCreated: (controller) {
         _googleMapController = controller;
       },
       markers: {
        if (_origin != null) _origin,
        if (_destination != null) _destination,
       },
       onLongPress: addMarker,
     ),

     floatingActionButton: FloatingActionButton(
       backgroundColor: Theme.of(context).primaryColor,
       foregroundColor: Colors.black,
       onPressed: () => _googleMapController?.animateCamera(CameraUpdate.newCameraPosition(_initialPosition),),

       child: const Icon(Icons.center_focus_strong),
     ),
     
    
    );
  }
  // ignore: dead_code
    void addMarker(LatLng pos){
      if(_origin == null || (_origin != null && _destination != null)){
        //orgin is not set OR orgin/destination are both set
        //set origin
        setState(() {
          _origin = Marker(
            markerId:const MarkerId('origin'),
            infoWindow: const InfoWindow(title: 'Origin'),
            position: pos,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          );
          //Reset destination
          //_destination = null; 
        });
      }
      else{
        setState(() {
          _destination = Marker(
            markerId:const MarkerId('destination'),
            infoWindow: const InfoWindow(title: 'Destination'),
            position: pos,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          );
        });
        //orgin is already set
        //set destination
      }
    }
}



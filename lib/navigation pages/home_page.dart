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

  
  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }

  static final Marker _kGooglePlexMarker = Marker(
      markerId : MarkerId('_kGooglePlex'),
      infoWindow: InfoWindow(title: 'Google Plex'),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(37.42796133580664, -122.085749655962)
      );
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //backgroundColor: Color.fromARGB(255, 155, 95, 95),
     body: GoogleMap(
       mapType: MapType.normal,
       myLocationButtonEnabled: false,
       zoomControlsEnabled: false,
       initialCameraPosition: _initialPosition,
       //onMapCreated: (controller) => _googleMapController = controller,
       onMapCreated: (controller) {
         _googleMapController = controller;
       },
        markers: {
          _kGooglePlexMarker,
        },
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
    
}



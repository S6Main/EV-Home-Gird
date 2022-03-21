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
  static Marker _origin = Marker(
      markerId : MarkerId('_origin'),
      infoWindow: InfoWindow(title: 'Origin Location'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      );

  static Marker _destination = Marker(
      markerId : MarkerId('_destination'),
      infoWindow: InfoWindow(title: 'Destination Location'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      );

  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }

  static final Polyline _polyline = Polyline(
    polylineId: PolylineId('_polyline'),
    points: [
      //LatLng(37.42796133580664, -122.085749655962),
      //LatLng(37.43296265331129, -122.08832357078792),
      _origin.position,
      _destination.position
    ],
    width: 3,
    );
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Google Maps',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
        actions: [
          if(_origin.markerId.value != '_origin') 
          TextButton(onPressed: () => _googleMapController?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: _origin.position,
                zoom: 14.5,
              ),
            ),
          ),
          style: TextButton.styleFrom(
            primary: Colors.green,
            textStyle: const TextStyle(fontWeight: FontWeight.w600)
          ),
          child: const Text('ORIGIN'),
          ),

           if(_destination.markerId.value != '_destination')
          TextButton(onPressed: () => _googleMapController?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: _destination.position,
                zoom: 14.5,
              ),
            ),
          ),
          style: TextButton.styleFrom(
            primary: Colors.green,
            textStyle: const TextStyle(fontWeight: FontWeight.w600)
          ),
          child: const Text('DEST'),
          ),
        ],
      ),
      //backgroundColor: Color.fromARGB(255, 155, 95, 95),
     body: 
     GoogleMap(
       myLocationButtonEnabled: false,
       zoomControlsEnabled: false,
       initialCameraPosition: _initialPosition,
       //onMapCreated: (controller) => _googleMapController = controller,
       onMapCreated: (controller) {
         _googleMapController = controller;
       },
       markers: {
        if (_origin.markerId != '_origin') _origin,
        if (_destination != '_destination') _destination,
       },
       polylines: {
         if(_destination.markerId.value != '_destination' && _origin.markerId.value != '_origin') _polyline,
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
        print(_origin.markerId.value);
        print(_destination.markerId.value);
      if(_origin.markerId.value == '_origin' || (_destination.markerId.value != '_destination' && _origin.markerId.value != '_origin')){
        //orgin is not set OR orgin/destination are both set
        //set origin
        setState(() {
          print("Marking Green");
          Map().clear();
          _origin = Marker(
            markerId:const MarkerId('origin'),
            infoWindow: const InfoWindow(title: 'Origin'),
            position: pos,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          );
          //Reset destination
          //_destination = null; 
          
        });
        _destination = Marker(
            markerId:const MarkerId('_destination'),
            infoWindow: const InfoWindow(title: 'Destination'),
            position: pos,
            alpha: 0.0,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          );
      }
      else{
        setState(() {
          print("Marking Blue");
          _destination = Marker(
            markerId:const MarkerId('destination'),
            infoWindow: const InfoWindow(title: 'Destination'),
            position: pos,
            alpha: 1.0,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          );
        });
        //orgin is already set
        //set destination
      }
    }
}



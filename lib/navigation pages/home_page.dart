import 'dart:ffi';

import 'package:ev_homegrid/maps/directions_model.dart';
import 'package:ev_homegrid/maps/directions_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
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
  Directions? _info;

  //markers
  static Marker _origin = Marker(
      markerId : MarkerId('_origin'),
      infoWindow: InfoWindow(title: 'Origin Location'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
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
     body: Stack(
       alignment: Alignment.center,
       children: [
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
              if (_info != null) 
                Polyline(
                  polylineId: const PolylineId('overview_polyline'),
                  color: Colors.red,
                  width: 5,
                  points: _info!.polyLinePoints!.map((e) => LatLng(e.latitude, e.longitude)).toList(),
                ),
            },
            onLongPress: addMarker,
          ),
          if(_info != null)
          Positioned(
            top: 20.0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 6.0,
                horizontal: 12.0
              ),
              decoration: BoxDecoration(
                color: Colors.yellowAccent,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: const[
                  BoxShadow(
                    color: Colors.black26,
                    offset:Offset(0, 2),
                    blurRadius: 6.0
                  )
                ]
              ),
              child: Text(
                '${_info?.totalDistance},${_info?.totalDuration}',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black
                ),
              ),
            ),
          ),
       ],
     ),
     

     floatingActionButton: FloatingActionButton(
       backgroundColor: Theme.of(context).primaryColor,
       foregroundColor: Colors.black,
       /* onPressed: () => _googleMapController?.animateCamera(
          _info != null 
            ? CameraUpdate.newLatLngBounds(_info.bounds, 100.0)
            : CameraUpdate.newCameraPosition(_initialPosition), 
       ), */
        onPressed: () => _googleMapController?.animateCamera(CameraUpdate.newCameraPosition(_initialPosition),),

       child: const Icon(Icons.center_focus_strong),
     ),
     
    
    );
  }
  // ignore: dead_code
    void addMarker(LatLng pos)async{
      if(_origin.markerId.value == '_origin' || (_destination.markerId.value != '_destination' && _origin.markerId.value != '_origin')){
        //orgin is not set OR orgin/destination are both set
        //set origin
        setState(() {
          print("Marking Green");
          
          _origin = Marker(
            markerId:const MarkerId('origin'),
            infoWindow: const InfoWindow(title: 'Origin'),
            position: pos,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          );
          //Reset destination
          //_destination = null; 
          
          _info = null;
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

        //get directions
        final directions = await DirectionsRepository()
        .getDirections(origin: _origin.position, destination: _destination.position);
        setState(() {
          _info = directions;
        });
      }
    }
}



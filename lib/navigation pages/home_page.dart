import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pop_pages/side_page.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:custom_map_markers/custom_map_markers.dart';




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

  final locations = const [
    LatLng(37.42796133580664, -122.085749655962),
    LatLng(37.41796133580664, -122.085749655962),
    LatLng(37.43796133580664, -122.085749655962),
    LatLng(37.42796133580664, -122.095749655962),
    LatLng(37.42796133580664, -122.075749655962),
  ];

  

  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }

  static Polyline _polyline = Polyline(
    polylineId: PolylineId('_polyline'),
    points: [
      _origin.position,
      _destination.position
    ],
    width: 3,
    );

  changeMapMode(){
    getJsonFile("assets/light.json").then(setMapStyle);
  }

  Future<String> getJsonFile(String path) async{
    String val =  await rootBundle.loadString(path);
    return val;
    //get json file path
  }
  void setMapStyle(String mapStyle) {
    _googleMapController?.setMapStyle(mapStyle);
    print("set style");
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
     body: 
      CustomGoogleMapMarkerBuilder(
        //screenshotDelay: const Duration(seconds: 4),
        customMarkers: [
          MarkerData(
              marker: Marker(
                  markerId: const MarkerId('id-1'), position: locations[0]),
              child: _customMarkerDest(Color.fromARGB(255,182, 225,16))),
          MarkerData(
              marker: Marker(
                  markerId: const MarkerId('id-5'), position: locations[4]),
              child: _customMarker('A', Colors.black)),
          MarkerData(
              marker: Marker(
                  markerId: const MarkerId('id-2'), position: locations[1]),
              child: _customMarker('B', Color.fromARGB(255, 0, 0, 0))),
          MarkerData(
              marker: Marker(
                  markerId: const MarkerId('id-3'), position: locations[2]),
              child: _customMarker('C', Color.fromARGB(255, 0, 0, 0))),
          MarkerData(
              marker: Marker(
                  markerId: const MarkerId('id-4'), position: locations[3]),
              child: _customMarkerOrigin(Color.fromARGB(255,182, 225,16))),
          MarkerData(
              marker: Marker(
                  markerId: const MarkerId('id-5'), position: locations[4]),
              child: _customMarker('A', Color.fromARGB(255, 0, 0, 0))),
        ],
        builder: (BuildContext context, Set<Marker>? markers) {
          if (markers == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return GoogleMap(
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: _initialPosition,
            //onMapCreated: (controller) => _googleMapController = controller,
            onMapCreated: (controller) {
              _googleMapController = controller;
              changeMapMode();
            },
            markers: markers,
            onLongPress: addMarker,
            
           
          );
        },
      ),

     /* GoogleMap(
       myLocationButtonEnabled: false,
       zoomControlsEnabled: false,
       initialCameraPosition: _initialPosition,
       //onMapCreated: (controller) => _googleMapController = controller,
       onMapCreated: (controller) {
         _googleMapController = controller;
         changeMapMode();
       },
       markers: {
        if (_origin.markerId != '_origin') _origin,
        if (_destination != '_destination') _destination,
       },
       polylines: {
         if(_destination.markerId.value != '_destination' && _origin.markerId.value != '_origin') _polyline,
       },
       onLongPress: addMarker,
     ), */

     floatingActionButton: FloatingActionButton(
       backgroundColor: Theme.of(context).primaryColor,
       foregroundColor: Colors.black,
       onPressed: () => _googleMapController?.animateCamera(CameraUpdate.newCameraPosition(_initialPosition),),

       //child: const Icon(Icons.center_focus_strong),
       child: const Icon(Icons.my_location),
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
          
          _origin = Marker(
            markerId:const MarkerId('origin'),
            infoWindow: const InfoWindow(title: 'Origin'),
            position: pos,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
            //icon: CustomM
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
      _polyline = Polyline(
    polylineId: PolylineId('_polyline'),
    points: [
      _origin.position,
      _destination.position
    ],
    width: 3,
    );
    }

    _customMarker(String text, Color color) {
    return Container(
      child: /* ImageIcon(
        AssetImage('assets/images/charging.png'),
        color: color,
        size: 40,
      ), */
      Icon(
        Icons.location_on,
        color: color,
        size: 40,
      ),
    );
  }

  _customMarkerOrigin(Color color) {
    return Container(
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(50),boxShadow: [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 2,
                offset: Offset(0, 2))
          ]),
      child: 
      Icon(
        LineAwesomeIcons.location_arrow,
        color: Colors.white,
        size: 30,
      ),
    );
    
    /*  Container(
      child: ImageIcon(
        AssetImage('assets/images/src.png'),
        color: color,
        size: 40,
      ),
     
    ); */
  }

  _customMarkerDest(Color color) {
    
    return Container(
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(50),boxShadow: [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 2,
                offset: Offset(0, 2))
          ]),
      child: 
      Icon(
        LineAwesomeIcons.location_arrow,
        color: Colors.white,
        size: 30,
      ),
    );
    
    /*  Container(
      child: ImageIcon(
        AssetImage('assets/images/src.png'),
        color: color,
        size: 40,
      ),
     
    ); */
  }
}




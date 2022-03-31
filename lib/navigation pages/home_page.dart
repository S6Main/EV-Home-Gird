import 'dart:ffi';
import 'dart:developer' as dev;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pop_pages/side_page.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:google_maps_routes/google_maps_routes.dart';




class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  static const _initialPosition = CameraPosition(target: LatLng(37.42796133580664, -122.085749655962),zoom: 14.4746);
  GoogleMapController? _googleMapController;

  List<LatLng> points = [
    LatLng(37.42796133580664, -122.085749655962),
    LatLng(37.41796133580664, -122.085749655962),
    ];
  MapsRoutes route = new MapsRoutes();
  String googleApiKey = 'AIzaSyBPVmFIW-OGZSrk2u5lfVov64M-GloBgXI';
    
  callmeToDelay() async {
    await Future.delayed(Duration(seconds: 2)); // code to make a delay of 2 seconds
  }
  
  @override
  initState() {
    super.initState();
    callmeToDelay();
  }

  findRoute()async{
   await route.drawRoute(points, 'Test routes',
              Color.fromRGBO(130, 78, 210, 1.0), googleApiKey,
              travelMode: TravelModes.driving);
  }

  static var locations = const [
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
      //_origin.position,
      //_destination.position
      LatLng(37.42796133580664, -122.085749655962),
      LatLng(37.420844582802545, -122.12862715677983),

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
  Widget button(VoidCallback function, IconData icon){
    return FloatingActionButton(
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.blue,
      child: Icon(icon, size: 24.0,),
    );
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
          
        ],
      ),
      //backgroundColor: Color.fromARGB(255, 155, 95, 95),
     body:

     // from this
      CustomGoogleMapMarkerBuilder(
        //screenshotDelay: const Duration(seconds: 4),


        customMarkers: [
          MarkerData(
              marker: Marker(
                  markerId: const MarkerId('dst'), position: locations[0],onTap: (){
                    // code to execute when tapped
                    print(locations[0]);
                  }),
              child: _customMarkerDest(Color.fromARGB(255,182, 225,16))), 
          
          MarkerData(
              marker: Marker(
                  markerId: const MarkerId('src'), position: locations[1],rotation: 270),
              child: _customMarkerOrigin(Color.fromARGB(255,182, 225,16))),
          MarkerData(
              marker: Marker(
                  markerId: const MarkerId('id-1'), position: locations[2],onTap: (){
                    // code to execute when tapped
                  }),
              child: _customMarker('A', Color.fromARGB(255, 0, 0, 0))), //right
              MarkerData(
              marker: Marker(
                  markerId: const MarkerId('id-2'), position: locations[3],onTap: (){
                    // code to execute when tapped
                  }),
              child: _customMarker('B', Color.fromARGB(255, 0, 0, 0))), // bottom
          MarkerData(
              marker: Marker(
                  markerId: const MarkerId('id-3'), position: locations[4],onTap: (){
                    // code to execute when tapped
                  }),
              child: _customMarker('C', Color.fromARGB(255, 0, 0, 0))), //top
        ],
        
        builder: (BuildContext context, Set<Marker>? markers) {
          if (markers == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return Stack(
            children: [
              Container(
                  child: GoogleMap(
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              initialCameraPosition: _initialPosition,
              //onMapCreated: (controller) => _googleMapController = controller,
              onMapCreated: (controller) {
                _googleMapController = controller;
                changeMapMode();
                //findRoute();
              },
              polylines: route.routes,
              //polylines: Set.from([_polyline]), 
              markers: markers,
              
              
              //onLongPress: addMarker,
              
             
                ),
              ),
              Padding(padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(children: <Widget> [
                  button(() {
                    //findRoute();
                    print(route.routes);
                    }, Icons.directions),
                ]),
              ),
              )
            ],
            
          );
        },
      ),  // upto this

     
     
     floatingActionButton: FloatingActionButton(
       backgroundColor: Theme.of(context).primaryColor,
       foregroundColor: Colors.black,
       /* onPressed: (){
       }, */
      /*  onPressed: () => _googleMapController?.animateCamera(CameraUpdate.newCameraPosition(_initialPosition),),
       */

          onPressed: () async {
          await route.drawRoute(points, 'Test routes',
              Color.fromRGBO(130, 78, 210, 1.0), googleApiKey,
              travelMode: TravelModes.driving);
              
              },
       child: const Icon(Icons.my_location),
       
     ),
     
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

          color: color, borderRadius: BorderRadius.circular(50),),
      child: ImageIcon(
        AssetImage('assets/images/circle.png'),
        color: color,
        size: 6,
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




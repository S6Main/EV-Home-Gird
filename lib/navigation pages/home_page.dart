import 'dart:ffi';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../widgets/BottomInfoPanel.dart';
import '../widgets/MapPointerBadge.dart';

const LatLng SOURCE_LOCATION = LatLng(42.7477863,-71.1699932);
const LatLng DEST_LOCATION = LatLng(42.744421,-71.1698939);
const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const double PIN_VISIBLE_POSITION = 20;
const double PIN_INVISIBLE_POSITION = -220;


class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  static const _initialPosition = CameraPosition(target: LatLng(37.42796133580664, -122.085749655962),zoom: 14.4746);
  GoogleMapController? _googleMapController;

  late BitmapDescriptor _sourceIcon;
  late BitmapDescriptor _destinationIcon;
  late LatLng _currentLocation;
  late LatLng _destinationLocation;
  Set<Marker> _markers = Set<Marker>();
  double _pinPillPosition = PIN_INVISIBLE_POSITION;
  bool _userBadgeSelected = false;
  
  String googleApiKey = 'AIzaSyDBiRGvyGsmTThjfe1cwZNGhmwaxYW1kVA';

  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> _polylineCoordinates = [];
  late PolylinePoints _polylinePoints;
  
  @override
  initState() {
    super.initState();
    // set initial locations
    this.setIntitialLocation();

    //set custom marker icons
    this.setSourceAndDestinationMarker();

    //instatiate polyinepointes
    _polylinePoints = PolylinePoints();
  }

  void setSourceAndDestinationMarker() async{
    _sourceIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.0),
      'assets/images/marker-pointer.png');

    _destinationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.0),
       'assets/images/marker-charger.png');
  }
  void setIntitialLocation(){
    _currentLocation = LatLng(
      SOURCE_LOCATION.latitude, 
      SOURCE_LOCATION.longitude
      );

    _destinationLocation = LatLng(
      DEST_LOCATION.latitude, 
      DEST_LOCATION.longitude
      );
  }
  void showPinsOnMap() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: _currentLocation,
        icon: _sourceIcon,
        infoWindow: InfoWindow(title: 'Source'),
        onTap: (){
          setState(() {
            this._userBadgeSelected = true;
            this._pinPillPosition = PIN_INVISIBLE_POSITION;
          });
        }
      ));

      _markers.add(Marker(
        markerId: MarkerId('destPin'),
        position: _destinationLocation,
        icon: _destinationIcon,
        infoWindow: InfoWindow(title: 'Destination'),
        onTap: () {
          setState(() {
            this._pinPillPosition = PIN_VISIBLE_POSITION;
            this._userBadgeSelected = false;
          });
        },
      ));
    });
  }

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
  }

  void setPolylines() async{
    PolylineResult _results = await _polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(_currentLocation.latitude, _currentLocation.longitude),
      PointLatLng(_destinationLocation.latitude, _destinationLocation.longitude),
      travelMode: TravelMode.driving,
    );
    print("here");
    print(_results.status);
    if(_results.status == 'OK'){
      
      _results.points.forEach((PointLatLng _point) {
        _polylineCoordinates.add(LatLng(_point.latitude, _point.longitude));
       });

       setState(() {
         //print("here");
         _polylines.add(
           Polyline(
             width: 1,
             polylineId: PolylineId('polyline'),
             color: Colors.black,
             points: _polylineCoordinates 
           )
         );
       });
    }
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

    CameraPosition _initialCameraPosition = CameraPosition(
      target: SOURCE_LOCATION,
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
    );

    return Scaffold(
      body: Stack(
        children : [
          Positioned.fill(
            child: GoogleMap(
              myLocationButtonEnabled: true,
              compassEnabled: false,
              tiltGesturesEnabled: false,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              markers: _markers,
              polylines: _polylines,
              mapType:MapType.normal,
              initialCameraPosition: _initialCameraPosition,
              onTap: (LatLng loc){
                //tapping on the map will dismiss the bottom pill
                setState(() {
                  this._pinPillPosition = PIN_INVISIBLE_POSITION;
                  this._userBadgeSelected = false;
                });
              },
              onMapCreated: (GoogleMapController controller){
                _googleMapController = controller;
                showPinsOnMap();
                changeMapMode();
                setPolylines();
              },
            ),
          ),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: MapPointerBadge(isSelected: _userBadgeSelected,)
            ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
              left: 0,
              right: 0,
              bottom: this._pinPillPosition,
              child: BottomInfoPanel(),
            )
          ],
      ),
    );
  }
  
}


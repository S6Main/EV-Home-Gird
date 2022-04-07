import 'dart:ffi';
import 'dart:developer' as dev;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:dio/dio.dart';

import '../widgets/BottomInfoPanel.dart';
import '../widgets/MapPointerBadge.dart';

const LatLng SOURCE_LOCATION = LatLng(42.7477863,-71.1699932);
const LatLng DEST_LOCATION = LatLng(42.744421,-71.1698939);
const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 20;
const double CAMERA_BEARING = 30;
const double PIN_VISIBLE_POSITION = 20;
const double PIN_INVISIBLE_POSITION = -250;


class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  
  GoogleMapController? _googleMapController;

  late BitmapDescriptor _sourceIcon;
  late BitmapDescriptor _destinationIcon;
  late LatLng _currentLocation;
  late LatLng _destinationLocation;
  Set<Marker> _markers = Set<Marker>();
  double _pinPillPosition = PIN_INVISIBLE_POSITION;
  bool _userBadgeSelected = false;

  bool _mapCreated = false;
  bool _destSelected = false;
  
  String googleApiKey = 'AIzaSyATUTZMFhb74fCSV6WSfn8nKRt6ewvjFGM';


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
          removePolylines();
          setState(() {
            _destSelected = false;
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
          if(_mapCreated && !_destSelected)
          {
            setPolylines();
            _destSelected = true;
          }
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
    print('result: ${_results.points}');
    if(_results.status == 'OK'){
      
      _results.points.forEach((PointLatLng _point) {
        _polylineCoordinates.add(LatLng(_point.latitude, _point.longitude));
       });

       setState(() {
         //print("here");
         _polylines.add(
           Polyline(
             width: 3,
             polylineId: PolylineId('polyline'),
             color: Colors.black,
             points: _polylineCoordinates,
             startCap: Cap.buttCap,
              endCap: Cap.buttCap,
           )
         );
       });
    }
  }
  void removePolylines() {
    _polylineCoordinates.clear(); //prevent from forming a loop
    _polylines.clear();
  }
 
 void animateCamera(Set<Polyline> polylines) { 
   
    double minLat = polylines.first.points.first.latitude;
    double minLong = polylines.first.points.first.longitude;
    double maxLat = polylines.first.points.first.latitude;
    double maxLong = polylines.first.points.first.longitude;

    polylines.forEach((poly) {
      poly.points.forEach((point) {
        if (point.latitude < minLat) minLat = point.latitude;
        if (point.latitude > maxLat) maxLat = point.latitude;
        if (point.longitude < minLong) minLong = point.longitude;
        if (point.longitude > maxLong) maxLong = point.longitude;
      });
    });
    _googleMapController?.animateCamera(CameraUpdate.newLatLngBounds(
        LatLngBounds(
            southwest: LatLng(minLat, minLong),
            northeast: LatLng(maxLat, maxLong)),
            130));
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
              polylines:_polylines,
              
              mapType:MapType.normal,
              initialCameraPosition: _initialCameraPosition,
              onTap: (LatLng loc){
                if(_destSelected){
                  animateCamera(_polylines);  //animate camera to initial position from top
                }
                else{
                  _googleMapController?.animateCamera(CameraUpdate.newCameraPosition(_initialCameraPosition),);
                }
                  
                //removePolylines();
                //tapping on the map will dismiss the bottom pill
                setState(() {
                  this._pinPillPosition = PIN_INVISIBLE_POSITION;
                  this._userBadgeSelected = false;
                });
              },
              onMapCreated: (GoogleMapController controller){
                _googleMapController = controller;
                _mapCreated = true;
                showPinsOnMap();
                changeMapMode();
                //setPolylines();
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
              child: CarouselSlider(
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                        enableInfiniteScroll: false,
                        autoPlay: false,
                        ),
                      items: [
                        BottomInfoPanel(),
                        BottomInfoPanel(),
                        BottomInfoPanel(),
                      ]
                      ),
              
              
            )
          ],
      ),
    );
  }
  
}


import 'dart:convert';
import 'dart:ffi';
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ev_homegrid/_v2/stage_1/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import '../_widgets/CustomWindow.dart';
import '../componets/Distance.dart';
import '../componets/MapUtils.dart';
import '../componets/SlideRightRoute.dart';
import '../componets/locations.dart' as _locations;
//import 'package:sliding_up_panel/sliding_up_panel.dart';

//v2
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../componets/FadeRoute.dart';
import '../componets/globals.dart' as globals;
import 'package:custom_info_window/custom_info_window.dart';

import '../web3dart/ethereum_utils.dart';
import 'terms_page.dart';



//import '../widgets/MapPointerBadge.dart';

const LatLng SOURCE_LOCATION = LatLng(42.7477863,-71.1699932);
const LatLng DEST_LOCATION = LatLng(42.744421,-71.1698939);
const double CAMERA_ZOOM = 15;
const double CAMERA_TILT = 20;
const double CAMERA_BEARING = 30;
const double PIN_VISIBLE_POSITION = 0;
const double PIN_INVISIBLE_POSITION = -250;


class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  
  GoogleMapController? _googleMapController;
  Dio _dio = new Dio();

  late BitmapDescriptor _sourceIcon;
  late BitmapDescriptor _destinationIcon;
  late BitmapDescriptor _markerIcon;
  late BitmapDescriptor _pinIcon;
  Marker? _lastSelectedMarker = null;
  late LatLng _currentLocation;
  late LatLng _destinationLocation;
  Set<Marker> _markers = Set<Marker>();
  double _pinPillPosition = PIN_INVISIBLE_POSITION;
  bool _userBadgeSelected = false;

  bool _mapCreated = false;
  bool _destSelected = false;
  bool _sourcSelected = false;
  String _destinationName = 'Destination';
  int _currenInfoPanel = -1;
  String _currentMarkerId = 'destPin';
  int _currentMarkerIndex = -1;
  bool _onSlider = false;

  bool _canShowButton = true;
  String _buttonText = 'Show Markers';

  // List<BottomInfoPanel> _bottonInfoPanels =[];
  
  String googleApiKey = 'AIzaSyCV_x2q82h5TjN5py9HS7Fx7bxV1Wgr_K8';


  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> _polylineCoordinates = [];
  List<LatLng> _polylineCoordinatesSelected = [];
  late PolylinePoints _polylinePoints;

  CarouselController bottonCarouselController = CarouselController();

  //v2
  TextEditingController _searchController = new TextEditingController();
  bool _isOnline = false;
  bool _routeFound = false;
  LatLng _nearestMarkerCoordinates = LatLng(0, 0);
  String _nearstMarkerName = '';
  String _nearestMarkerId = '';
  bool _isSinglePoint = true;
  String _arrival = 'Arrival(0 mins)';
  List<String> _arrivalList = [];

  LatLng _divertionCoordinates = LatLng(0, 0);
  LatLng _intermediateCharger = LatLng(0, 0);


  CustomInfoWindowController controller = CustomInfoWindowController();

  //ValueNotifier<int> _changeInIndex =ValueNotifier(0);  // used to notify the carousel to change the index
  EthereumUtils ethUtils = EthereumUtils(); //web3dart
  
  @override
  initState() {
    super.initState();
    // set initial locations
    this.setIntitialLocation();
    ethUtils.initial(); //web3dart
    //set custom marker icons
    this.setSourceAndDestinationMarker();

    //instatiate polyinepointes
    _polylinePoints = PolylinePoints();
    networkCheck();
    gatherArrivals();
    if(globals.isLoggedIn)createUser();
  }
  void createUser(){
    bool _status = checkUserExist();
  }
  bool checkUserExist(){
    //recieve max(userid) from web3
    //receive exist or not from web3
    // ethUtils.getUserDetails(globals.publicKey);
    ethUtils.getUserDetails(globals.publicKey).then((value) {
      if(value != null){
        print(value[0]);
        if(value[0] == true){
          globals.userName = value[2];
          print('status :  welcome back ${globals.userName}');
          setState(() {
            globals.isFirstTime = false;
          });
          globals.canAskName = false;
          return true;
        }
        else{
          int val = int.parse(value[1].toString());
          globals.userId = val+1;
          setUpUser();
          print('status :  user not exist');
          globals.canAskName = true;
          return false;
        }
      }
    });

    return false;
    
  }
  void setUpUser(){
    //pass [id,name,address] to web3dart
    print('calling setUpUser');
    globals.canAskName ? CustomDialogAskName() :null;
  }

  void networkCheck()async{
    _isOnline = await hasNetwork();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  void setSourceAndDestinationMarker() async{
    _sourceIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.0),
      'assets/images/marker-pointers.png');

    _destinationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.0),
       'assets/images/marker-pointer.png');
       
    _markerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.0),
      'assets/images/marker-charger.png');

    _pinIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.0),
      'assets/images/icons8-map-pin-96.png');
    
  }
  void setIntitialLocation(){

    _currentLocation = LatLng(
      globals.currentLocation.latitude,
      globals.currentLocation.longitude,
      );
    // _currentLocation = LatLng(
    //   SOURCE_LOCATION.latitude, 
    //   SOURCE_LOCATION.longitude
    //   );

    // _destinationLocation = LatLng(
    //   DEST_LOCATION.latitude, 
    //   DEST_LOCATION.longitude
    //   );
  }
  void showCurrentPinOnMap(){
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: _currentLocation,
         icon: _routeFound ?_sourceIcon : _pinIcon,
        infoWindow: InfoWindow(title: 'Your Location'),
        onTap: (){
          removePolylines();
          setState(() {
            _destSelected = false;
            if(_sourcSelected){
              removeMarkers();
            _canShowButton = true;
            }
            _sourcSelected = true;
            this._userBadgeSelected = true;
            this._pinPillPosition = PIN_INVISIBLE_POSITION;
          });
        }
      ));
    });
  }
  void removeDestinationMarker(){
    setState(() {
      _markers.removeWhere((m) => m.markerId.value == _currentMarkerId);
      if(_sourcSelected){
        _lastSelectedMarker = null;
      }
      _markers.add(_lastSelectedMarker!);
    });
  }
  void replaceDestinationMarker(String value, LatLng location){

    //case 1 - no previous marker
    if(_lastSelectedMarker == null){
      _lastSelectedMarker = _markers.firstWhere((marker) => marker.markerId.value == value);
      _markers.remove(_lastSelectedMarker);
      _destinationLocation = location;
      
      //remove old marker_0
      showDestinationPinOnMap();
      //add new markerB
    }
    else{ //case 2 - have previous marker
      _markers.removeWhere((m) => m.markerId.value == _currentMarkerId);

      //_currentMarkerId = value;
      //remove old markerB
      _markers.add(_lastSelectedMarker!);
      //add new marker_0

      _lastSelectedMarker = _markers.firstWhere((marker) => marker.markerId.value == value);
      _markers.remove(_lastSelectedMarker);
      _destinationLocation = location;
      //remove old marker_1
      showDestinationPinOnMap();
       //add new markerB
    }
  }
  void showDestinationPinOnMap(){
    _sourcSelected = false;
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('destPin'),
        position: _destinationLocation,
        icon: _destinationIcon,
        infoWindow: InfoWindow(title: _destinationName),
        onTap: (){
          removePolylines();
          setState(() {
            _destSelected = false;
            this._userBadgeSelected = false;
            this._pinPillPosition = PIN_INVISIBLE_POSITION;
          });
        }
      ));
    });
  }
  void showPinsOnMap() {

    //Marker? resultMarker = null;
    List<Marker> resultMarker = [];

    int minDistance = 100000;
    // for(int i = 0; i < _locations.locations.length; i++){
    //   getDetails(i).then((_time) {
    //         _arrivalList.add(_time);
    //       });
    // }
      for(int i = 0; i < _locations.locations.length; i++){
        // print('status :  ${_locations.locations[i].coordinates}');

          // gather time infomrmation
          

          num distance = getDistance([
            _locations.locations[i].coordinates.latitude,
            _locations.locations[i].coordinates.longitude],);

          int distanceInMeters = distance.toInt();
          bool test = (distanceInMeters < (globals.maxDistance * 1000) && distanceInMeters > (globals.minDistance * 1000));
          // bool test2 = (_locations.locations[i].type.toString() == globals.chargerType.toString()); 
          bool test2 = false;
          String value = _locations.locations[i].type;
          switch(globals.chargerType){
            case 7: test2 = true; break;
            case 6: if(value == 'Ather Grid' ||  value == 'Other'){test2 = true;} break;
            case 5: if(value == 'Ather Dot' ||  value == 'Other'){test2 = true;} break;
            case 4: if(value == 'Other'){test2 = true;} break;
            case 3: if(value == 'Ather Dot' ||  value == 'Ather Grid'){test2 = true;} break;
            case 2: if(value == 'Ather Grid'){test2 = true;} break;
            case 1: if(value == 'Ather Dot'){test2 = true;} break;
          }
          
          // print('status : distance of ${_locations.locations[i].name} is $distanceInMeters');
          if(distanceInMeters < minDistance && test && test2) {
            minDistance = distanceInMeters;
            _nearestMarkerCoordinates = _locations.locations[i].coordinates;
            _nearstMarkerName = _locations.locations[i].name;
            _nearestMarkerId = _locations.locations[i].id;
          }
          
          if (test && test2) {
            resultMarker.add(Marker(
            markerId: MarkerId(_locations.locations[i].id),
            infoWindow: InfoWindow(title: 'Ather   '+_locations.locations[i].name,
            snippet: 'Arrival(${_locations.locations[i].time})'
            ),
            position: _locations.locations[i].coordinates,
            icon: _markerIcon,
            // anchor: Offset(0.5, 0.5), 
            onTap:(){
              _isSinglePoint = true;
                //change destination name
              _destinationName = _locations.locations[i].name;
              _destinationLocation = _locations.locations[i].coordinates;
              _destSelected = true;


              setPolylines();
           
            }
            ));
            }
      
          if(_locations.locations.length > 0){
            setState(() {
              _markers.addAll(resultMarker);
            });
          } 

    } 
      
      
  }
  void findNearestMarkers(){
    _isSinglePoint = true;
    _destinationName = _nearstMarkerName; // no issue
    _destinationLocation = _nearestMarkerCoordinates; //no issue
    print('status : nearest marker id is $_nearestMarkerId');
    _destSelected = true;
    removeMarkersExcept([_nearestMarkerId]);
    // getDetails();
    setPolylines();

    //show destination marker info window
    _googleMapController?.showMarkerInfoWindow(MarkerId(_nearestMarkerId)); //issue
  }
  Future<String> getDetails(int index) async {
    //get approximate time
    // String _orgLat = _currentLocation.latitude.toString();
    // String _orgLng = _currentLocation.longitude.toString();
    // String _destLat = _destinationLocation.latitude.toString();
    // String _destLng = _destinationLocation.longitude.toString();

    String _orgLat = _locations.locations[index].coordinates.latitude.toString();
    String _orgLng = _locations.locations[index].coordinates.longitude.toString();
    String _destLat = _currentLocation.latitude.toString();
    String _destLng = _currentLocation.longitude.toString();
    String api = googleApiKey.toString();

    Response response=await _dio.get(
      "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=$_orgLat,$_orgLng&destinations=$_destLat,$_destLng&key=$api");
    if(response.statusCode == 200){
      
      String _data = response.data.toString();
      String _time = _data.substring(_data.indexOf('duration: {text:') + 16, _data.indexOf('mins') + 4);
      String _distance = _data.substring(_data.indexOf('distance: {text:') + 15, _data.indexOf('mi') + 3);
      // print('status : time - $_time');
      // print('status : distance - $_distance');
      // _arrival = 'Arrival(hahha)';
      return _time;
    }
    else{
      print('status :  can\'t gather data from google api');
      return '0';
    }
  }

  void removeMarkers(){
    setState(() {
      _markers.removeWhere((m) => m.markerId.value != 'sourcePin');
    });
  }
  void removeMarkersExcept(List<String> marker){
    marker.add('sourcePin');
    setState(() {
      _markers.removeWhere((m) => marker.contains(m.markerId.value) == false);
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
    
    removePolylines(); // clear polylines
    // getDetails();
    //change origin icon
    // _sourceIcon = await BitmapDescriptor.fromAssetImage(
    //   ImageConfiguration(devicePixelRatio: 2.0),
    //   'assets/images/icons8-map-a-96.png');
    
    PolylineResult _results = await _polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(_currentLocation.latitude, _currentLocation.longitude),
      PointLatLng(_destinationLocation.latitude, _destinationLocation.longitude),
      travelMode: TravelMode.driving,
    );
    if(_results.status == 'OK'){
      
      _results.points.forEach((PointLatLng _point) {
        _polylineCoordinates.add(LatLng(_point.latitude, _point.longitude));
       });
      // print('status : polyline coordinates is $_polylineCoordinates');
       setState(() {
         _polylines.add(
           Polyline(
             width: 3,
             polylineId: PolylineId('polyline'),
             color: globals.MAIN_COLOR,
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
  // void changeMarkerSelection(){
    
  //   Future.delayed(Duration(milliseconds: 150), () {
  //     Marker _marker = _markers.firstWhere((marker) => marker.markerId.value == _bottonInfoPanels[_currentMarkerIndex].id);
  //     _marker.onTap!();

  //     _googleMapController
  //           ?.animateCamera(CameraUpdate.newCameraPosition(
  //             CameraPosition(
  //                 target: _marker.position,
  //                 zoom: CAMERA_ZOOM,
  //                 tilt: CAMERA_TILT,
  //                 bearing: CAMERA_BEARING,
  //               ),
  //             ));
  //   });

  // }
  void setPolylinesRoute() async{
    
    //change positions of markers
    _currentLocation = globals.startLocation;
    _destinationLocation = globals.endLocation;
      
    //change marker icons
    showCurrentPinOnMap();
    showDestinationPinOnMap();

    removePolylines(); // clear polylines

    //change origin icon
    // _sourceIcon = await BitmapDescriptor.fromAssetImage(
    //   ImageConfiguration(devicePixelRatio: 2.0),
    //   'assets/images/icons8-map-a-96.png');
    
    PolylineResult _results = await _polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(_currentLocation.latitude, _currentLocation.longitude),
      PointLatLng(_destinationLocation.latitude, _destinationLocation.longitude),
      travelMode: TravelMode.driving,
    );


    if(_results.status == 'OK'){
      
      _results.points.forEach((PointLatLng _point) {
        _polylineCoordinates.add(LatLng(_point.latitude, _point.longitude));
       });

       globals.askRange ? null : setUpChargersInRoute();
       setState(() {
         _polylines.add(
           Polyline(
             width: 3,
             polylineId: PolylineId('polyline'),
             color: globals.MAIN_COLOR,
             points: _polylineCoordinates,
             startCap: Cap.buttCap,
              endCap: Cap.buttCap,
           )
         );
       });
       animateCamera(_polylines);
    }
    else{
      print('status : cant find route');
    }
  }
  void ConnectNearbyChargerInRoute(){
    // _divertionCoordinates
    // _intermediateCharger
    int minDistance = 100000;
    String _closestCharger = '';

    List _start = [_divertionCoordinates.latitude, _divertionCoordinates.longitude];
    List _end = [];
    for(int i = 0; i < _locations.locations.length; i++){

      _end = [_locations.locations[i].coordinates.latitude, _locations.locations[i].coordinates.longitude];
      num _distance = distanceToFrom(_start, _end);
      if(_distance < minDistance){
        minDistance = _distance.toInt();
        _intermediateCharger = _locations.locations[i].coordinates;
        _closestCharger = _locations.locations[i].id;
      }
    }
    //remove chargers that not being used ,'destPin'
    removeMarkersExcept([_closestCharger]);
    LatLng tempDest = _destinationLocation;
    _destinationLocation = _intermediateCharger;
    setPolylines();
    _destinationLocation = tempDest;
    setState(() {
      _buttonText = 'Reached';
    });
    
  }
  void redirectToGoogleMap(LatLng _location){
    

    MapUtils.openMap(_location, _currentLocation);
  }
  void setUpChargersInRoute(){
    // print('status : length of coordinates is ${_polylineCoordinates.length}');
    // print('status : length of coordinates is ${_polylineCoordinates.toString()}');
    _buttonText = 'Connect Charger';

    LatLng _firstLatLng = _polylineCoordinates.first;
    LatLng _lastLatLng = _polylineCoordinates.last;
    
    LatLng _currentLatLng = _firstLatLng;

    _polylineCoordinatesSelected = [];
    List _start = [];
    List _end = [];
    List _s = [];
    List _e = [];
    bool _selected = false;

    for(int i = 0; i < _polylineCoordinates.length; i++){
      
      _start = [ _currentLatLng.latitude, _currentLatLng.longitude ];
      _end = [ _polylineCoordinates[i].latitude, _polylineCoordinates[i].longitude ];

      if(distanceToFrom(_start,_end) >= 1500){
        // _polylineCoordinatesSelected.add(LatLng(_end[0], _end[1]));
        _currentLatLng = LatLng(_end[0], _end[1]);

        num range = globals.currentRange - (globals.maxRange * (globals.cutOff / 100));

        // print('status : current distance is ${1500*(_polylineCoordinatesSelected.length)}');
        if(1500*(_polylineCoordinatesSelected.length +1 ) >= range*1000 && !_selected){
          _selected = true;
          _divertionCoordinates = _polylineCoordinatesSelected.last;
          // print('status : divertion coordinates is $_divertionCoordinates');
        }
        _polylineCoordinatesSelected.add(LatLng(_end[0], _end[1]));
      }
      else if (_end == [_lastLatLng.latitude, _lastLatLng.longitude]){
        _polylineCoordinatesSelected.add(LatLng(_end[0], _end[1]));
      }
    }

    // print('status : length of coordinates selected is ${_polylineCoordinatesSelected.length}');

    //code for adding markers
    List<Marker> resultMarker = [];
    for(int i = 0; i < _polylineCoordinatesSelected.length; i++){
      for(int j = 0; j < _locations.locations.length; j++){
        _s = [ _polylineCoordinatesSelected[i].latitude, _polylineCoordinatesSelected[i].longitude ];
        _e = [ _locations.locations[j].coordinates.latitude, _locations.locations[j].coordinates.longitude ];
        num _distance = distanceToFrom(_s,_e);
        if(_distance < 1000){
          resultMarker.add(
            Marker(
              markerId: MarkerId(_locations.locations[j].id),
              position: _locations.locations[j].coordinates,
              icon: _markerIcon,
              onTap: (){
                if(_locations.locations[j].coordinates == _intermediateCharger){
                  setState(() {
                    globals.chargerName = _locations.locations[j].name;
                    globals.chargerAddress = _locations.locations[j].address;
                  });
                  CustomDialogDetails();
                }
              }
            ));
        }
      }
      // resultMarker.add(Marker(
      //       markerId: MarkerId('00$i'),
      //       position: _polylineCoordinatesSelected[i],
      //       icon: _markerIcon,
      //       // anchor: Offset(0.5, 0.5), 
      //       onTap:(){
      //       }
      //       ));
    }
    if(_polylineCoordinatesSelected.length > 0){
            setState(() {
              _markers.addAll(resultMarker);
            });
          } 

  }
 void animateCamera(Set<Polyline> polylines) { 
   
    if(_polylines != null){
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
            50));
    
    
    }
    
 }
  @override
  Widget button(VoidCallback function, IconData icon){
    return FloatingActionButton(
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.black,
      child: Icon(icon, size: 24.0,),
    );
  }
  void gatherArrivals(){
    print('gather arrivals');
    for(int i = 0; i < _locations.locations.length; i++){
      getDetails(i).then((_time) {
            // _arrivalList.add(_time);
            _locations.locations[i].time = _time;
          });
    }
  }
  void findDistance(){
    num distance = getDistance([
            globals.endLocation.latitude,
            globals.endLocation.longitude],isCurrentLocation: false);
    distance = double.parse((distance/1000).toStringAsFixed(2));

    globals.travelRoute = globals.travelRoute + globals.distance.toString() + ' km';

  }
  void _drowRoute(String msg) async{
    _isSinglePoint = false;
    _destSelected = true;
    findDistance();
    removeMarkers();
    _routeFound = true;
      _searchController.text = globals.travelRoute;
    setPolylinesRoute();
    
    //code to show markers and connect
    Future.delayed(Duration(milliseconds: 150), () {
      globals.askRange ?  CustomDialogAskRange() : null;
    });
      _buttonText = 'Show Markers';
    //done
    //drow route
  }
  void _showChargers(){
    
  }
  @override
  Widget build(BuildContext context) {

    CameraPosition _initialCameraPosition = CameraPosition(
      // target: SOURCE_LOCATION,
      target: globals.currentLocation,
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
    );

    return Scaffold(
      body: InkWell(
        // onLongPress: (){
        //  Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //       builder: (BuildContext context) => super.widget));
        // },
        child: Stack(
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
                    if(_polylines.isEmpty){
                      // removeDestinationMarker(); // remove dest marker when tapped
                    }
                    else{
                      animateCamera(_polylines);  //animate camera to initial position from top
                    }
                  }
                  else{
                    _googleMapController?.animateCamera(CameraUpdate.newCameraPosition(_initialCameraPosition),);
                  }

                  if(_polylines.isEmpty){
                    // removeDestinationMarker(); // remove dest marker when tapped
                  }
                  _sourcSelected = false;
                  // _onSlider = false;
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
                  //showPinsOnMap();
                  showCurrentPinOnMap();
                  changeMapMode();
                  //setPolylines();
                },
              ),
            ),
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: 
              Stack(
                children: [
                  
                  
                  Container(
                            margin:EdgeInsets.only(left: 40, right: 40),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:  BorderRadius.circular(16),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Color.fromARGB(15, 0, 0, 0),
                                  blurRadius: 12,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: TextField(
                                maxLength: 42,
                                controller: _searchController,
                                readOnly: true,
                                style: TextStyle(fontSize: 15.5,color: Color.fromARGB(255, 0, 0, 0)),
                                onTap: () {
                                  _searchController.text = '';
                                  
                                  Navigator.of(context).push(CustomPageRoute(SearchPage(drowRoute: _drowRoute,)));
                                },
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(fontSize: 17,color: Color(0xFFBFBFBF)),
                                  hintText: 'Search anything…',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 20,bottom: 20),
                                  counterText: '',
                                  icon:  IconButton(icon: Icon(LineAwesomeIcons.search,
                                    color: Colors.black.withOpacity(0.4),),
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(), 
                                    onPressed: (){
                                      Navigator.of(context).push(CustomPageRoute(SearchPage( drowRoute: _drowRoute,)));
                                    },)
                                ),
                              ),
                            ),
                          ),
                  Positioned(
                    right: 25,
                    top: 5,
                    bottom: 5,
                    child: Container(
                      width: 45,
                      height: 45,
                      child: 
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF2B2D41),
                            elevation: 3,
                            shadowColor: Colors.black26,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                            ),),
                          onPressed:() {

                            setState(() {
                              _arrival = 'updated';
                            });
                            networkCheck();
                            Future.delayed(Duration(milliseconds: 200), () {
                              if(_isOnline){
                              CustomDialogFilterMenu();
                            }
                            else{
                              CustomDialogNetworkIssue();
                            }
                            });
                            networkCheck();
                            
                          },
                          child: ImageIcon(AssetImage("assets/images/Filter_v2.png",),),
                          ),
                    ),
                  ),        
                ],
              ),
            ),
            // Positioned(
            //   top: 50,
            //   left: 0,
            //   right: 0,
            //   child: MapPointerBadge(isSelected: _userBadgeSelected,)
            //   ),    

            // AnimatedPositioned(
            //   duration: const Duration(milliseconds: 500),
            //   curve: Curves.easeInOut,
            //     left: 0,
            //     right: 0,
            //     bottom: this._pinPillPosition,
            //     child: CarouselSlider(
            //             carouselController: bottonCarouselController,
            //             options: CarouselOptions(
            //               enlargeCenterPage: true,
            //               scrollDirection: Axis.horizontal,
            //               enableInfiniteScroll: true,
            //               initialPage: 2,
            //               autoPlay: false,
            //               onPageChanged: (index, reason) {
            //               _onSlider = true;
            //               setState(() {
            //                 _currentMarkerIndex = index;
            //               });
            //               changeMarkerSelection(); 
            //               _onSlider = false;
            //               },
            //         ),
            //             items: _bottonInfoPanels
            //             ),
                
                
            // AnimatedPositioned(
            //   duration: const Duration(milliseconds: 500),
            //   curve: Curves.easeInOut,
            //     left: 0,
            //     right: 0,
            //     bottom: this._pinPillPosition,
            //     child:
            //     SlidingUpPanel(
            //         parallaxEnabled: true,
            //         parallaxOffset: .5,
            //         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
            //         borderRadius: BorderRadius.only(
            //         topLeft: Radius.circular(20),
            //         topRight: Radius.circular(20),
            //         ),
            //         panel: Center(
            //           child: Text("This is the sliding Widget"),
            //         ),
            //         ),
            //       ),
            
            Column(
                    children: [
                      Expanded(
                        child: SizedBox()),
                      Center(
                        child:AnimatedButton(
                              
                              height: 45,
                              width: 200,
                              text: _buttonText,
                              isReverse: true,
                              selectedTextColor: Colors.black,
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                              transitionType: TransitionType.LEFT_TO_RIGHT,
                              backgroundColor: Colors.black,
                              selectedBackgroundColor: Colors.white,
                              borderColor: Colors.white,
                              borderRadius: 20,
                              borderWidth: 0,
                                  onPress: () { 
                                    _searchController.text = '';
                                    //_canShowButton ? showPinsOnMap() : findNearestMarkers();
                                    if(_buttonText == 'Show Markers'){
                                      //clean up
                                        // _currentLocation = globals.currentLocation;
                                        if(_isSinglePoint){
                                          setIntitialLocation();
                                        showCurrentPinOnMap();
                                        removeMarkersExcept(['sourcePin']);
                                        removePolylines();
                                        }
                                        else{
                                          //code to show rearby markers
                                          _buttonText = 'Connect Markers';
                                          _showChargers();
                                        }
                                        
                                      //done
                                      showPinsOnMap();
                                      _buttonText = 'Find nearest markers';
                                    }
                                    else if(_buttonText == 'Find nearest markers')
                                    {
                                      findNearestMarkers();
                                      _buttonText = 'Show Markers';
                                      _canShowButton = false;
                                    }
                                    else if(_buttonText == 'Connect Charger'){
                                      ConnectNearbyChargerInRoute();
                                    }
                                    

                                  },
                              ),
                      ),
                      SizedBox(height: 30,),
                    ],
                  )
            ],
        ),
      ),
    );
  }
  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
  void CustomDialogNetworkIssue() {
    showDialog(
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.0),
        context: context,
        builder: (BuildContext ctx) {
          return Stack(
            children :<Widget>[

              Container(
              child: BackdropFilter(
                blendMode: BlendMode.srcOver,
                filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                child: Container(
                  color: Color(0xFFC4C4C4).withOpacity(0.5),
                  child: AlertDialog(
                    titlePadding: EdgeInsets.zero,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            32.0,
                          ),
                        ),
                      ),

                    title:  
                    Stack(
                        children: [
                          
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Center(
                                  child: Text('Network Error',
                                          style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 0, 0, 0)),
                                          )),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(color: Colors.transparent, height: 40,width: 40,
                            child: Stack(
                              children: [
                                Positioned(
                                  right: 0,
                                  child:  Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: new BorderRadius.circular(20.0),
                                    onTap: (() {
                                      Navigator.of(context).pop();
                                    }),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      color: Colors.transparent,
                                      child: Image.asset('assets/images/closeIcon_v2.png')
                                    ),
                                  ),
                                ),)
                              ],
                            ),),)
                        ],
                      ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 20),
                    //   child: Center(
                    //     child: Text('Network Error',
                    //             style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 0, 0, 0)),
                    //             )),
                    // ),
                    content: Builder(
                      builder: (context) {

                        return Container(
                          height: 100,
                          width: 280,
                          child: Column(children: [
                            Text('Please Connect to the internet.',
                                style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color: Color.fromARGB(255, 0, 0, 0)),),

                            Padding(
                              padding: const EdgeInsets.only(top: 23),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFFFEDE00),
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 100,
                                    right: 100,
                                    top: 18,
                                    bottom: 18
                                  ),
                                  child: const Text(
                                    'Okay',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                      fontFamily: 'Comfortaa',
                                      fontWeight: FontWeight.bold,
                                    ),
                                    ),
                                ),
                                ),
                            ),
                          ],),
                        );
                      },
                    ),
                    
                  ),
                ),
              ),
            ),

            
            ]);
        });
  }
  void CustomDialogFilterMenu() {
    bool? _restaurant = false;
    bool? _parking = false;
    int _rangeFrom = globals.minDistance;
    int _rangeTo = globals.maxDistance;

    bool _isAvailable = true;
    bool _isOccupied = false;
    bool _isClosed = false;

    bool _isAtherDot = true;
    bool _isAtherGrid = true;
    bool _isOther = false;
    
      switch (globals.chargerType){
        case 1: _isAtherDot = true; break;
        case 2: _isAtherGrid = true; break;
        case 4: _isOther = true; break;
        case 5: _isOther = true; _isAtherDot = true; break;
        case 6: _isOther = true; _isAtherGrid = true; break;
        case 7: _isOther = true; _isAtherDot = true; _isAtherGrid = true; break;
      }
    
    

    Color _pressed = Color(0xFF2B2D41);
    Color _unpressed = Color(0xFFF6F7F6);

    SfRangeValues _values = SfRangeValues(globals.minDistance * 20, globals.maxDistance * 20);
    showDialog(
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.0),
        context: context,
        builder: (BuildContext ctx) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Stack(
                children :<Widget>[

                  Container(
                  child: BackdropFilter(
                    blendMode: BlendMode.srcOver,
                    filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                    child: Container(
                      color: Color(0xFFC4C4C4).withOpacity(0.5),
                      child: AlertDialog(
                        titlePadding: EdgeInsets.zero,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                32.0,
                              ),
                            ),
                          ),

                        title:  
                         Stack(
                        children: [
                          
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Center(
                                  child: Text('Filters',
                                          style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 0, 0, 0)),
                                          )),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(color: Colors.transparent, height: 40,width: 40,
                            child: Stack(
                              children: [
                                Positioned(
                                  right: 0,
                                  child:  Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: new BorderRadius.circular(20.0),
                                    onTap: (() {
                                      Navigator.of(context).pop();
                                    }),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      color: Colors.transparent,
                                      child: Image.asset('assets/images/closeIcon_v2.png')
                                    ),
                                  ),
                                ),)
                              ],
                            ),),)
                        ],
                      ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 20),
                        //   child: Center(
                        //     child: Text('Filters',
                        //             style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 0, 0, 0)),
                        //             )),
                        // ),
                        content: Builder(
                          builder: (context) {

                            return Container(
                              height: 400,
                              width: 280,
                              child: Column(children: [
                                // Text('Please Connect to the internet.',
                                //     style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color: Color.fromARGB(255, 0, 0, 0)),),
                                
                                Container(
                                  height: 75,
                                  color: Colors.transparent,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text('Range',style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 0, 0, 0)),),
                                          Expanded(child: Container(),),
                                          Container(width: 100,height: 20,color: Colors.transparent,alignment: Alignment.bottomCenter,
                                            child: Text('$_rangeFrom km - $_rangeTo km',style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color: Color(0xFF4136F1)),),
                                            ),
                                        ],
                                      ),
                                      Expanded(child:  Container( height: 20,color: Colors.transparent,
                                            child:  SfRangeSlider(
                                                min: 0.0,
                                                max: 100.0,
                                                values: _values,
                                                inactiveColor: Color(0xFF4136F1).withOpacity(0.2),
                                                activeColor: Color(0xFF7740FC),
                                                interval: 20,
                                                showTicks: false,
                                                showLabels: false,
                                                stepSize: 20.0,
                                                enableTooltip: false,
                                                onChanged: (SfRangeValues values){
                                                  setState(() {
                                                    _values = values;
                                                    _rangeFrom = ((values.start)/20).round();
                                                    _rangeTo = ((values.end)/20).round();
                                                  });
                                                },
                                              ),
                                      ),),
                                    ],
                                  ),
                                ),
                                 SizedBox(height: 5,),
                                Container(
                                  height: 75,
                                  color: Colors.transparent,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text('Type of Charger',style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 0, 0, 0)),),
                                          Expanded(child: Container(),),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                          SizedBox(width: 5,),
                                          Container( width: 80, height: 35,color: Colors.transparent,
                                            child:ElevatedButton(
                                              onPressed: (){
                                                setState(() {
                                                  _isAtherDot =!_isAtherDot;
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                              primary: _isAtherDot ? _pressed : _unpressed,
                                              shadowColor: Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(25),
                                              ),
                                            ),
                                              child: Text('Ather Dot',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color:
                                              _isAtherDot ? Colors.white : Colors.black),),
                                              ),  
                                            ),
                                            Container( width: 82, height: 35,color: Colors.transparent,
                                            child:ElevatedButton(
                                              onPressed: (){
                                                setState(() {
                                                  _isAtherGrid = !_isAtherGrid;
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                              primary: _isAtherGrid ? _pressed : _unpressed,
                                              shadowColor: Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(25),
                                              ),
                                            ),
                                              child: Text('Ather Grid',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,
                                              color: _isAtherGrid ? Colors.white : Colors.black
                                              ),),
                                              ),  
                                            ),
                                            Container( width: 80, height: 35,color: Colors.transparent,
                                            child:ElevatedButton(
                                              onPressed: (){
                                                setState(() {
                                                  _isOther = !_isOther;
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                              primary: _isOther ? _pressed : _unpressed,
                                              shadowColor: Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(25),
                                              ),
                                            ),
                                              child: Text('Other',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: 
                                              _isOther ? Colors.white : Colors.black),),
                                              ),  
                                            ),
                                          SizedBox(width: 5,),
                                        ],),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Container(
                                  height: 75,
                                  color: Colors.transparent,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text('Status',style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 0, 0, 0)),),
                                          Expanded(child: Container(),),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                          SizedBox(width: 5,),
                                          Container( width: 80, height: 35,color: Colors.transparent,
                                            child:ElevatedButton(
                                              onPressed: (){
                                                setState(() {
                                                  _isAvailable = true;
                                                  _isOccupied = false;
                                                  _isClosed = false;
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                              primary: _isAvailable ? _pressed : _unpressed,
                                              shadowColor: Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(25),
                                              ),
                                            ),
                                              child: Text('Available',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color:
                                              _isAvailable ? Colors.white : Colors.black),),
                                              ),  
                                            ),
                                            Container( width: 80, height: 35,color: Colors.transparent,
                                            child:ElevatedButton(
                                              onPressed: (){
                                                setState(() {
                                                  _isAvailable = false;
                                                  _isOccupied = true;
                                                  _isClosed = false;
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                              primary: _isOccupied ? _pressed : _unpressed,
                                              shadowColor: Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(25),
                                              ),
                                            ),
                                              child: Text('Occupied',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,
                                              color: _isOccupied ? Colors.white : Colors.black
                                              ),),
                                              ),  
                                            ),
                                            Container( width: 80, height: 35,color: Colors.transparent,
                                            child:ElevatedButton(
                                              onPressed: (){
                                                setState(() {
                                                  _isAvailable = false;
                                                  _isOccupied = false;
                                                  _isClosed = true;
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                              primary: _isClosed ? _pressed : _unpressed,
                                              shadowColor: Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(25),
                                              ),
                                            ),
                                              child: Text('Closed',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: 
                                              _isClosed ? Colors.white : Colors.black),),
                                              ),  
                                            ),
                                          SizedBox(width: 5,),
                                        ],),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Container(
                                  height: 55,
                                  color: Colors.transparent,
                                  child: Column(children: [
                                    Row(children: [
                                      SizedBox(width: 20,),
                                      Container(
                                        width: 25,
                                        height: 25,
                                        color: Colors.transparent,
                                        child: Center(
                                          child: Checkbox(
                                            shape:RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(4),
                                                side: BorderSide(color: Colors.black54)
                                              ),
                                            checkColor: Colors.transparent,
                                            value: _parking,
                                            activeColor: Colors.black,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                _parking = value;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            _parking = !_parking!;
                                          });
                                        },
                                        child: Text('Restaurant nearby',
                                            style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color: Color.fromARGB(255, 0, 0, 0)),),
                                      ),
                                    ],),
                                    SizedBox(height: 5,),
                                    Row(children: [
                                      SizedBox(width: 20,),
                                      Container(
                                        width: 25,
                                        height: 25,
                                        color: Colors.transparent,
                                        child: Center(
                                          child: Checkbox(
                                            shape:RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(4),
                                                side: BorderSide(color: Colors.black54)
                                              ),
                                            checkColor: Colors.transparent,
                                            value: _restaurant,
                                            activeColor: Colors.black,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                _restaurant = value;
                                              });
                                              print('new value: $_restaurant');
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      InkWell(
                                        onTap: (){
                                          setState(() {
                                            _restaurant = !_restaurant!;
                                          });
                                        },
                                        child: Text('Parking available',
                                            style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color: Color.fromARGB(255, 0, 0, 0)),),
                                      ),
                                    ],)
                                  ]),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(top: 23),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      globals.minDistance = _rangeFrom;
                                      globals.maxDistance = _rangeTo;
                                      //charger type filter
                                      globals.chargerType = 0;
                                      if(_isAtherDot)globals.chargerType += 1;
                                      if(_isAtherGrid)globals.chargerType += 2;
                                      if(_isOther)globals.chargerType += 4;

                                      // done
                                      Navigator.of(ctx).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xFFFEDE00),
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 100,
                                        right: 100,
                                        top: 18,
                                        bottom: 18
                                      ),
                                      child: const Text(
                                        'Apply',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black,
                                          fontFamily: 'Comfortaa',
                                          fontWeight: FontWeight.bold,
                                        ),
                                        ),
                                    ),
                                    ),
                                ),
                              ],),
                            );
                          },
                        ),
                        
                      ),
                    ),
                  ),
                ),

                // Align(
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Container(
                //           width: 330,
                //           height: 40,
                //           child: Row(
                //             children: [
                //               Expanded(child: Container(
                //                 color: Colors.transparent,
                //               ),),
                //               Material(
                //                 color: Colors.transparent,
                //                 child: InkWell(
                //                   borderRadius: new BorderRadius.circular(20.0),
                //                   onTap: (() {
                //                     Navigator.of(context).pop();
                //                   }),
                //                   child: Container(
                //                     width: 40,
                //                     height: 40,
                //                     color: Colors.transparent,
                //                     child: Image.asset('assets/images/closeIcon_v2.png')
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //         SizedBox(height: 470),
                        
                //       ],
                //     ),
                //   ),
                ]);
            }
          );
        });
  }
  void CustomDialogAskRange() {
    TextEditingController _rangeController = new TextEditingController();
    showDialog(
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.0),
        context: context,
        builder: (BuildContext ctx) {
          return Stack(
            children :<Widget>[

            Container(
              child: BackdropFilter(
                blendMode: BlendMode.srcOver,
                filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                child: Container(
                  alignment: Alignment.center,
                  color: Color(0xFFC4C4C4).withOpacity(0.5),
                  child: StatefulBuilder(builder: (context, _setState) => AlertDialog(
                      titlePadding: EdgeInsets.zero,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              32.0,
                            ),
                          ),
                        ),

                      title:  Stack(
                        children: [
                          
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Center(
                                  child: Text('Range',
                                          style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 0, 0, 0)),
                                          )),
                              ),
                            ],
                          ),
                          // Positioned(
                          //   top: 0,
                          //   right: 0,
                          //   child: Container(color: Colors.transparent, height: 40,width: 40,
                          //   child: Stack(
                          //     children: [
                          //       Positioned(
                          //         right: 0,
                          //         child:  Material(
                          //         color: Colors.transparent,
                          //         child: InkWell(
                          //           borderRadius: new BorderRadius.circular(20.0),
                          //           onTap: (() {
                          //             Navigator.of(context).pop();
                          //           }),
                          //           child: Container(
                          //             width: 40,
                          //             height: 40,
                          //             color: Colors.transparent,
                          //             child: Image.asset('assets/images/closeIcon_v2.png')
                          //           ),
                          //         ),
                          //       ),)
                          //     ],
                          //   ),),)
                        ],
                      ),
                      content: Builder(
                        builder: (context) {

                          return Container(
                            height: 150,
                            width: 280,
                            child: Column(children: [
                              Container(height: 45,
                              width: 260,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius:  BorderRadius.circular(5),
                                  border: Border.all(color: Color.fromARGB(255, 0, 0, 0), width: 1)
                                ),
                              child: TextField(
                                maxLength: 10,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                readOnly: false,
                                controller: _rangeController,
                                style: TextStyle(fontSize: 15.5,color: Color.fromARGB(255, 0, 0, 0)),
                                onTap: (){
                                },
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 15,color: Color(0xFFBFBFBF)),
                            hintText: 'may I know the current range?',
                            suffixText: ' Km        ',
                               
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 20,top: 7,bottom: 15),
                            counterText: '',
                          ),
                        ),
                              ),
                              
                              SizedBox(height: 20),

                              Padding(
                                padding: const EdgeInsets.only(top: 10, bottom: 10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    globals.currentRange = int.parse(_rangeController.text); 
                                    setUpChargersInRoute();
                                    Navigator.of(context).pop();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFFFEDE00),
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 50,
                                      right: 50,
                                      top: 18,
                                      bottom: 18
                                    ),
                                    child: const Text(
                                      'Show Chargers',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontFamily: 'Comfortaa',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      ),
                                  ),
                                  ),
                              ),
                            ],),
                          );
                        },
                      ),
                      
                    ),
                  ),
                ),
              ),
            ),

            ]);
        }
        );
  }
  void CustomDialogAskName() {
    TextEditingController _nameController = new TextEditingController();
    showDialog(
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.0),
        context: context,
        builder: (BuildContext ctx) {
          return Stack(
            children :<Widget>[

            Container(
              child: BackdropFilter(
                blendMode: BlendMode.srcOver,
                filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                child: Container(
                  alignment: Alignment.center,
                  color: Color(0xFFC4C4C4).withOpacity(0.5),
                  child: StatefulBuilder(builder: (context, _setState) => AlertDialog(
                      titlePadding: EdgeInsets.zero,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              32.0,
                            ),
                          ),
                        ),

                      title:  Stack(
                        children: [
                          
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Center(
                                  child: Text('About you',
                                          style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 0, 0, 0)),
                                          )),
                              ),
                            ],
                          ),
                          // Positioned(
                          //   top: 0,
                          //   right: 0,
                          //   child: Container(color: Colors.transparent, height: 40,width: 40,
                          //   child: Stack(
                          //     children: [
                          //       Positioned(
                          //         right: 0,
                          //         child:  Material(
                          //         color: Colors.transparent,
                          //         child: InkWell(
                          //           borderRadius: new BorderRadius.circular(20.0),
                          //           onTap: (() {
                          //             Navigator.of(context).pop();
                          //           }),
                          //           child: Container(
                          //             width: 40,
                          //             height: 40,
                          //             color: Colors.transparent,
                          //             child: Image.asset('assets/images/closeIcon_v2.png')
                          //           ),
                          //         ),
                          //       ),)
                          //     ],
                          //   ),),)
                        ],
                      ),
                      content: Builder(
                        builder: (context) {

                          return Container(
                            height: 170,
                            width: 280,
                            child: Column(children: [
                              Container(height: 45,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius:  BorderRadius.circular(5),
                                  border: Border.all(color: Color.fromARGB(255, 0, 0, 0), width: 1)
                                ),
                              child: TextField(
                                maxLength: 42,
                                readOnly: false,
                                controller: _nameController,
                                style: TextStyle(fontSize: 15.5,color: Color.fromARGB(255, 0, 0, 0)),
                                onTap: () async {

                                },
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 15,color: Color(0xFFBFBFBF)),
                            hintText: 'what do we call you ?',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 20,top: 7,bottom: 15),
                            counterText: '',
                          ),
                        ),
                              ),
                              
                              Padding(
                                padding: const EdgeInsets.only(top: 25),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Container(width: 25,height: 25, color: Colors.transparent,
                                      child: Checkbox(
                                              shape:RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(4),
                                                  side: BorderSide(color: Colors.black54)
                                                ),
                                              checkColor: Colors.transparent,
                                              value: globals.terms,
                                              activeColor: Colors.black,
                                              onChanged: (bool? value) {
                                                _setState(() {
                                                  globals.terms = value;
                                                });
                                              },
                                            ),
                                      ),
                                    ),
                                    Material(
                                      child: InkWell(
                                        onTap: () {
                                          print('tapped on terms');
                                          Navigator.push(context, SlideRightRoute(page: TermsPage()),);
                                        },
                                        child: Text('Terms and Conditions',
                                            style: TextStyle(decoration: TextDecoration.underline,
                                              fontSize: 14,fontWeight: FontWeight.normal, color: Color.fromARGB(255, 0, 0, 0)),),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 10, bottom: 10),
                                child: ElevatedButton(
                                  onPressed: globals.terms! ? () async{
                                      setState(() {
                                        globals.isFirstTime = false;
                                        globals.termsAccepted = true;
                                        globals.userName = _nameController.text;
                                        globals.canAskName = false;
                                        // _canShow = false;
                                      });
                                      
                                        await ethUtils.setUserDetails();
                                      Navigator.of(ctx).pop();
                                  } : null,
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFFFEDE00),
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 50,
                                      right: 50,
                                      top: 18,
                                      bottom: 18
                                    ),
                                    child: const Text(
                                      'Lets start...',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontFamily: 'Comfortaa',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      ),
                                  ),
                                  ),
                              ),
                            ],),
                          );
                        },
                      ),
                      
                    ),
                  ),
                ),
              ),
            ),

            ]);
        }
        );
  }
  void CustomDialogDetails() {
    TextEditingController _nameController = new TextEditingController();
    String _text = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Volutpat eu, consectetur sed in tincidunt turpis volutpat, nunc. Purus suspendisse purus nibh nam nisl egestas sed. Facilisis enim urna morbi.';
    showDialog(
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.0),
        context: context,
        builder: (BuildContext ctx) {
          return Stack(
            children :<Widget>[

            Container(
              child: BackdropFilter(
                blendMode: BlendMode.srcOver,
                filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                child: Container(
                  alignment: Alignment.center,
                  color: Color(0xFFC4C4C4).withOpacity(0.5),
                  child: StatefulBuilder(builder: (context, _setState) => AlertDialog(
                      titlePadding: EdgeInsets.zero,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              32.0,
                            ),
                          ),
                        ),

                      title:  Stack(
                        children: [
                          
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Center(
                                  child: Text('Ather ${globals.chargerName}',
                                          style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 0, 0, 0)),
                                          )),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(color: Colors.transparent, height: 40,width: 40,
                            child: Stack(
                              children: [
                                Positioned(
                                  right: 0,
                                  child:  Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: new BorderRadius.circular(20.0),
                                    onTap: (() {
                                      Navigator.of(context).pop();
                                    }),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      color: Colors.transparent,
                                      child: Image.asset('assets/images/closeIcon_v2.png')
                                    ),
                                  ),
                                ),)
                              ],
                            ),),)
                        ],
                      ),
                      content: Builder(
                        builder: (context) {

                          return Container(
                            height: 278,
                            width: 280,
                            child: Column(children: [
                               SizedBox(height: 5,),
                              Container(
                                height: 35,
                                width: double.infinity,
                                color: Colors.transparent,
                                child: Container(
                                  height: 35,
                                  width: double.infinity,
                                  color: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.transparent,
                                          border: Border.all(color: Color(0xFF2A2A2A).withOpacity(0.25), width: 1.2),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(width: 2,),
                                            Icon(Icons.star, color: Color(0xFFFFE033), size: 20,),
                                            Text('4.3', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700,color: Colors.black.withOpacity(0.5)),),
                                            SizedBox(width: 2,),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 15,),
                                      Container(
                                        width: 50,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.transparent,
                                          border: Border.all(color: Color(0xFF2A2A2A).withOpacity(0.25), width: 1.2),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('\$0.99', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700,color: Colors.black.withOpacity(0.5)),),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 15,),
                              Container(
                                height: 20,
                                width: double.infinity,
                                color: Colors.transparent,
                                child: Text(globals.chargerAddress, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Colors.black.withOpacity(0.3)),),
                              ),
                              SizedBox(height: 5,),
                              Container(
                                height: 88,
                                width: double.infinity,
                                color: Colors.transparent,
                                child: Text(_text, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.8)),),
                              ),
                              SizedBox(height: 8,),
                              Container(
                                height: 20,
                                width: double.infinity,
                                color: Colors.transparent,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(width: 5,),
                                    Container(
                                      width: 60,
                                      height: double.infinity,
                                      alignment: Alignment.center,
                                      color: Colors.transparent,
                                      child: Text('parking', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.4)),)),
                                    SizedBox(width: 5,
                                    child: VerticalDivider(
                                      color: Colors.black.withOpacity(0.1),
                                      thickness: 1,
                                    ),),
                                      Container(
                                      width: 60,
                                      height: double.infinity,
                                      alignment: Alignment.center,
                                      color: Colors.transparent,
                                      child: Text('restaurant', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.4)),)),
                                    SizedBox(width: 5,
                                    child: VerticalDivider(
                                      color: Colors.black.withOpacity(0.1),
                                      thickness: 1,
                                    ),),
                                      Container(
                                      width: 60,
                                      height: double.infinity,
                                      alignment: Alignment.center,
                                      color: Colors.transparent,
                                      child: Text('24/7', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.4)),)),
                                       SizedBox(width: 5,),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8,),
                             

                              Padding(
                                padding: const EdgeInsets.only(top: 10, bottom: 10),
                                child: ElevatedButton(
                                  onPressed:() {
                                      setState(() {
                                        
                                      });
                                      redirectToGoogleMap(_intermediateCharger);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFFFEDE00),
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 60,
                                      right: 60,
                                      top: 18,
                                      bottom: 18
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Start',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black,
                                          fontFamily: 'Comfortaa',
                                          fontWeight: FontWeight.bold,
                                        ),
                                        ),
                                    ),
                                  ),
                                  ),
                              ),
                            ],),
                          );
                        },
                      ),
                      
                    ),
                  ),
                ),
              ),
            ),

            ]);
        }
        );
  }
}


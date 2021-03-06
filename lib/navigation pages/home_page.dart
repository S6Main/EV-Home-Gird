// import 'dart:ffi';
// import 'dart:developer' as dev;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ev_homegrid/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'Map/locations.dart' as _locations;
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../widgets/BottomInfoPanel.dart';
import '../widgets/MapPointerBadge.dart';

const LatLng SOURCE_LOCATION = LatLng(42.7477863, -71.1699932);
const LatLng DEST_LOCATION = LatLng(42.744421, -71.1698939);
const double CAMERA_ZOOM = 15;
const double CAMERA_TILT = 20;
const double CAMERA_BEARING = 30;
const double PIN_VISIBLE_POSITION = 0;
const double PIN_INVISIBLE_POSITION = -250;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleMapController? _googleMapController;

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

  List<BottomInfoPanel> _bottonInfoPanels = [];

  String googleApiKey = 'AIzaSyCV_x2q82h5TjN5py9HS7Fx7bxV1Wgr_K8';

  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> _polylineCoordinates = [];
  late PolylinePoints _polylinePoints;

  CarouselController bottonCarouselController = CarouselController();

  //ValueNotifier<int> _changeInIndex =ValueNotifier(0);  // used to notify the carousel to change the index

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

  @override
  void dispose() {
    super.dispose();
  }

  void setSourceAndDestinationMarker() async {
    _sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0),
        'assets/images/icons8-map-a-96.png');

    _destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0),
        'assets/images/icons8-marker-b-96.png');

    _markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0),
        'assets/images/icons8-location-96.png');

    _pinIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0),
        'assets/images/icons8-map-pin-96.png');
  }

  void setIntitialLocation() {
    _currentLocation =
        LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude);

    _destinationLocation =
        LatLng(DEST_LOCATION.latitude, DEST_LOCATION.longitude);
  }

  void showCurrentPinOnMap() {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: _currentLocation,
          icon: _pinIcon,
          infoWindow: InfoWindow(title: 'Your Location'),
          onTap: () {
            removePolylines();
            setState(() {
              _destSelected = false;
              if (_sourcSelected) {
                removeMarkers();
                _canShowButton = true;
              }
              _sourcSelected = true;
              this._userBadgeSelected = true;
              this._pinPillPosition = PIN_INVISIBLE_POSITION;
            });
          }));
    });
  }

  void removeDestinationMarker() {
    setState(() {
      _markers.removeWhere((m) => m.markerId.value == _currentMarkerId);
      if (_sourcSelected) {
        _lastSelectedMarker = null;
      }
      _markers.add(_lastSelectedMarker!);
    });
  }

  void replaceDestinationMarker(String value, LatLng location) {
    //case 1 - no previous marker
    if (_lastSelectedMarker == null) {
      _lastSelectedMarker =
          _markers.firstWhere((marker) => marker.markerId.value == value);
      _markers.remove(_lastSelectedMarker);
      _destinationLocation = location;

      //remove old marker_0
      showDestinationPinOnMap();
      //add new markerB
    } else {
      //case 2 - have previous marker
      _markers.removeWhere((m) => m.markerId.value == _currentMarkerId);

      //_currentMarkerId = value;
      //remove old markerB
      _markers.add(_lastSelectedMarker!);
      //add new marker_0

      _lastSelectedMarker =
          _markers.firstWhere((marker) => marker.markerId.value == value);
      _markers.remove(_lastSelectedMarker);
      _destinationLocation = location;
      //remove old marker_1
      showDestinationPinOnMap();
      //add new markerB
    }
  }

  void showDestinationPinOnMap() {
    _sourcSelected = false;
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId(_currentMarkerId),
          position: _destinationLocation,
          icon: _destinationIcon,
          infoWindow: InfoWindow(title: _destinationName),
          onTap: () {
            removePolylines();
            setState(() {
              _destSelected = false;
              this._userBadgeSelected = false;
              this._pinPillPosition = PIN_INVISIBLE_POSITION;
            });
          }));
    });
  }

  void showPinsOnMap() {
    //Marker? resultMarker = null;
    List<Marker> resultMarker = [];

    for (int i = 0; i < _locations.locations.length; i++) {
      resultMarker.add(Marker(
          markerId: MarkerId(_locations.locations[i].id),
          infoWindow: InfoWindow(title: "${_locations.locations[i].name}"),
          position: _locations.locations[i].coordinates,
          icon: _markerIcon,
          onTap: () {
            _onSlider = false;

            if (!_onSlider) {
              //change destination name
              _destinationName = _locations.locations[i].name;
              //get index of marker
              int _index = _locations.locations.indexWhere(
                  (location) => location.id == resultMarker[i].markerId.value);
              bottonCarouselController.animateToPage(_index,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
              _onSlider = true;

              replaceDestinationMarker(_locations.locations[i].id,
                  _locations.locations[i].coordinates);

              // _currentMarkerId = _locations.locations[i].id;
              // print('current marker id: $_currentMarkerId');
              // if(_destSelected){
              //   removePolylines();
              // }
              //removePolylines();
              _destinationLocation = _locations.locations[i].coordinates;
              _destSelected = true;
              setPolylines();
              setState(() {
                this._userBadgeSelected = false;
                this._pinPillPosition = PIN_VISIBLE_POSITION;
              });
              // _destinationLocation = _locations.locations[i].coordinates;
              // _destSelected = true;
              // setPolylines();
              // setState(() {
              //   this._userBadgeSelected = false;
              //   this._pinPillPosition = PIN_VISIBLE_POSITION;
              // });
            }
          }));

      if (_locations.locations.length > 0) {
        setState(() {
          _markers.addAll(resultMarker);
        });
      }

      //add bottom info panel set
      _bottonInfoPanels.add(BottomInfoPanel(
        title: _locations.locations[i].name,
        index: i,
        id: _locations.locations[i].id,
      ));
    }
  }

  void removeMarkers() {
    setState(() {
      _markers.removeWhere((m) => m.markerId.value != 'sourcePin');
    });
  }

  changeMapMode() {
    getJsonFile("assets/light.json").then(setMapStyle);
  }

  Future<String> getJsonFile(String path) async {
    String val = await rootBundle.loadString(path);
    return val;
    //get json file path
  }

  void setMapStyle(String mapStyle) {
    _googleMapController?.setMapStyle(mapStyle);
  }

  void setPolylines() async {
    removePolylines(); // clear polylines

    //change origin icon
    _sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0),
        'assets/images/icons8-map-a-96.png');

    PolylineResult _results = await _polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(_currentLocation.latitude, _currentLocation.longitude),
      PointLatLng(
          _destinationLocation.latitude, _destinationLocation.longitude),
      travelMode: TravelMode.driving,
    );
    if (_results.status == 'OK') {
      _results.points.forEach((PointLatLng _point) {
        _polylineCoordinates.add(LatLng(_point.latitude, _point.longitude));
      });

      setState(() {
        _polylines.add(Polyline(
          width: 3,
          polylineId: PolylineId('polyline'),
          color: Globals.MAIN_COLOR,
          points: _polylineCoordinates,
          startCap: Cap.buttCap,
          endCap: Cap.buttCap,
        ));
      });
    }
  }

  void removePolylines() {
    _polylineCoordinates.clear(); //prevent from forming a loop
    _polylines.clear();
  }

  void changeMarkerSelection() {
    Future.delayed(Duration(milliseconds: 150), () {
      Marker _marker = _markers.firstWhere((marker) =>
          marker.markerId.value == _bottonInfoPanels[_currentMarkerIndex].id);
      _marker.onTap!();

      _googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _marker.position,
          zoom: CAMERA_ZOOM,
          tilt: CAMERA_TILT,
          bearing: CAMERA_BEARING,
        ),
      ));
    });
  }

  void animateCamera(Set<Polyline> polylines) {
    print('animateCamera');
    if (_polylines != null) {
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
  }

  @override
  Widget button(VoidCallback function, IconData icon) {
    return FloatingActionButton(
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.black,
      child: Icon(
        icon,
        size: 24.0,
      ),
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
        children: [
          Positioned.fill(
            child: GoogleMap(
              myLocationButtonEnabled: true,
              compassEnabled: false,
              tiltGesturesEnabled: false,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              markers: _markers,
              polylines: _polylines,
              mapType: MapType.normal,
              initialCameraPosition: _initialCameraPosition,
              onTap: (LatLng loc) {
                if (_destSelected) {
                  if (_polylines.isEmpty) {
                    removeDestinationMarker(); // remove dest marker when tapped
                  } else {
                    animateCamera(
                        _polylines); //animate camera to initial position from top
                  }
                } else {
                  _googleMapController?.animateCamera(
                    CameraUpdate.newCameraPosition(_initialCameraPosition),
                  );
                }

                if (_polylines.isEmpty) {
                  removeDestinationMarker(); // remove dest marker when tapped
                }
                _sourcSelected = false;
                _onSlider = false;
                //removePolylines();
                //tapping on the map will dismiss the bottom pill
                setState(() {
                  this._pinPillPosition = PIN_INVISIBLE_POSITION;
                  this._userBadgeSelected = false;
                });
              },
              onMapCreated: (GoogleMapController controller) {
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
              child: MapPointerBadge(
                isSelected: _userBadgeSelected,
              )),
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

          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            left: 0,
            right: 0,
            bottom: this._pinPillPosition,
            child: SlidingUpPanel(
              parallaxEnabled: true,
              parallaxOffset: .5,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              panel: Center(
                child: Text("This is the sliding Widget"),
              ),
            ),
          ),

          Column(
            children: [
              Expanded(child: SizedBox()),
              Center(
                child: !_canShowButton
                    ? const SizedBox.shrink()
                    : AnimatedButton(
                        height: 45,
                        width: 200,
                        text: 'Find Nearest',
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
                        borderRadius: 50,
                        borderWidth: 0,
                        onPress: () {
                          showPinsOnMap();
                          _canShowButton = false;
                        },
                      ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          )
        ],
      ),
    );
  }
}

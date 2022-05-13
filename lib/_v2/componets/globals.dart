library my_prj.globals;

import 'dart:collection';
import 'dart:ui';

import 'package:google_maps_flutter/google_maps_flutter.dart';

String googleApiKey = 'AIzaSyCV_x2q82h5TjN5py9HS7Fx7bxV1Wgr_K8';

bool isLoggedIn = false;
bool isOnline = false;
int currentIndex = 0;
bool isFirstTime = true;
bool isNameAsked = false;
bool termsAccepted = false;
String name = '';
//color properties
Color MAIN_COLOR = Color(0xFF70e000);


//google map
Queue queueID = new Queue();
Queue queuePlace = new Queue();

LatLng startLocation = LatLng(0, 0);
LatLng endLocation = LatLng(0, 0);
LatLng currentLocation = LatLng(0, 0);
String travelRoute = '';
num distance = 0;

int minDistance = 1; //filters
int maxDistance = 3; 

//ev
num currentRange = 5;
num maxRange = 8;
int cutOff = 20; // 20%

//manual editings
bool canExit = false;
bool accessPermision = true;
bool askRange = true;
bool needToUplocadLocations = true;
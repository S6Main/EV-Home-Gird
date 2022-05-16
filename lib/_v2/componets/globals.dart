library my_prj.globals;

import 'dart:collection';
import 'dart:ui';

import 'package:google_maps_flutter/google_maps_flutter.dart';

String googleApiKey = 'AIzaSyCV_x2q82h5TjN5py9HS7Fx7bxV1Wgr_K8';

bool isLoggedIn = false;
bool isAutherized = false;
bool isOnline = false;
bool isWaiting = false;
int currentIndex = 0;
bool isFirstTime = true;
bool isNameAsked = false;
bool termsAccepted = false;
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
bool? terms = false;
bool canAskName = true;

int minDistance = 1; //filters
int maxDistance = 3; 
int chargerType = 3;

//charger
String chargerName = '';
String chargerAddress = 'empty';

//ev
num currentRange = 5;
num maxRange = 8;
int cutOff = 20; // 20%

//web3dart
String publicKey = '';
String privateKey = '';
bool repeatCheck = false;
bool letUserKnow = true;

String userName = '';
int userId = 0;

//manual editings
bool canExit = false;
bool accessPermision = true;
bool askRange = true;
bool needToUplocadLocations = true;
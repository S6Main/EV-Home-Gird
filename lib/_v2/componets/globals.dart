library my_prj.globals;

import 'dart:collection';

String googleApiKey = 'AIzaSyCV_x2q82h5TjN5py9HS7Fx7bxV1Wgr_K8';

bool isLoggedIn = false;
bool isOnline = false;
int currentIndex = 0;
bool isFirstTime = true;
bool isNameAsked = false;
bool termsAccepted = false;
String name = '';

//google map
Queue queueID = new Queue();
Queue queuePlace = new Queue();

//manual editings
bool canExit = false;
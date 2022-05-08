import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../componets/globals.dart' as globals;


void locating(String address, bool isStart) async {
  
    List<Location> locations = await locationFromAddress(address);

    if(isStart){
      // print('status: start');
      // print('status : start location: ${locations[0].latitude} ${locations[0].longitude}');
      globals.startLocation = LatLng(locations[0].latitude, locations[0].longitude);
    }
    else{
      // print('status: end');
      // print('status : end location: ${locations[0].latitude} ${locations[0].longitude}');
      globals.endLocation = LatLng(locations[0].latitude, locations[0].longitude);
    }
  }
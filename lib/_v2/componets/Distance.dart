import 'package:maps_toolkit/maps_toolkit.dart';
import '../componets/globals.dart' as globals;

num getDistance(List end,{bool isCurrentLocation = true}) {
  num _distance = 0;
  // globals.distance = double.parse((distance/1000).toStringAsFixed(2));
  if(isCurrentLocation){
    _distance = SphericalUtil.computeDistanceBetween(
    LatLng(globals.currentLocation.latitude, globals.currentLocation.longitude), 
    LatLng(end[0], end[1]));

    globals.distance = double.parse((_distance/1000).toStringAsFixed(2));
    
  return SphericalUtil.computeDistanceBetween(
    LatLng(globals.currentLocation.latitude, globals.currentLocation.longitude), 
    LatLng(end[0], end[1]));
  }
  else{
    _distance = SphericalUtil.computeDistanceBetween(
    LatLng(globals.startLocation.latitude, globals.startLocation.longitude), 
    LatLng(end[0], end[1]));
    
    globals.distance = double.parse((_distance/1000).toStringAsFixed(2));

  return SphericalUtil.computeDistanceBetween(
    LatLng(globals.startLocation.latitude, globals.startLocation.longitude), 
    LatLng(end[0], end[1]));
  }
  
}

num distanceToFrom(List start, List end) {
  num _distance = SphericalUtil.computeDistanceBetween(
    LatLng(start[0], start[1]),
    LatLng(end[0], end[1]));
    //  print('status: distance is ${_distance.toString()}');
  return _distance;
}
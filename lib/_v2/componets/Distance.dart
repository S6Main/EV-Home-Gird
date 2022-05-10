import 'package:maps_toolkit/maps_toolkit.dart';
import '../componets/globals.dart' as globals;

num getDistance(List end,{bool isCurrentLocation = true}) {
  if(isCurrentLocation){
    globals.distance = SphericalUtil.computeDistanceBetween(
    LatLng(globals.currentLocation.latitude, globals.currentLocation.longitude), 
    LatLng(end[0], end[1]));
    
  return SphericalUtil.computeDistanceBetween(
    LatLng(globals.currentLocation.latitude, globals.currentLocation.longitude), 
    LatLng(end[0], end[1]));
  }
  else{
    globals.distance = SphericalUtil.computeDistanceBetween(
    LatLng(globals.startLocation.latitude, globals.startLocation.longitude), 
    LatLng(end[0], end[1]));
    
  return SphericalUtil.computeDistanceBetween(
    LatLng(globals.startLocation.latitude, globals.startLocation.longitude), 
    LatLng(end[0], end[1]));
  }
  
}

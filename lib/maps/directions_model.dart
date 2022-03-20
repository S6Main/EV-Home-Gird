

import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Directions{
  
  final LatLngBounds? bounds;
  final List<PointLatLng>? polyLinePoints;
  final String? totalDistance;
  final String? totalDuration;

  const Directions(  {this.polyLinePoints, this.totalDistance,this.totalDuration,this.bounds}); 

    static Directions? fromMap(Map<String, dynamic> map) {
    //factory Directions.fromMap(Map<String, dynamic> map){
      // check route is not available
    if ((map['route'] as List).isEmpty) return null;

      //get route information
    final data = Map<String, dynamic>.from(map['route'][0]);

      //Bounds
    final northeast = data['bounds']['northeast'];
    final southeast = data['bounds']['southeast'];
    final bounds = LatLngBounds(
      northeast: LatLng(northeast['lat'], northeast['lng']),
      southwest: LatLng(southeast['lat'], southeast['lng'])
      );

    //Distance and Duration
    String distance = '';
    String duration = '';
    if((data['legs'] as List).isNotEmpty){
      final leg = data['legs'][0];
      distance = leg['distance']['text'];
      duration = leg['duration']['text'];
    }
    return Directions(
      bounds: bounds,
      polyLinePoints: PolylinePoints().decodePolyline(data['routes'][0]['overview_polyline']['points']),
      totalDistance: distance,
      totalDuration: duration,
    );
  }

    
} 
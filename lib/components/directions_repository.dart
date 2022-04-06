import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '.env.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'directions_model.dart';

class DirectionsRepository {
  static const String _baseUrl = 'https://maps.googleapis.com/maps/api/directions/json?';
  final Dio _dio;

  

  //DirectionsRepository(this.dio);
  DirectionsRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<Directions?> getDirections(
      {required LatLng origin, 
      required LatLng destination}) async {
        final responce = await _dio.get(
          _baseUrl,
          queryParameters: {
            'origin' : '${origin.latitude},${origin.longitude}',
            'destination' : '${destination.latitude},${destination.longitude}',
            'key' : googleAPIKey,
          },
        );
    print('status code  ${responce.statusCode}');
    print('data responce  ${responce.data}');
    //check response is successful
    if(responce.statusCode == 200) {
      return Directions.fromMap(responce.data);
    }
    return null;
  }    
}
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location {
  final LatLng coordinates;
  final String name;
  final String id;

  Location(this.coordinates, this.name, this.id);
}

List<Location> locations = [
  Location(LatLng(42.748222, -71.166016), "KFC",'1000'),
  Location(LatLng(42.750766, -71.169552), "McDonald's",'1001'),
  Location(LatLng(42.745506, -71.165348), "Subway",'1002'),
  Location(LatLng(42.745890, -71.177058), "Starbucks",'1003'),
];
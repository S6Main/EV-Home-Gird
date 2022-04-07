import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location {
  final LatLng coordinates;
  final String name;

  Location(this.coordinates, this.name);
}

List<Location> locations = [
  Location(LatLng(42.748222, -71.166016), "KFC"),
  Location(LatLng(42.750766, -71.169552), "McDonald's"),
  Location(LatLng(42.745506, -71.165348), "Subway"),
  Location(LatLng(42.745890, -71.177058), "Starbucks")
];
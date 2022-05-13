import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:map_launcher/map_launcher.dart';
class MapUtils {

  MapUtils._();

  static Future<void> openMap(LatLng _destination, LatLng _source) async {

    // String url ='https://www.google.com/maps/dir/?api=1&origin=$latitudeS,$longitudeS&destination=$latitudeD,$longitudeD&travelmode=driving&dir_action=navigate';
    // // String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    // // ignore: deprecated_member_use
    // if (await canLaunch(url)) {
    //   // ignore: deprecated_member_use
    //   await launch(url);
    // } else {
    //   throw 'Could not open the map.';
    // }

    final availableMaps = await MapLauncher.installedMaps;
    print(availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

    // await availableMaps.first.showMarker(
    //   coords: Coords(37.759392, -122.5107336),
    //   title: "Ocean Beach",
    // );
    await availableMaps.first.showDirections(
      destination: Coords(_destination.latitude, _destination.longitude),
      origin: Coords(_source.latitude, _source.longitude),
    );
  }
}
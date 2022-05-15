import 'package:code_builder/code_builder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../componets/globals.dart' as globals;

class Location {
  final LatLng coordinates;
  final String name;
  final String id;
  final String address;
  final String type;
  final int status;
  final int rp;
  String time;

  Location(this.coordinates, this.name, this.id,  {this.type = 'Ather Dot',this.address = '0x..hd',this.time = '0',this.status = 1,this.rp = 3,});

  get location => null;
}
// List<Location> locations = [];

void setUpLocations(String id, String name, LatLng coordinates,String _type,String _address,int _status,int _rp) {
  // print('status : setup locations');
  if(globals.needToUplocadLocations){
    //code to upload locations to blockchain
  }
  //code to get locations from blockchain - later called
  locations.add(Location(coordinates, name, id, type: _type,address: _address,status: _status,rp: _rp));
  print('status : length - ${locations.length}');

}

// List<Location> locations = [
//   Location(LatLng(42.748222, -71.166016), "KFC",'1000'),
//   Location(LatLng(42.750766, -71.169552), "McDonald's",'1001'),
//   Location(LatLng(42.745506, -71.165348), "Subway",'1002'),
//   Location(LatLng(42.745890, -71.177058), "Starbucks",'1003'),
// ];

List<Location> locations = [
  // Location(LatLng(10.015768, 76.341449), "G01",'0'),
  Location(LatLng(10.036774, 76.408665), "D02",'1'), //kzm
  Location(LatLng(10.025036, 76.449896), "D03",'2'), //ptm
  // Location(LatLng(10.039975, 76.440208), "G04",'3'),

  //home to kolenchery points
  // Location(LatLng(10.029139, 76.437242 ), "D01",'4'),
  // Location(LatLng(10.029731, 76.449688 ), "D02",'5'),
  Location(LatLng(10.020349, 76.445654 ), "D03",'6'),
  Location(LatLng(10.016376, 76.457155 ), "D04",'7'),
  Location(LatLng(10.004881, 76.453378 ), "D05",'8'),
  Location(LatLng(10.002176, 76.462133 ), "D06",'9'),
  Location(LatLng(9.992287, 76.471231 ), "D07",'10'),
  Location(LatLng(9.985102, 76.468828 ), "D08",'11'),

];

// 10.029139, 76.437242 
//10.029731, 76.449688
//10.020349, 76.445654
//10.016376, 76.457155
//10.004881, 76.453378
//10.002176, 76.462133
//9.992287, 76.471231
//9.985102, 76.468828
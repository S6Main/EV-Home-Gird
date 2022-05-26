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

  Location(this.coordinates, this.name, this.id,  {this.type = 'Ather Dot',this.address = '0x3D98F217efB092583C8a06672CCa63A2134C7D60',this.time = '0',this.status = 1,this.rp = 3,});

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
//kalamassery -> aluva route
List<Location> locations = [
  Location(LatLng(10.106116, 76.356197), "D01",'1'),
  Location(LatLng(10.104743, 76.351927), "D02",'2'),
  Location(LatLng(10.103151, 76.347777), "D03",'3'),
  Location(LatLng(10.101872, 76.348101), "D04",'4'),
  Location(LatLng(10.102120, 76.350375), "D05",'5'),
  Location(LatLng(10.098479, 76.348372), "D06",'6'),
  Location(LatLng(10.098976, 76.345936), "D07",'7'),
  Location(LatLng(10.097377, 76.347344), "D08",'8'),
  Location(LatLng(10.096206, 76.345775), "D09",'9'),
  Location(LatLng(10.095150, 76.346901), "D10",'10'),
  Location(LatLng(10.095721, 76.345501), "D11",'11'),
  Location(LatLng(10.094892, 76.346844), "D12",'12'),
  Location(LatLng(10.093159, 76.346715), "D13",'13'),
  Location(LatLng(10.093383, 76.345668), "D14",'14'),
  Location(LatLng(10.092330, 76.346214), "D15",'15'),
  Location(LatLng(10.091284, 76.344340), "D16",'16'),
  Location(LatLng(10.088596, 76.344735), "D17",'17'),
  Location(LatLng(10.087752, 76.341306), "D18",'18'),
  Location(LatLng(10.086078, 76.343028), "D19",'19'),
  Location(LatLng(10.085780, 76.341056), "D20",'20'),
  Location(LatLng(10.080753, 76.338225), "D21",'21'),
  Location(LatLng(10.079019, 76.338072), "D22",'22'),
  Location(LatLng(10.075678, 76.338021), "D23",'23'),
  Location(LatLng(10.073416, 76.333390), "D24",'24'),
  // Location(LatLng(10.071605, 76.331902), "D25",'25'),
  Location(LatLng(10.063788, 76.325360), "D26",'26'),
  Location(LatLng(10.060301, 76.321435), "D27",'27'),
  Location(LatLng(10.055251, 76.322405), "D28",'28'),
  Location(LatLng(10.051520, 76.318653), "D29",'29'),
  Location(LatLng(10.052223, 76.320299), "D30",'30'),
  Location(LatLng(10.049334, 76.318105), "D31",'31'),
  Location(LatLng(10.046796, 76.319840), "D32",'32'),
  Location(LatLng(10.041601, 76.328959), "D33",'33'),
  Location(LatLng(10.044821, 76.327987), "D34",'34'),
];





  //10.106116, 76.356197
  //10.104743, 76.351927
  //10.102120, 76.350375
  //10.103151, 76.347777
  //10.101872, 76.348101
  //10.098479, 76.348372
  //10.098976, 76.345936
  //10.097377, 76.347344
  //10.096206, 76.345775
  //10.095150, 76.346901
  //10.095721, 76.345501
  //10.094892, 76.346844
  //10.093159, 76.346715
  //10.093383, 76.345668
  //10.092330, 76.346214
  //10.091284, 76.344340
  //10.088596, 76.344735
  //10.087752, 76.341306
  //10.086078, 76.343028
  //10.085780, 76.341056
  //10.080753, 76.338225
  //10.079019, 76.338072
  //10.075678, 76.338021
  //10.073416, 76.333390
  //10.070665, 76.332599
  //10.063788, 76.325360
  //10.060301, 76.321435
  //10.055251, 76.322405
  //10.051520, 76.318653
  //10.052223, 76.320299
  //10.049334, 76.318105
  //10.046796, 76.319840
  //10.041601, 76.328959
  //10.044821, 76.327987




//kizhakkambalam to Kolenchery
// List<Location> locations = [
//   Location(LatLng(42.748222, -71.166016), "KFC",'1000'),
//   Location(LatLng(42.750766, -71.169552), "McDonald's",'1001'),
//   Location(LatLng(42.745506, -71.165348), "Subway",'1002'),
//   Location(LatLng(42.745890, -71.177058), "Starbucks",'1003'),
// ];
  
// List<Location> locations = [
//   Location(LatLng(10.015768, 76.341449), "G01",'0'),
//   Location(LatLng(10.036774, 76.408665), "D02",'1'), //kzm
//   Location(LatLng(10.025036, 76.449896), "D03",'2'), //ptm
//   Location(LatLng(10.039975, 76.440208), "G04",'3'),

//   //home to kolenchery points
//   Location(LatLng(10.029139, 76.437242 ), "D01",'4'),
//   Location(LatLng(10.029731, 76.449688 ), "D02",'5'),
//   Location(LatLng(10.020349, 76.445654 ), "D03",'6'),
//   Location(LatLng(10.016376, 76.457155 ), "D04",'7'),
//   Location(LatLng(10.004881, 76.453378 ), "D05",'8'),
//   Location(LatLng(10.002176, 76.462133 ), "D06",'9'),
//   Location(LatLng(9.992287, 76.471231 ), "D07",'10'),
//   Location(LatLng(9.985102, 76.468828 ), "D08",'11'),

// ];


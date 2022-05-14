import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ev_homegrid/_v2/componets/locations.dart';
import 'package:ev_homegrid/_v2/stage_0/credentials_page.dart';
import 'package:ev_homegrid/_v2/stage_0/wallet_page.dart';
import 'package:ev_homegrid/_v2/stage_1/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ev_homegrid/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../navigation pages/main_page.dart';

//v2
import '../../_v2/componets/SlideLeftRoute.dart';
import '../../_v2/componets/SlideRightRoute.dart';
import '../componets/globals.dart' as globals;
import '../web3dart/ethereum_utils.dart';

 Color _one = Color(0xFF000000);
 Color _two = Color(0xFFC4C4C4);
 Color _three = Color(0xFFC4C4C4);


class WelcomePage extends StatefulWidget {

  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  EthereumUtils ethUtils = EthereumUtils(); //web3dart
  var _data;

  CarouselController textCarouselController = CarouselController();
  List<QuotesPanel> _quotesList =[];
  int _currentIndex = 1;
  
  @override
  initState() {
    super.initState();
    ethUtils.initial(); //web3dart
    
    // setUpLocations('4',"G03",LatLng(10.039975, 76.440208));
    addQuotes();
    checkNetwork();
    getCurrentLocation();
  }
  void getChargerData(){
    ethUtils.getChargerDetails().then((value) {
          _data = value;
          if(_data != null){
            var _ids = _data[0];
            var _names = _data[1];
            var _coordinates = _data[2];

            for(int i = 0; i < _ids.length; i++){
              var coordinates = _coordinates[i].split(',');
              double lat = double.parse(coordinates.toString().substring(1, coordinates.toString().indexOf('-')));
              double long = double.parse(coordinates.toString().substring(coordinates.toString().indexOf('-')+1, coordinates.toString().length-1));

              //  print('coordinates: $coordinates');
              // print('lat: $lat');
              // print('long: $long');
              // print('name: ${_names[i]}');
              // print('id: ${_ids[i]}');

              setUpLocations(_ids[i].toString(),_names[i],LatLng(lat, long));
            }

          }
          else{
            print('status : data is null');
          }
          
        });
  }
  void setData() async{
    await ethUtils.setChargerDetails();
  }
  void checkNetwork() async{
    globals.isOnline = await hasNetwork();
  }
  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  void changeIndicatorColor() {
    
    setState(() {
      switch (_currentIndex) {
      case 1:
        _currentIndex += 1;
        _one = Color(0xFF000000);
        _two = Color(0xFFC4C4C4);
        _three = Color(0xFFC4C4C4);
        break;
      case 2:
      _currentIndex += 1;
        _one = Color(0xFFC4C4C4);
        _two = Color(0xFF000000);
        _three = Color(0xFFC4C4C4);
        break;  
      case 3:
        _one = Color(0xFFC4C4C4);
        _two = Color(0xFFC4C4C4);
        _three = Color(0xFF000000);
        _currentIndex = 1;
        break;
    }
    });
    
    // print('current index is $_currentIndex');
  }
  void addQuotes(){
    
    _quotesList.add(QuotesPanel(
      text_1: 'Publish Your App',
      text_2: 'Passion in Own Way',
      text_3: 'It’s Free',
    ));
    
  }
  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    globals.currentLocation = LatLng(position.latitude, position.longitude);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // dissplay text on the screen
      body:Column(
          mainAxisAlignment: MainAxisAlignment.end,
          
          children: [
            Container(
              padding: new EdgeInsets.only(left: 48),
              alignment: Alignment.topLeft,
              child: Text('Get Started',
              style: TextStyle(
                fontSize: 19.0,
                color: Colors.black.withOpacity(0.4),
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
            SizedBox(
              height: 26.0,
            ),
            
            SizedBox(
              height: 150,
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                        Row(
                          children: [
                            Container(
                              width: 400,
                              height: 130,
                              child: Stack(
                                children: [
                                  IgnorePointer(
                                    child: CarouselSlider(
                                      carouselController: textCarouselController,
                                      options: CarouselOptions(
                                        //enlargeCenterPage: true,
                                        height: 400,
                                        reverse: true,
                                        scrollDirection: Axis.horizontal,
                                        enableInfiniteScroll: true,
                                        autoPlay: true,
                                        onPageChanged: (index, reason) {
                                          changeIndicatorColor();
                                        },
                                          ),
                                      items: _quotesList
                                      ),
                                  ),

                                    Positioned(
                                      right: 0,
                                      height: 200,
                                      width: 80,
                                      child: Container(
                                        decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            kBackgroundColor.withOpacity(0.99),
                                            kBackgroundColor,
                                          ],
                                        )
                                      ),
                                      ),
                                    ),

                                    Positioned(
                                      left: 0,
                                      height: 200,
                                      width: 50,
                                      child: Container(
                                        color: kBackgroundColor,
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ],
                          
                        ),
                      

                      SliderIndicator(),
                    ],
                ),
              ),
            ),

            SizedBox(
              height: 42.0,
            ),

            SizedBox(
              height: 55,
              child: Container(
                padding: new EdgeInsets.only(left: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        checkNetwork();
                        Future.delayed(Duration(milliseconds: 200), () => globals.isOnline ? {
                          Navigator.push(context, SlideRightRoute(page: WalletPage())),
                        } : CustomDialogNetworkIssue());
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF0AB0BD),
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 30,
                          right: 30,
                          top: 20,
                          bottom: 20
                        ),
                        child: const Text(
                          'Connect',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                      ),
                      ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        getChargerData();
                        checkNetwork();
                        Future.delayed(Duration(milliseconds: 200), () => globals.isOnline ? {
                          Navigator.push(context, SlideLeftRoute(page: MainPage())),
                        } : CustomDialogNetworkIssue());
                        
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.black12,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side: BorderSide(color: Color(0xFFAFAFAF)),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 30,
                          right: 30,
                          top: 20,
                          bottom: 20
                        ),
                        child: const Text(
                          ' Guest ',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                      ),
                      ),
                  
                  ],
                ),
              ),
              ),

              SizedBox(
                height: 128,
              )
          ],
        ),
    );
  }
  void CustomDialogNetworkIssue() {
    showDialog(
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.0),
        context: context,
        builder: (BuildContext ctx) {
          return Stack(
            children :<Widget>[

              Container(
              child: BackdropFilter(
                blendMode: BlendMode.srcOver,
                filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                child: Container(
                  color: Color(0xFFC4C4C4).withOpacity(0.5),
                  child: AlertDialog(
                    titlePadding: EdgeInsets.zero,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            32.0,
                          ),
                        ),
                      ),

                    title:  
                    Stack(
                        children: [
                          
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Center(
                                  child: Text('Network Error',
                                          style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 0, 0, 0)),
                                          )),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(color: Colors.transparent, height: 40,width: 40,
                            child: Stack(
                              children: [
                                Positioned(
                                  right: 0,
                                  child:  Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: new BorderRadius.circular(20.0),
                                    onTap: (() {
                                      Navigator.of(context).pop();
                                    }),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      color: Colors.transparent,
                                      child: Image.asset('assets/images/closeIcon_v2.png')
                                    ),
                                  ),
                                ),)
                              ],
                            ),),)
                        ],
                      ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 20),
                    //   child: Center(
                    //     child: Text('Network Error',
                    //             style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 0, 0, 0)),
                    //             )),
                    // ),
                    content: Builder(
                      builder: (context) {

                        return Container(
                          height: 100,
                          width: 280,
                          child: Column(children: [
                            Text('Please Connect to the internet.',
                                style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color: Color.fromARGB(255, 0, 0, 0)),),

                            Padding(
                              padding: const EdgeInsets.only(top: 23),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFFFEDE00),
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 100,
                                    right: 100,
                                    top: 18,
                                    bottom: 18
                                  ),
                                  child: const Text(
                                    'Okay',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                      fontFamily: 'Comfortaa',
                                      fontWeight: FontWeight.bold,
                                    ),
                                    ),
                                ),
                                ),
                            ),
                          ],),
                        );
                      },
                    ),
                    
                  ),
                ),
              ),
            ),

            
            ]);
        });
  }
}


class SliderIndicator extends StatelessWidget {


  const SliderIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 50, right: 200),
      height: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 25,),
          Container(
            width: 20,
            height: 4,
            decoration: BoxDecoration(
              color: _one,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          SizedBox(width: 25,),
          Container(
            width: 20,
            height: 4,
            decoration: BoxDecoration(
              color: _two,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          SizedBox(width: 25,),
          Container(
            width: 20,
            height: 4,
            decoration: BoxDecoration(
              color: _three,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          SizedBox(width: 25,),
        ],
      ),
    );
  }
}

class QuotesPanel extends StatelessWidget {
  final String text_1;
  final String text_2;
  final String text_3;
  const QuotesPanel({
    Key? key, required this.text_1, required this.text_2, required this.text_3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        Container(
          width: 300,
          alignment: Alignment.topLeft,
          child: Text(text_1,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
        ),

        Container(
          width: 300,
          alignment: Alignment.topLeft,
          child: Text(text_2,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
        ),

        Container(
          width: 300,
          alignment: Alignment.topLeft,
          child: Text(text_3,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
        ),

        //SizedBox(width: 50,)
      ],
    );
  }
}

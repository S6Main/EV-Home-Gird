import 'package:flutter/material.dart';
import 'package:ev_homegrid/constants.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:google_place/google_place.dart';

import '../componets/globals.dart' as globals;



class SearchPage extends StatefulWidget {

  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  
  TextEditingController _searchControllerDest = new TextEditingController();
  TextEditingController _searchControllerSour = new TextEditingController();

  bool _searchIconVisibleS = true;
  bool _searchIconVisibleD = true;

  bool _recentVisible = true;

  bool _clearIconVisibleS = false;
  bool _clearIconVisibleD = false;

  bool _destSelected = false;

  //google places
  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  

  @override
  void initState() {
    String apiKey = 'AIzaSyCV_x2q82h5TjN5py9HS7Fx7bxV1Wgr_K8';
    googlePlace = GooglePlace(apiKey);
    super.initState();
  }

  void _update(String place) async {
    setState(() {
      if(_destSelected){
        if(place.length > 42){
          _searchControllerSour.text = place.substring(0, 42) + '...';
        }else{
          _searchControllerSour.text = place;
        }
      }
      else{
        if(place.length > 42){
          _searchControllerDest.text = place.substring(0, 42) + '...';
        }else{
          _searchControllerDest.text = place;
        }
      }
      
      _destSelected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFFFFFFFF),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 50,
            ),
            Stack(
              children: [
                
                Container(
                  margin:EdgeInsets.only(left: 30, right: 30),
                  decoration: BoxDecoration(
                    color: Color(0xFFC4C4C4).withOpacity(0.01),
                    borderRadius:  BorderRadius.circular(16),
                    border: Border.all(
                      color: Color(0xFF000000).withOpacity(0.05),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: TextField(
                      controller: _searchControllerDest ,
                      readOnly: _destSelected,
                      style: TextStyle(fontSize: 15.5,color: Color.fromARGB(255, 0, 0, 0)),
                      onChanged: (val){

                        if(val.length >0){
                          autoCompleteSearch(val);
                        }
                        else{
                          if (predictions.length > 0 && mounted) {
                              setState(() {
                                predictions = [];
                              _clearIconVisibleS = false;
                              _recentVisible = true;
                            });
                          }
                        }
                      },
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 17,color: Color(0xFFBFBFBF)),
                        hintText: 'choose destination',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 20,bottom: 20),
                        counterText: '',
                          icon: Visibility(
                            visible: _searchIconVisibleS,
                            child: Icon( _destSelected ? LineAwesomeIcons.angle_left :LineAwesomeIcons.search
                            ,color: Colors.black.withOpacity(0.4),)),
                      ),
                    ),
                  ),
                ),
                // Positioned(
                //   right: ,
                //   child: Padding(
                //     padding: const EdgeInsets.only(right: 30),
                //     child: Container(
                //       padding: EdgeInsets.all(13.5),
                //       alignment: Alignment.center,
                //       width: 60,
                //       height: 60,
                //       child: Container(
                //           decoration: BoxDecoration(
                //           color: Color(0xFF323232).withOpacity(0.6),
                //           borderRadius:  BorderRadius.circular(30),
                //           ),
                //         child: IconButton(
                //           icon: Icon(
                //             Icons.close,
                //             color: Colors.white,
                //             size: 20,
                //           ),
                //           onPressed: () {
                //             print('close');
                //           },
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Positioned(
                  right: 30,
                  child: Visibility(
                    visible: _clearIconVisibleS,
                    child: Container(
                      width: 60,
                      height: 60,
                      alignment: Alignment.center,
                      color: Colors.transparent,
                      child: Material(
                        child: InkWell(
                          onTap: (() {
                            setState(() {
                              _destSelected = false;
                              _searchControllerDest.clear();
                              _clearIconVisibleS = false;
                              _searchIconVisibleS = true;
                              _recentVisible = true;
                            });
                          }),
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Color(0xFF323232).withOpacity(0.6),
                              borderRadius:  BorderRadius.circular(30),
                            ),
                            child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20,
                              ),
                          ),
                        ),
                      ),
                    )
                  ),
                )
              ],
            ),
            Visibility(
              visible: _destSelected,
              child: Container(
                height: 150,
                width: double.infinity,
                padding: EdgeInsets.only(top: 10),
                color: Colors.transparent,
                child: Stack(
                    children: [
                      
                      Container(
                        margin:EdgeInsets.only(left: 30, right: 30),
                        decoration: BoxDecoration(
                          color: Color(0xFFC4C4C4).withOpacity(0.01),
                          borderRadius:  BorderRadius.circular(16),
                          border: Border.all(
                            color: Color(0xFF000000).withOpacity(0.05),
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: TextField(
                            maxLength: 42,
                            controller: _searchControllerSour,
                            readOnly: false,
                            style: TextStyle(fontSize: 15.5,color: Color.fromARGB(255, 0, 0, 0)),
                            onChanged: (val){
                              
                              if(val.length >0){
                                autoCompleteSearch(val);
                              }
                              else{
                                if (predictions.length > 0 && mounted) {
                                    setState(() {
                                      predictions = [];
                                    _clearIconVisibleD = false;
                                    _recentVisible = true;
                                  });
                                }
                              }


                              if(val != ''){
                                setState(() {
                                  _clearIconVisibleD = true;
                                  _recentVisible = false;
                                  if(_searchIconVisibleD){
                                    _searchIconVisibleD = false;
                                  }
                                });
                              }
                              else{
                                setState(() {
                                  _clearIconVisibleD = false;
                                  _recentVisible = true;
                                });
                              }
                            },
                            onTap: ()  {
                              setState(() {
                                // _recentVisible = false;
                              });
                            },
                            decoration: InputDecoration(
                              hintStyle: TextStyle(fontSize: 17,color: Color(0xFFBFBFBF)),
                              hintText: 'choose start location',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 20,bottom: 20),
                              counterText: '',
                                icon: Visibility(
                                  visible: _searchIconVisibleD,
                                  child: Icon(LineAwesomeIcons.search,color: Colors.black.withOpacity(0.4),)),
                            ),
                          ),
                        ),
                      ),
                      // Positioned(
                      //   right: ,
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(right: 30),
                      //     child: Container(
                      //       padding: EdgeInsets.all(13.5),
                      //       alignment: Alignment.center,
                      //       width: 60,
                      //       height: 60,
                      //       child: Container(
                      //           decoration: BoxDecoration(
                      //           color: Color(0xFF323232).withOpacity(0.6),
                      //           borderRadius:  BorderRadius.circular(30),
                      //           ),
                      //         child: IconButton(
                      //           icon: Icon(
                      //             Icons.close,
                      //             color: Colors.white,
                      //             size: 20,
                      //           ),
                      //           onPressed: () {
                      //             print('close');
                      //           },
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Positioned(
                        right: 30,
                        child: Visibility(
                          visible: _clearIconVisibleD,
                          child: Container(
                            width: 60,
                            height: 60,
                            alignment: Alignment.center,
                            color: Colors.transparent,
                            child: Material(
                              child: InkWell(
                                onTap: (() {
                                  setState(() {
                                    _searchControllerSour.clear();
                                    _clearIconVisibleD = false;
                                    _searchIconVisibleD = true;
                                    _recentVisible = true;
                                  });
                                }),
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF323232).withOpacity(0.6),
                                    borderRadius:  BorderRadius.circular(30),
                                  ),
                                  child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                ),
                              ),
                            ),
                          )
                        ),
                      ),
                      Container(
                        margin:EdgeInsets.only(top: 75,left: 30, right: 30),
                        width: double.infinity,
                        height: 65,
                        child: Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {

                            },
                            child: Column(
                              children: [
                                

                                Container(
                                  width: double.infinity,
                                  height: 62,
                                  color: Colors.transparent,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 62,
                                        height: 62,
                                        color: Colors.transparent,
                                        padding: EdgeInsets.all(8),
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Color(0xFF000000).withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          child: Image.asset('assets/images/LocationIcon_v2.png'),
                                        ),
                                      ),

                                      SizedBox(width: 10,),

                                      
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text('Your location',
                                          style: TextStyle(fontSize: 15.5,color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.6),
                                          fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ),
            ),
            Visibility(
              visible: _recentVisible && (globals.queueID.length > 0),
              child: Container(
                width: double.infinity,
                height: 20,
                margin: EdgeInsets.only(top: 15,left: 30,right: 30,bottom: 5),
                child: Text('Recent',
                  style: TextStyle(fontSize: 15.5,color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Visibility(
              visible: _recentVisible,
              child: Container(
                margin:EdgeInsets.only(left: 30, right: 30,bottom: 50),
                width: double.infinity,
                height: 500,
                color: Colors.transparent,
                child: Expanded(
                  flex: 1,
                  child: ListView.builder(
                    itemCount: globals.queueID.length,
                    itemBuilder: (context,index){
                      return RecentWidget(
                        update: _update,
                        placeID: globals.queueID.toList()[index],
                        placeName: globals.queuePlace.toList()[index].toString()
                        );
                    },
                  ),
                ),
                // child: Column(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     RecentWidget(),
                //     RecentWidget(),
                //     RecentWidget(),
                //     RecentWidget(),
                //     RecentWidget(),
                //     RecentWidget(),
                    
                //   ],
                // ),
              ),
            ),
            Visibility(
              visible: !_recentVisible,
              child: Container(
                margin:EdgeInsets.only(top: 30,left: 30, right: 30,bottom: 50),
                width: double.infinity,
                height: 500,
                color: Colors.transparent,
                child: 
                Expanded(
                  child: ListView.builder(
                    itemCount: predictions.length,
                    itemBuilder: (context,index){
                      return SearchResultWidget(
                        update: _update,
                        placeID: predictions[index].placeId.toString(),
                        title: predictions[index].description.toString(),
                        hasSeperator: (index == predictions.length - 1) ? false : true,
                      );
                    },
                  ),
                )
                
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     SearchResultWidget(),
                //     SearchResultWidget(),
                //     SearchResultWidget(),
                //     SearchResultWidget(),
                //     SearchResultWidget(hasSeperator: false,),
                //   ],
                // ),
              ),
            ),
          ],
        ),
      ),);
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
        
        //change visibility of icons
        if(!_destSelected){
          _clearIconVisibleS = true;
          if(_searchIconVisibleS){
            _searchIconVisibleS = false;
          }
        }
        else{
          _clearIconVisibleD = true;
          if(_searchIconVisibleD){
            _searchIconVisibleD = false;
          }
        }
        _recentVisible = false;
      });
    }
  }

}

class RecentWidget extends StatefulWidget {
  
  final String placeID;
  final String placeName;

  final ValueChanged<String> update;
  const RecentWidget({
    Key? key, required this.placeID, required this.placeName, required this.update,
  }) : super(key: key);

  @override
  State<RecentWidget> createState() => _RecentWidgetState();
}

class _RecentWidgetState extends State<RecentWidget> {

  late String placeAddress;
  late String placeName;

  @override
  void initState() {
    super.initState();

    int idx = widget.placeName.indexOf(',');
    placeAddress = widget.placeName.substring(idx+1).toString();

    placeName =  widget.placeName.split(',')[0];
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          widget.update(widget.placeName);
        },
        child: Column(
          children: [
            SizedBox(width: double.infinity,
            height: 4,),

            Container(
              width: double.infinity,
              height: 62,
              color: Color(0xFFC4C4C4).withOpacity(0.05),
              child: Row(
                children: [
                  Container(
                    width: 62,
                    height: 62,
                    color: Colors.transparent,
                    padding: EdgeInsets.all(8),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFF000000).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Image.asset('assets/images/Recent_v2.png'),
                    ),
                  ),

                  SizedBox(width: 10,),

                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 15),
                          alignment: Alignment.topLeft,
                          child: Text(placeName,
                            style: TextStyle(fontSize: 15.5,color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.4),
                            fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 4),
                          alignment: Alignment.topLeft,
                          child: Text(placeAddress,
                            style: TextStyle(fontSize: 11.5,color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.4),
                            fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchResultWidget extends StatefulWidget {
  final bool hasSeperator;
  final String title;
  final String placeID;

  final ValueChanged<String> update;

  const SearchResultWidget({
    Key? key, required this.hasSeperator,  required this.title, required this.placeID, required this.update,
  }) : super(key: key);
  @override
  State<SearchResultWidget> createState() => _SearchResultWidgetState();
}

class _SearchResultWidgetState extends State<SearchResultWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: (){
          widget.update(widget.title);
          // globals.queue.add(widget.placeID);
          globals.queuePlace.addFirst(widget.title);
          globals.queueID.addFirst(widget.placeID);
          if(globals.queueID.length > 7){
            globals.queuePlace.removeLast();
            globals.queueID.removeLast();
          }
        },

        child: Column(
          children: [
            

            Container(
              width: double.infinity,
              height: 62,
              color: Colors.transparent,
              child: Row(
                children: [
                  Container(
                    width: 62,
                    height: 62,
                    color: Colors.transparent,
                    padding: EdgeInsets.all(8),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFF000000).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Image.asset('assets/images/MarkerIcon_v2.png'),
                    ),
                  ),

                  SizedBox(width: 10,),

                  
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.title,
                        style: TextStyle(fontSize: 15.5,color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.6),
                        fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 5,
              padding: EdgeInsets.only(left: 15,right: 15),
              child: Divider(
                color: widget.hasSeperator ? Colors.black.withOpacity(0.03) : Colors.transparent,
                thickness: 1.5,
              ),
              ),
          ],
        ),
      ),
    );
  }
}
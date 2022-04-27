import 'dart:io';

import 'package:ev_homegrid/_v2/others/temp.dart';
import 'package:ev_homegrid/_v2/stage_0/credentials_page.dart';
import 'package:flutter/material.dart';
import 'package:ev_homegrid/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_network_connectivity/flutter_network_connectivity.dart';

import '../componets/SlideLeftRoute.dart';
import '../_widgets/BackButton.dart';


class WalletPage extends StatefulWidget {

  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}


class _WalletPageState extends State<WalletPage> {
  
  String _network = 'Test Net'; //pass
  bool _isVisible = true;
  String _walletAddress = ''; //pass
  bool _validAddress = false;
  String _message = '';

  TextEditingController _walletController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onLongPress: () {
          setState(() {
            _validAddress = false;
            _walletController.text = '';
          });
        },
        onTap: (){
          FocusScope.of(context).unfocus();
        },

        child: Container(
          child: Stack(
            children: [
              BackButtonCustom(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                    Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          child: Container(
                          height: 56,
                          width: 150,
                            color: Colors.transparent,
                            margin: EdgeInsets.only(bottom: 70,left: 40),
                          ),
                          ),
                        Row(
                          children: [
                            
                            Visibility(
                              visible : _isVisible,
                              child: InkWell(
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side: BorderSide(color: Colors.grey)
                                  ),
                                onTap: () {                          
                                 showDataAlert();
                                 setState(() {
                                   _isVisible = false;
                                 });
                                },       
                                child: Container(
                                    height: 56,
                                    width: 140,
                                    
                                    //margin: EdgeInsets.only(bottom: 70),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:  BorderRadius.circular(25),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10,top: 10,bottom: 10),
                                          child: Text(_network,style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color: Color(0xFF2B2D41)),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10,bottom: 10,left: 6,),
                                          child: Icon(Icons.arrow_drop_down,color: Color(0xFF2B2D41),),
                                        ),
                                      ],),
                                    ),
                              ),
                            ),
                            SizedBox(width: 40,),
                          ],
                        ),
                      ],
                    ),
                  SizedBox(height: 30,),
                  Container(
                    height: 15,
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 35),
                    child: Text(_message,style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Color.fromARGB(255, 221, 60, 60)),),
                    ),
                  SizedBox(height: 5,),
                  Container(
                      margin: EdgeInsets.only(bottom: 25,left: 30,right: 30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:  BorderRadius.circular(10),
                      ),
                      child: TextField(
                        maxLength: 42,
                        readOnly: true,
                        controller: _walletController,
                        style: TextStyle(fontSize: 15.5,color: Color.fromARGB(255, 0, 0, 0)),
                        onTap: () async {
                          ClipboardData? cdata = await Clipboard.getData(Clipboard.kTextPlain);
                          String? copiedtext = cdata?.text;
                          
                          if(_walletController.text == ''){
                            if(copiedtext != null){
                              FocusManager.instance.primaryFocus?.unfocus();
                            }
                            //code to paste
                            if(copiedtext != null){
                              _walletController.text = copiedtext;
                            }
                            else{
                              _walletController.text = '';
                            }
                          }
                        },
                        decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 17,color: Color(0xFFBFBFBF)),
                          hintText: '0xB###################################b8',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(20),
                          counterText: '',
                        ),
                      ),
                    ),
                  ElevatedButton(
                              onPressed: () async {
                                
                                bool isOnline = await hasNetwork();
                                if(isOnline)
                                  {
                                    setState(() {
                                    _message = validateWalletAddress(_walletController.text);
                                  });
                                  if(_message == ''){
                                    _walletAddress = _walletController.text;
                                  }
                                  if(_validAddress){
                                    Navigator.push(context, 
                                      SlideLeftRoute(page: CredentialsPage(
                                        network: _network,
                                        walletAddress: _walletAddress,)));
                                  }}
                                  else{
                                    setState(() {
                                      _message = 'Please check your internet connection';
                                    });
                                  }
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
                  SizedBox(height: 128),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }


  String validateWalletAddress(String value) {
    if(value.isEmpty){
    return "Wallet Address cannot be empty";
  }
  else  if ((value.length != 42) || (value[0] != '0' && value[1] != 'x')) {
    return "Invalid Wallet Address";
  } 
  else{
    _validAddress = true;
    return '';
  }
}

  showDataAlert() {
  showDialog(
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.0),
      
      context: context,
      builder: (context) {
        return Positioned(
          child: AlertDialog(
            insetPadding: EdgeInsets.only(left: 185,top: 90),
            backgroundColor: Colors.transparent,
            elevation: 0,
            titlePadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  25.0,
                ),
              ),
            ),
            content: Container(
              height: 120,
              child:  Stack(
                
                alignment: Alignment.topCenter,
                  children: <Widget>[
                    
                    Positioned(
                      top: 5,
                      child: Container(
                        width: 153,
                        height: 110,
                        decoration: BoxDecoration(
                        //color: Color(0xFFBFBFBF),
                        color: kBackgroundColor,
                        border: Border.all(
                          color: Colors.white.withOpacity(0),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(25)),)
                        //change rediums

                      ),
                    ),
                    Positioned(
                      child: 
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isVisible = true;
                            _network = 'Main Net';
                          });
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Color.fromARGB(255, 175, 175, 175),
                          shadowColor: Colors.black.withOpacity(0.1),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.0),
                              topRight: Radius.circular(25.0),
                            ),
                          ),
                           //fixedSize: Size(80, 50),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 25,left: 33, right: 33,bottom: 15),
                          child: Text(
                            'Main Net',style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color: Color(0xFF2B2D41)),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 60,
                      child: 
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isVisible = true;
                            _network = 'Test Net';
                          });
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                           onPrimary: Color.fromARGB(255, 124, 124, 124),
                           shadowColor: Colors.black.withOpacity(0.1),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25.0),
                              bottomRight: Radius.circular(25.0),
                            ),
                          ),
                          // fixedSize: Size(250, 50),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 25,left: 35, right: 35,top: 15),
                          child: Text(
                            'Test Net',style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color: Color(0xFF2B2D41)),
                          ),
                        ),
                      ),
                    ),
                    
                   
                  ],
                ),
              ),
          ),
        );
      });
}
}



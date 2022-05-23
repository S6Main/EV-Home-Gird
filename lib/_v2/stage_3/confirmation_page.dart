import 'dart:math';

import 'package:ev_homegrid/_v2/stage_1/home_page.dart';
import 'package:ev_homegrid/navigation%20pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:ev_homegrid/constants.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../componets/FadeRoute.dart';
import '../componets/globals.dart' as globals;


class ConfirmationPage extends StatefulWidget {

  const ConfirmationPage({Key? key}) : super(key: key);

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {

  late String _receiverAddress = '';
  late String _senderAddress = '';
  late String _date;
  late double _amount = 0.0;
  late double _tax = 0.0;
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    DateTime date = new DateTime.now();
    _date = DateFormat('d MMMM y').format(date);
    //'31 October 2021'

    _receiverAddress = globals.receiver_address.substring(0,5) + '...' + globals.receiver_address.substring(globals.receiver_address.length-5);
    _senderAddress = globals.sender_address.substring(0,5) + '...' + globals.sender_address.substring(globals.sender_address.length-5);

    _amount = globals.amount;
  }

  void addTransaction(){
    globals.transactionName = globals.receiver_name;
    globals.transactionAddress = globals.receiver_address;
    globals.transactionAmount = globals.amount.toString();
    globals.transactionDate = _date;
    globals.isTransactionAdded = true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 120,),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              color: Colors.transparent,
              child: Stack(
                children: [

                  Positioned(
                    child: Container(
                      padding: EdgeInsets.only(bottom: 100),
                      width: double.infinity,
                      height: 700,
                      child: 
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 150,
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(40),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.orange.withOpacity(0.1),
                                        blurRadius: 10,
                                        offset: Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: Icon(LineAwesomeIcons.check, color: Colors.white, size: 50,),
                                ),
                                SizedBox(height: 20,),
                                Text('Success',style: TextStyle(fontSize: 40,fontWeight: FontWeight.w900,color: Color(0xFF2A2A2A)),),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20,right: 20),
                            width: double.infinity,
                            height: 400,
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 50,
                                  color: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Date',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Color(0xFF2A2A2A).withOpacity(0.5)),),
                                      Text(_date,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Color(0xFF2A2A2A).withOpacity(0.8)),)
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Container(
                                  width: double.infinity,
                                  height: 100,
                                  color: Colors.transparent,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Sender',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Color(0xFF2A2A2A).withOpacity(0.5)),),
                                          Text(_senderAddress,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Color(0xFF2A2A2A).withOpacity(0.8)),)
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Receiver',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Color(0xFF2A2A2A).withOpacity(0.5)),),
                                          Text(_receiverAddress,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Color(0xFF2A2A2A).withOpacity(0.8)),)
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Container(
                                  width: double.infinity,
                                  height: 100,
                                  color: Colors.transparent,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Total Tranfer',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Color(0xFF2A2A2A).withOpacity(0.5)),),
                                          Text('₹' + _amount.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Color(0xFF2A2A2A).withOpacity(0.8)),)
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Admin fee',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Color(0xFF2A2A2A).withOpacity(0.5)),),
                                          Text('₹' + _tax.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Color(0xFF2A2A2A).withOpacity(0.8)),)
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Total',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Color(0xFF2A2A2A).withOpacity(0.5)),),
                                          Text('₹' + (_amount + _tax).toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Color(0xFFFFA61D).withOpacity(0.8)),)
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(child: Container(),)
                              ],
                            ),
                          ),
                          
                        ],
                      ),
                      ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 50,right: 50),
                      height: 100,
                      color: Colors.transparent,
                      child: AnimatedButton(
                        onPress: () {
                          addTransaction();
                          Navigator.of(context).push(CustomPageRoute(MainPage(
                          )));
                        },
                        height: 60,
                        width: double.infinity,
                        text: 'Back to home',
                        isReverse: true,
                        selectedTextColor: Colors.black,
                        transitionType: TransitionType.RIGHT_BOTTOM_ROUNDER,
                        backgroundColor: Colors.black,
                        borderColor: Colors.black,
                        borderRadius: 20,
                        borderWidth: 2,
                      ),
                    ),
                  ),
                ],)
            ),
          ),
          SizedBox(height: 20,),
      ],)
      );
  }
}
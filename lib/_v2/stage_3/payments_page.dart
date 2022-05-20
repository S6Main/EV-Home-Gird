import 'package:flutter/material.dart';
import 'package:ev_homegrid/constants.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class PaymentsPage extends StatefulWidget {

  const PaymentsPage({Key? key}) : super(key: key);

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          
          Padding(
            padding: const EdgeInsets.only(top: 80.0,left: 50,right: 50),
            child: Container(
              color: Colors.transparent,
              height: 50,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(FontAwesomeIcons.chevronLeft,color: Colors.black.withOpacity(0.2),),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                  Text('Confirmation',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500,color: Colors.black),),
                  SizedBox(width: 40,)
                ],
              ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0,left: 50,right: 50),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xFFF2F2F2),
              ),
              width: double.infinity,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 100,
                    height: 100,
                    color: Colors.transparent,
                    child: Container(
                        alignment: Alignment.center,
                        width: 70,
                        height: 70,
                        color: Colors.amberAccent,
                      ),
                    ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Sam Fernandes',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Color(0xFF2A2A2A)),),
                        SizedBox(height: 5,),
                        Text('0x65...78',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300,color: Color(0xFF2A2A2A).withOpacity(0.5)),),
                      ],
                    ),
                  )
                ],
                
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: Stack(
                children: [

                  Positioned(
                    child: Container(
                      padding: EdgeInsets.only(bottom: 100),
                      width: double.infinity,
                      height: 600,
                      child: 
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 100,
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Text('Total',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Color(0xFF2A2A2A)),),
                                SizedBox(height: 5,),
                                Text('\₹0.00',style: TextStyle(fontSize: 40,fontWeight: FontWeight.w900,color: Color(0xFF2A2A2A)),),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20,right: 20),
                            width: double.infinity,
                            height: 150,
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Transfer deatils',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Color(0xFF2A2A2A)),)),
                                SizedBox(height: 10,),
                                Container(
                                  alignment: Alignment.topCenter,
                                  width: double.infinity,
                                  color: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:[
                                      Container(
                                          color: Colors.transparent,
                                          child: Column(
                                            children: [
                                              SizedBox(height: 5,),
                                              Text('Total trasfers',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Color(0xFF2A2A2A).withOpacity(0.5)),),
                                              SizedBox(height: 10,),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text('Admin fee    ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Color(0xFF2A2A2A).withOpacity(0.5)),)),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          color: Colors.transparent,
                                          child: Column(
                                            children: [
                                              SizedBox(height: 5,),
                                              Text('\₹0.99',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Color(0xFF2A2A2A).withOpacity(0.8)),),
                                              SizedBox(height: 10,),
                                              Text('\₹0.00',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Color(0xFF2A2A2A).withOpacity(0.8)),)
                                            ],
                                          ),
                                        ),
                                    ]
                                  ),
                                ),
                                SizedBox(height: 15,),
                                Divider(),
                                SizedBox(height: 15,),
                                Container(
                                  alignment: Alignment.topCenter,
                                  width: double.infinity,
                                  color: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:[
                                      Container(
                                          color: Colors.transparent,
                                          child: Column(
                                            children: [
                                              Text('Total ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Color(0xFF2A2A2A)),),
                                              
                                            ],
                                          ),
                                        ),
                                        Container(
                                          color: Colors.transparent,
                                          child: Column(
                                            children: [
                                              Text('\₹0.99',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Color(0xFFFFA61D).withOpacity(0.8)),)
                                            ],
                                          ),
                                        ),
                                    ]
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            height: 100,
                            color: Colors.transparent,
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xFFF2F2F2).withOpacity(0.5),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: 20,),
                                  Icon(FontAwesomeIcons.clock,color: Color(0xFF2A2A2A).withOpacity(0.4),size: 18,),
                                  SizedBox(width: 20,),
                                  SizedBox(width: 300,
                                    child: Text(
                                      'It might take some time to complete the transaction. Please wait...',
                                       style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Color(0xFF2A2A2A).withOpacity(0.5)),),)
                                  
                                  
                                ],
                              ),
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
                          
                        },
                        height: 60,
                        width: double.infinity,
                        text: 'Conform and Transfer',
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
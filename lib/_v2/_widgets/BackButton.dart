import 'package:flutter/material.dart';

class BackButtonCustom extends StatelessWidget {

  const BackButtonCustom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Positioned(
          left: 40,
          top: 80,
          child: SizedBox(
                      height: 50,
                      width: 50,
                      child: Image.asset('assets/images/backIcon_v2.png')),),
          Positioned(
          left: 40,
          top: 80,
          child: SizedBox(
                      height: 50,
                      width: 50,
                      child: Material(
                          color: Colors.transparent,
                          child: new InkWell(
                            borderRadius: new BorderRadius.circular(20.0),
                            onTap: (){
                              
                              Navigator.pop(context);
                            },
                            ),
                        ),),)
        ],
      );
  }
}
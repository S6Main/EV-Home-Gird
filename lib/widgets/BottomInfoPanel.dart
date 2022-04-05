import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomInfoPanel extends StatelessWidget {
  const BottomInfoPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset.zero
          )
        ]
      ),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: Row(
              children :[
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/images/charger.png',
                        fit: BoxFit.cover,
                        height: 60,
                        width: 60,
                      ),
                    )
                  ],
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: Column(
                    children: [
                      Text('Carne de Cerdo',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700]
                        ),
                      ),
                      Text('Vendta por delia'),
                      Text('2km de distencia')

                    ],
                  ),
                ),
                Icon(Icons.store, size: 40, color: Colors.grey[700],),

              ]
            ),
          )
        ],
      ),
    );
  }
}
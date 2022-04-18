import 'package:flutter/material.dart';

import '../icons/custom_icon.dart';
import '../navigation pages/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*appBar: AppBar(
        title: Text('EV Home Grid'),
      ),*/
        body: Center(
            child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 550,
        ),
        SizedBox(
            width: 338,
            height: 45,
            child: ElevatedButton.icon(
              icon: Icon(
                CustomIcon.account_balance_wallet,
                size: 24,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              label: Text(
                'CONNCET WALLET',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 255, 255, 255),
                onPrimary: Color.fromARGB(255, 0, 0, 0),
                shadowColor: Color.fromARGB(68, 0, 0, 0),
                side:
                    BorderSide(width: 1.5, color: Color.fromARGB(20, 0, 0, 0)),
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                minimumSize: Size(100, 40), //////// HERE
              ),
              onPressed: () {},
            )),
        SizedBox(
          height: 16,
        ),
        SizedBox(
          width: 338,
          height: 45,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
              onPrimary: Colors.white,
              shadowColor: Color.fromARGB(255, 65, 65, 65),
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              minimumSize: Size(100, 40), //////// HERE
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainPage()),
              );
            },
            child: Text(
              'GUEST',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ),
      ],
    )));
  }
}

import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:ev_homegrid/navigation%20pages/main_page.dart';

class FrontScreen extends StatefulWidget {
  const FrontScreen({Key? key}) : super(key: key);

  @override
  State<FrontScreen> createState() => _FrontScreenState();
}

class _FrontScreenState extends State<FrontScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kThemeColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: 5,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: const [
                        Text(
                          'EV HOME GRID',
                          style: TextStyle(
                              fontSize: 32.0,
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 100.0),
                          child: Text(
                            'Ajduikudfjbiwubifkjsoun',
                            style: TextStyle(
                              fontFamily: 'Comfortaa',
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainPage()));
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 70.0),
                  height: 55.0,
                  width: 220.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.circular(kBorderCircleRadius),
                  ),
                  child: const Text(
                    'Get Started',
                    style: kFrontPageButtonTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

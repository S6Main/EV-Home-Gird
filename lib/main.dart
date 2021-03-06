// @dart=2.9
import 'package:ev_homegrid/front_screen.dart';
import 'package:ev_homegrid/icons/custom_icon.dart';
import 'package:ev_homegrid/navigation%20pages/home_page.dart';
import 'package:flutter/material.dart';
import 'login/login_page.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
// import 'package:ev_homegrid/navigation%20pages/home_page.dart';
// import 'Guest.dart';
// import 'navigation pages/pop_pages/side_page.dart';

void main() {
  // lock device orientation
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EV Home Grid',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Comfortaa',
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kThemeColor,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: kBackgroundColor,
            ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // theme: ThemeData().copyWith(
      //   textTheme: GoogleFonts.comfortaaTextTheme(
      //     Theme.of(context).textTheme,
      //   ),
      // ),

      // theme: ThemeData(
      //   primaryColor: Colors.white,
      // ),
      //home: MyHomePage(),
      home: FrontScreen(),
      // home: MyHomePage(),
      // home: MainPage(),
      //home: mainApp()
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //MyHomePage({Key key, this.title}) : super(key: key);
  //final String title;

  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      finishButtonText: 'Register',
      onFinish: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
          // CupertinoPageRoute(
          //   builder: (context) => LoginPage(),
          // ),
        );
      },
      finishButtonColor: Colors.black,
      skipTextButton: Text(
        'Skip',
        style: TextStyle(
          fontSize: 16,
          color: Colors.black54,
          fontWeight: FontWeight.w600,
        ),
      ),
      // trailing: Text(
      //   'Login',
      //   style: TextStyle(
      //     fontSize: 16,
      //     color: Colors.black,
      //     fontWeight: FontWeight.w600,
      //   ),
      // ),
      // trailingFunction: () {
      //   Navigator.push(
      //     context,
      //     CupertinoPageRoute(
      //       builder: (context) => LoginPage(),
      //     ),
      //   );
      // },
      controllerColor: Colors.black,
      totalPage: 3,
      headerBackgroundColor: Colors.white,
      pageBackgroundColor: Colors.white,
      background: [
        Image.asset(
          'assets/images/login/slide_1.png',
          height: 400,
        ),
        Image.asset(
          'assets/images/login/slide_2.png',
          height: 400,
        ),
        Image.asset(
          'assets/images/login/slide_3.png',
          height: 400,
        ),
      ],
      speed: 1.8,
      pageBodies: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 480,
              ),
              Text(
                'On your way...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'to find the perfect looking Onboarding for your app?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 480,
              ),
              Text(
                'You???ve reached your destination.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Sliding with animation',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 480,
              ),
              Text(
                'Start now!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Where everything is possible and customize your onboarding.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

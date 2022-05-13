import 'package:ev_homegrid/_v2/stage_0/wallet_page.dart';
import 'package:ev_homegrid/_v2/web3dart/test_page.dart';
import 'package:ev_homegrid/icons/custom_icon.dart';
import 'package:ev_homegrid/_v2/stage_1/home_page.dart';
import 'package:flutter/material.dart';
import '_v2/others/temp.dart';
import '_v2/stage_0/credentials_page.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';

import 'package:ev_homegrid/_v2/stage_0/welcome_page.dart';

import 'navigation pages/main_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


void main() async{
  // lock device orientation
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
  FocusManager.instance.primaryFocus?.unfocus();

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
      //home: FrontScreen(),
      //home: MyHomePage(),
      //home: MainPage(), // screen
      //home: mainApp()
      home: WelcomePage(), //v2 version
      //home: WalletPage(),
      //home: CredentialsPage(),
      // home: TestPage(), // web3dart
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
    return Scaffold(
      appBar: AppBar(
        title: Text('EV Home Grid'),
      ),);
  }
}

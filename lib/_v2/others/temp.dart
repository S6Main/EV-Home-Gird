// import 'dart:async';
// import 'dart:io';
// import 'dart:ui';

// import 'package:ev_homegrid/navigation%20pages/main_page.dart';
// import 'package:flutter/material.dart';
// import 'package:ev_homegrid/constants.dart';
// import 'package:flutter/services.dart';
// import 'package:ev_homegrid/_v2/_widgets/BackButton.dart';
// import 'package:http/http.dart';
// import 'package:loading_indicator/loading_indicator.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';

// import '../componets/SlideLeftRoute.dart';

// import 'dart:math'; //used for the random number generator
// import 'package:web3dart/web3dart.dart';
// import '../componets/globals.dart' as globals;

// const List<Color> _kDefaultRainbowColors = const [
//   Colors.red,
//   Colors.orange,
//   Colors.yellow,
//   Colors.green,
//   Colors.blue,
//   Colors.indigo,
//   Colors.purple,
// ];

// class CredentialsPage extends StatefulWidget {

//   final String network;
//   final String  walletAddress;

//   const CredentialsPage({Key? key, required this.network, required this.walletAddress}) : super(key: key);

//   @override
//   State<CredentialsPage> createState() => _CredentialsPageState();
// }

// class _CredentialsPageState extends State<CredentialsPage> {
  
//   String _walletkey = '';
//   bool _validkey = false;
//   String _message = '';
//   //bool _isOnline = true;

//   bool _isValidUser = false; // zmp
//   String _status = 'success';
//   Color _textColor = Colors.green;

//   TextEditingController _keyController = new TextEditingController();

//   late Client httpClient;
//   late Web3Client ethClient;
//   late var myData;

//   String contractAddress = '0x7af626060B9C64526e9C74073c843F25a21d0a36'; // ned to change this after deployment

//   //myAddress = '0x9c8c9c8c9c9c9c9c9c9c9c9c9c9c9c9c9c9c9c9c9';

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     randomCredential();
//   }

//   void randomCredential(){
//     if(widget.network != 'Main net'){
//       //generate random credentials
//       _keyController.text = '3aa8179826b1a3447b8b2f8beffe4b2a7cd7ca966c77bca56c5c4bf5d204a328';
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: InkWell(
//               onLongPress: () {
//                 setState(() {
//                   _validkey = false;
//                   _keyController.text = '';
//                 });
//               },
//               onTap: (() {
//                 FocusScope.of(context).unfocus();
//                 //code on tap screen
//               }),
//               child: Container(
//             child: Stack(
//               children: [
//                 BackButtonCustom(),
//                 Container(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Container(
//                           height: 15,
//                           alignment: Alignment.topLeft,
//                           padding: EdgeInsets.only(left: 35),
//                           child: Text(_message,style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Color.fromARGB(255, 221, 60, 60)),),
//                           ),
//                         SizedBox(height: 5,),
//                         Container(
//                             margin: EdgeInsets.only(bottom: 25,left: 30,right: 30),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius:  BorderRadius.circular(10),
//                             ),
//                             child: TextField(
//                               controller: _keyController,
//                               maxLength: 64,
//                               style: TextStyle(fontSize: 15.5,color: Color.fromARGB(255, 0, 0, 0)),
//                               onTap: ()  async{
//                                 setState(() {
//                                 _message = ''; 
//                                 });
//                                 FocusManager.instance.primaryFocus?.unfocus();
//                                 if(_keyController.text == ''){
//                                   //code to paste
//                                   ClipboardData? cdata = await Clipboard.getData(Clipboard.kTextPlain);
//                                   String? copiedtext = cdata?.text;
//                                   if(copiedtext != null){
//                                     _keyController.text = copiedtext;
//                                 }
//                                 }
//                               },
//                               decoration: InputDecoration(
//                                 hintStyle: TextStyle(fontSize: 17,color: Color(0xFFBFBFBF)),
//                                 hintText: 'private key',
//                                 border: InputBorder.none,
//                                 contentPadding: EdgeInsets.all(20),
//                                 counterText: '',
//                               ),
//                             ),
//                           ),
//                         ElevatedButton(
//                                     onPressed: (){
//                                       checkNetwork();
//                                       Future.delayed(Duration(milliseconds: 200), () => globals.isOnline ? {
//                                           setState(() {
//                                             _message = validateWalletAddress(_keyController.text);
//                                           }),
//                                           if(_message == ''){
//                                             _walletkey = _keyController.text,
//                                             //true stage
//                                             CustomLoading(),
//                                           },
//                                         print('place one'),
//                                         // Navigator.push(context, SlideRightRoute(page: WalletPage())),
//                                       } : {
//                                         setState(() {
//                                             CustomDialog();
//                                           }),
//                                         print('place two'),
//                                       });

//                                       // Future.delayed(Duration(milliseconds: 300), () => globals.isOnline ? {
//                                       //   print('globals.isOnline: ' + globals.isOnline.toString()),
//                                       //   setState(() {
//                                       //       _message = validateWalletAddress(_keyController.text);
//                                       //     }),
//                                       //     if(_message == ''){
//                                       //       _walletkey = _keyController.text,
//                                       //       //true stage
//                                       //       CustomLoading(),
//                                       //     }
//                                       // } : {
//                                       //   setState(() {
//                                       //       CustomDialog();
//                                       //     }),
//                                       // });

//                                       // if(globals.isOnline){
//                                       //     setState(() {
//                                       //       _message = validateWalletAddress(_keyController.text);
//                                       //     });
//                                       //     if(_message == ''){
//                                       //       _walletkey = _keyController.text;
//                                       //       //true stage
//                                       //       CustomLoading();
//                                       //     }
//                                       //   }
//                                       //   else{
//                                       //     setState(() {
//                                       //       CustomDialog();
//                                       //     });
//                                       //   }
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                       primary: Color(0xFF0AB0BD),
//                                       shadowColor: Colors.transparent,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(25),
//                                       ),
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(
//                                         left: 30,
//                                         right: 30,
//                                         top: 20,
//                                         bottom: 20
//                                       ),
//                                       child: const Text(
//                                         'Authenticate',
//                                         style: TextStyle(
//                                           fontSize: 18.0,
//                                           color: Colors.white,
//                                           fontFamily: 'Comfortaa',
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                         ),
//                                     ),
//                                     ),
                        
//                         SizedBox(height: 128),
//                       ],
//                     ),
//                   )
//           ],
//         ),
//       ),

//     ),);
//   }
//   void checkNetwork() async{
//     globals.isOnline = await hasNetwork();
//   }
//   Future<bool> hasNetwork() async {
//     try {
//       final result = await InternetAddress.lookup('example.com');
//       return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
//     } on SocketException catch (_) {
//       return false;
//     }
//   }
  
//   String validateWalletAddress(String value) {
//     if(value.isEmpty){
//     return "private key cannot be empty";
//   }
//   else  if (value.length != 64) {
//     return "Invalid private key";
//   } 
//   else{
//     _validkey = true;
//     return '';
//   }
//   }

//   Future<void> Authentication() async {
      
//       httpClient = Client();
//       String url = '';
//       if(widget.network == 'Main Net'){
//         url = 'https://mainnet.infura.io/v3/64e91f8989da4b26a7851df51c1afb3b';
//       }
//         else
//       {
//         url = 'https://ropsten.infura.io/v3/64e91f8989da4b26a7851df51c1afb3b';
//       }
//       ethClient = Web3Client(
//           url,
//           httpClient);
      
//       getBalance(widget.walletAddress);
//     }

//   Future<DeployedContract> loadContract() async{
//     String abi = await rootBundle.loadString('assets/web3dart/abi.json'); // ned to change this after deployment

//     final contract = DeployedContract(
//       ContractAbi.fromJson(abi, 'main'),EthereumAddress.fromHex(contractAddress));

//     return contract;
//   }

//   Future<List<dynamic>> query(String functionName, List<dynamic> args) async{

    
//     final contract = await loadContract();
//     final ethFunction = contract.function(functionName);
//     final result = await ethClient.call(contract: contract, function: ethFunction, params: args);

//     return result;
//   }

//   Future<void> getBalance(String _walletAddress) async{
//     // EthereumAddress _address = EthereumAddress.fromHex(_walletAddress);

//     List<dynamic> result = await(query('getBalance', []));

//     myData = result[0].toString();
//     print('myData: $myData');
//     if(myData != null){
//       setState(() {
//         _isValidUser = true;
//       });
//     }
//     else{
//       setState(() {
//         _status = 'failed authentication';
//         _textColor = Colors.red;
//         _isValidUser = false;
//       });
//     }

//   }

// Future<String> submit(String functionName, List<dynamic> args) async{

//   EthPrivateKey credential  = EthPrivateKey.fromHex(_walletkey);
//   Authentication();

//   DeployedContract contract = await loadContract();
//   final ethFunction = contract.function(functionName);
//   // final result = await ethClient.sendTransaction(credential, 
//   //         Transaction.callContract(contract: contract, 
//   //             function: ethFunction, parameters: args),
//   //             // fetchChainIdFromNetworkId: true
//   //             ); // issue spotted
//   // final result = await ethClient.sendTransaction(credential, 
//   //         Transaction.callContract(contract: contract,
//   //             //from: EthereumAddress.fromHex(widget.walletAddress),
//   //             maxGas: 1000000,
//   //             function: ethFunction, parameters: args),
//   //             chainId: 3,
//   //             ); //
//   final result = await ethClient.sendTransaction(credential,
//             Transaction.callContract(contract: contract,
//                 function: ethFunction, parameters: args,
//                 maxGas: 1000000,
//                 ),
//                 chainId: 3,
//               ); //

//   return result;
// }

// Future<String> sendData() async{
//   var bigAmount = BigInt.from(50);

//   var responce = await submit('depositBalance', [bigAmount]);
//   print('Data Transferred');
//   return responce;
// }

// Future<String> getData() async{
//   var bigAmount = BigInt.from(30);

//   var responce = await submit('withdrawBalance', [bigAmount]);
//   print('Data Received');
//   return responce;
// }

// void CustomDialog() {
//     showDialog(
//         barrierDismissible: false,
//         barrierColor: Colors.black.withOpacity(0.0),
//         context: context,
//         builder: (BuildContext ctx) {
//           return Stack(
//             children :<Widget>[

//               Container(
//               child: BackdropFilter(
//                 blendMode: BlendMode.srcOver,
//                 filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
//                 child: Container(
//                   color: Color(0xFFC4C4C4).withOpacity(0.5),
//                   child: AlertDialog(
//                     elevation: 0,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(
//                             32.0,
//                           ),
//                         ),
//                       ),

//                     title:  Padding(
//                       padding: const EdgeInsets.only(top: 20),
//                       child: Center(
//                         child: Text('Network Error',
//                                 style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 0, 0, 0)),
//                                 )),
//                     ),
//                     content: Builder(
//                       builder: (context) {

//                         return Container(
//                           height: 100,
//                           width: 280,
//                           child: Column(children: [
//                             Text('Please Connect to the internet.',
//                                 style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color: Color.fromARGB(255, 0, 0, 0)),),

//                             Padding(
//                               padding: const EdgeInsets.only(top: 23),
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   Navigator.of(ctx).pop();
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   primary: Color(0xFFFEDE00),
//                                   shadowColor: Colors.transparent,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(
//                                     left: 100,
//                                     right: 100,
//                                     top: 18,
//                                     bottom: 18
//                                   ),
//                                   child: const Text(
//                                     'Okay',
//                                     style: TextStyle(
//                                       fontSize: 18.0,
//                                       color: Colors.black,
//                                       fontFamily: 'Comfortaa',
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                     ),
//                                 ),
//                                 ),
//                             ),
//                           ],),
//                         );
//                       },
//                     ),
                    
//                   ),
//                 ),
//               ),
//             ),

//             Align(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: 330,
//                       height: 40,
//                       child: Row(
//                         children: [
//                           Expanded(child: Container(
//                             color: Colors.transparent,
//                           ),),
//                           Material(
//                             color: Colors.transparent,
//                             child: InkWell(
//                               borderRadius: new BorderRadius.circular(20.0),
//                               onTap: (() {
//                                 Navigator.of(context).pop();
//                               }),
//                               child: Container(
//                                 width: 40,
//                                 height: 40,
//                                 color: Colors.transparent,
//                                 child: Image.asset('assets/images/closeIcon_v2.png')
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 180),
                    
//                   ],
//                 ),
//               ),
//             ]);
//         });
//   }

// void CustomLoading() {
//     Authentication(); //start authentication of wallet
//     showDialog(
//         barrierDismissible: false,
//         barrierColor: Colors.black.withOpacity(0.0),
//         context: context,
//         builder: (BuildContext ctx) {
//           return Stack(
//             children :<Widget>[

//               Container(
//               child: BackdropFilter(
//                 blendMode: BlendMode.srcOver,
//                 filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
//                 child: Container(
//                   color: Color(0xFFC4C4C4).withOpacity(0.5),
//                   child: AlertDialog(
//                     titlePadding: EdgeInsets.zero,
//                     elevation: 0,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(
//                             32.0,
//                           ),
//                         ),
//                       ),

//                     title:  
//                     Stack(
//                         children: [
                          
//                           Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 20),
//                                 child: Center(
//                                   child: Text('Network Error',
//                                           style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 0, 0, 0)),
//                                           )),
//                               ),
//                             ],
//                           ),
//                           Positioned(
//                             top: 0,
//                             right: 0,
//                             child: Container(color: Colors.transparent, height: 40,width: 40,
//                             child: Stack(
//                               children: [
//                                 Positioned(
//                                   right: 0,
//                                   child:  Material(
//                                   color: Colors.transparent,
//                                   child: InkWell(
//                                     borderRadius: new BorderRadius.circular(20.0),
//                                     onTap: (() {
//                                       Navigator.of(context).pop();
//                                     }),
//                                     child: Container(
//                                       width: 40,
//                                       height: 40,
//                                       color: Colors.transparent,
//                                       child: Image.asset('assets/images/closeIcon_v2.png')
//                                     ),
//                                   ),
//                                 ),)
//                               ],
//                             ),),)
//                         ],
//                       ),
//                     // Padding(
//                     //   padding: const EdgeInsets.only(top: 20),
//                     //   child: Center(
//                     //     child: Text('Network Error',
//                     //             style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 0, 0, 0)),
//                     //             )),
//                     // ),
//                     content: Builder(
//                       builder: (context) {

//                         return Container(
//                           height: 100,
//                           width: 280,
//                           child: Column(children: [
//                             Text('Please Connect to the internet.',
//                                 style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color: Color.fromARGB(255, 0, 0, 0)),),

//                             Padding(
//                               padding: const EdgeInsets.only(top: 23),
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   Navigator.of(ctx).pop();
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   primary: Color(0xFFFEDE00),
//                                   shadowColor: Colors.transparent,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(
//                                     left: 100,
//                                     right: 100,
//                                     top: 18,
//                                     bottom: 18
//                                   ),
//                                   child: const Text(
//                                     'Okay',
//                                     style: TextStyle(
//                                       fontSize: 18.0,
//                                       color: Colors.black,
//                                       fontFamily: 'Comfortaa',
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                     ),
//                                 ),
//                                 ),
//                             ),
//                           ],),
//                         );
//                       },
//                     ),
                    
//                   ),
//                 ),
//               ),
//             ),

            
//             ]);
//         });
//   }

// }





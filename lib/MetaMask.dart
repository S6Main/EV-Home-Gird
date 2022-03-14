import 'package:flutter/material.dart';


class MetaMask extends StatefulWidget {
  MetaMask({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MetaMaskState createState() => _MetaMaskState();
}

class _MetaMaskState extends State<MetaMask> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MetaMask'),
      ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 500,
              ),
              SizedBox(
                width: 300,
                height: 50,
                  child: Text(
                    "MetaMask: This Page for BlockChain",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),),
            ],
        )));
  }
}
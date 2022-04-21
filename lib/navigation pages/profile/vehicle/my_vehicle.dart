import 'package:flutter/material.dart';
import 'package:ev_homegrid/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class MyVehicle extends StatefulWidget {
  const MyVehicle({Key? key}) : super(key: key);

  @override
  State<MyVehicle> createState() => _MyVehicleState();
}

enum ChargerType {
  AC,
  DC,
  Both,
}

class _MyVehicleState extends State<MyVehicle> {
  static const customSizedBox = SizedBox(
    height: 25.0,
  );

  final vehicles = [
    'Vehicle1',
    'Vehicle2',
    'Vehicle3',
    'Vehicle4',
    'other',
  ];

  String? _selectedValue;
  bool isEnabled = true;
  ChargerType _chargerType = ChargerType.AC;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'My Vehicle',
          style: kProfileTitleStyle,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kHorizontalPadding),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 56.0,
                // margin: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      iconSize: 30.0,
                      hint: Text(
                        'Please select the vehicle',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                      value: _selectedValue,
                      items: vehicles.map(buildMenuItem).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value;
                          _selectedValue == 'other'
                              ? isEnabled = true
                              : isEnabled = false;
                        });
                      },
                    ),
                  ),
                ),
              ),
              customSizedBox,
              Column(
                children: [
                  MyVehicleTextField(
                    isEnabled: isEnabled,
                    labelText: 'My Vehicle',
                    hintText: 'Vehicle Name',
                  ),
                  customSizedBox,
                  MyVehicleTextField(
                    isEnabled: isEnabled,
                    labelText: 'Mileage',
                    hintText: '0',
                    keyboardType: TextInputType.number,
                  ),
                  // customSizedBox,
                  // MyVehicleTextField(
                  //   isEnabled: isEnabled,
                  //   labelText: 'Vehicle',
                  //   hintText: 'Vehicle Name',
                  // ),
                  customSizedBox,
                  Container(
                    width: double.infinity,
                    // color: Colors.amber,
                    child: Text(
                      'Charger Type',
                      style: TextStyle(
                        // color: Colors.blue,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'AC',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    leading: Radio<ChargerType>(
                      // visualDensity: VisualDensity.compact,

                      activeColor: kThemeColor,
                      value: ChargerType.AC,
                      groupValue: _chargerType,
                      onChanged: (ChargerType? value) {
                        setState(() {
                          _chargerType = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    dense: true,
                    title: Text(
                      'DC',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    leading: Radio<ChargerType>(
                      // visualDensity: VisualDensity.compact,
                      activeColor: kThemeColor,
                      value: ChargerType.DC,
                      groupValue: _chargerType,
                      onChanged: (ChargerType? value) {
                        setState(() {
                          _chargerType = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    dense: true,
                    title: Text(
                      'Both',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    leading: Radio<ChargerType>(
                      // visualDensity: VisualDensity.compact,
                      activeColor: kThemeColor,
                      value: ChargerType.Both,
                      groupValue: _chargerType,
                      onChanged: (ChargerType? value) {
                        setState(() {
                          _chargerType = value!;
                        });
                      },
                    ),
                  ),
                  customSizedBox,
                  customSizedBox,
                  Container(
                    child: Row(
                      children: [
                        CustomSaveButton(
                          buttonText: 'Cancel',
                          buttonColor: Colors.white,
                          buttonSideColor: kThemeColor,
                          textColor: Colors.black,
                        ),
                        Spacer(),
                        CustomSaveButton(
                          buttonText: 'Save',
                          buttonColor: kThemeColor,
                          buttonSideColor: kThemeColor,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String vehicles) {
    return DropdownMenuItem(
      value: vehicles,
      child: Text(
        vehicles,
        style: TextStyle(
          fontSize: 15.0,
        ),
      ),
    );
  }
}

class CustomSaveButton extends StatelessWidget {
  const CustomSaveButton({
    Key? key,
    required this.buttonText,
    required this.buttonColor,
    required this.buttonSideColor,
    this.textColor,
  }) : super(key: key);

  final String buttonText;
  final Color buttonColor;
  final Color buttonSideColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 0,
      constraints: BoxConstraints.tightFor(height: 45.0, width: 150.0),
      onPressed: () {},
      fillColor: buttonColor,
      child: Text(
        buttonText,
        style: TextStyle(
          // fontWeight: FontWeight.bold,
          color: textColor,
          fontSize: 15.0,
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
          side: BorderSide(color: buttonSideColor)),
    );
  }
}

class MyVehicleTextField extends StatelessWidget {
  const MyVehicleTextField(
      {Key? key,
      required this.labelText,
      this.hintText,
      this.testId,
      required this.isEnabled,
      this.keyboardType})
      : super(key: key);

  final String labelText;
  final String? hintText;
  final String? testId;
  final bool isEnabled;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data:
          ThemeData(primaryColor: Colors.black, primaryColorDark: Colors.black),
      child: TextField(
        style: TextStyle(
          fontSize: 15.0,
          fontFamily: 'Comfortaa',
        ),
        enabled: isEnabled,
        keyboardType: keyboardType,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          labelText: labelText,
          // focusColor: Colors.black,
          hintText: hintText,
          labelStyle: TextStyle(
            color: Colors.black,
          ),

          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black,
            width: 2,
          )),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              // width: 2,
            ),
          ),

          border: OutlineInputBorder(),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              // width: 2,
            ),
          ),
        ),
      ),
    );
  }
}

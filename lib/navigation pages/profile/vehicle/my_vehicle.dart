import 'package:flutter/material.dart';
import 'package:ev_homegrid/constants.dart';

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
    height: 20.0,
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
                // margin: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(12.0),
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
              customSizedBox,
              MyVehicleTextField(
                isEnabled: isEnabled,
                labelText: 'Vehicle',
                hintText: 'Vehicle Name',
              ),
              ListTile(
                title: Text(
                  'AC',
                  style: TextStyle(fontSize: 15.0),
                ),
                leading: Radio<ChargerType>(
                  // fillColor: ,
                  value: ChargerType.AC,
                  groupValue: _chargerType,
                  onChanged: (ChargerType? value) {
                    setState(() {
                      _chargerType = value!;
                    });
                  },
                ),
              ),
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
    return TextField(
      enabled: isEnabled,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        // focusColor: Colors.black,
        hintText: hintText,
        // enabledBorder: OutlineInputBorder(
        //   borderSide: BorderSide(color: Colors.black),
        // ),
        border: OutlineInputBorder(),
      ),
    );
  }
}

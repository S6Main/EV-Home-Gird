import 'package:flutter/material.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:input_history_text_field/input_history_text_field.dart';

class SearchBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchBarState();
}

const List<Tab> tabs = <Tab>[
  Tab(text: 'Two-wheeler'),
  Tab(text: 'Power Unit'),
  Tab(text: 'Two-wheeler'),
];

class SearchBarState extends State<SearchBar> {
  //get child => null;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context)!;
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {}
        });
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 120,
            // backgroundColor: Colors.blue,
            // foregroundColor: Colors.black,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Container(
              width: 250,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.blue)),
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.my_location_rounded,
                      color: Colors.green,
                    ),
                    suffix: GestureDetector(
                      onTap: () {
                        showPlacePicker();
                      },
                    ),
                    labelText: 'Your Location',
                    border: InputBorder.none),
              ),
            ),

            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.swap_vert_outlined,
                  size: 30,
                ),
                onPressed: () {
                  // handle the press
                },
              ),
            ],

            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              centerTitle: true,
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 250,
                    height: 40,
                    margin: EdgeInsets.only(top: 40.0),
                    padding: EdgeInsets.only(left: 2.0, right: 20.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.blue)),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),
                        suffix: GestureDetector(
                          onTap: () {
                            showPlacePicker();
                          },
                        ),
                        border: InputBorder.none,
                        labelText: 'Destination',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            bottom:
                TabBar(indicatorColor: Colors.white, indicatorWeight: 5, tabs: [
              Tab(icon: Icon(Icons.two_wheeler), text: "Two-wheeler"),
              Tab(icon: Icon(Icons.charging_station_sharp), text: "Power Unit"),
              Tab(icon: Icon(Icons.two_wheeler), text: "Two-wheeler"),
            ]),
          ),
          // body:
        );
      }),
    );
  }

  void showPlacePicker() async {
    LocationResult? result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            PlacePicker("AIzaSyDRVNoQs0tPPqyW2o5Qz36s-c2_jexKZYI")));

    // Handle the result in your way
    print(result);
  }
}

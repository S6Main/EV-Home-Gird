import 'package:flutter/material.dart';


class Guest extends StatefulWidget {

  @override
  _GuestState createState() => _GuestState();
}

class _GuestState extends State<Guest> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text('EV Charging',
          style: TextStyle(
            fontFamily: 'Quiapo',
            fontSize: 22.0,
            fontWeight: FontWeight.w600
          )),
      ),

    //Drawer
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
              accountName: new Text('Guest'),
              accountEmail: new Text('guestemail@email.com'),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: new NetworkImage(
                    'https://avatarfiles.alphacoders.com/848/84855.jpg'),
              ),
            ),
            new ListTile(
              title: new Text('Find Closest charger'),
              leading: Icon(Icons.location_on),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/nearby_screen');
              },
            ),
            new ListTile(
              title: new Text('Book Slot'),
              leading: Icon(Icons.library_add),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/request_screen');
              },
            ),
            new ListTile(
              title: new Text('Notification'),
              leading: Icon(Icons.notifications),
              onTap: () {
              },
            ),
            new ListTile(
              title: new Text('Settings'),
              leading: Icon(Icons.settings),
              onTap: () {},
            ),
            new ListTile(
              title: new Text('About'),
              leading: Icon(Icons.info_outline),
              onTap: () {},
            ),
          ],
        ),
      ),

//Search Bar
    body: new Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          margin: EdgeInsets.all(30),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 30,
                ),
              ),
              new Expanded(
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Find me the Closest Charger",
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    isDense: true,
                  ),
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ),

//Bottom Navigation Bar
    bottomNavigationBar: new Theme(
    data: Theme.of(context).copyWith(
    canvasColor: Colors.white,
    primaryColor: Colors.green,
    textTheme: Theme
        .of(context)
        .textTheme
        .copyWith(caption: new TextStyle(color: Colors.black))),
      child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded,size: 35),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_add,size: 35),
            title: Text('BookSlot', style: TextStyle(color: Colors.grey, fontSize: 16)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,size: 35),
            title: Text('Profile',style: TextStyle(color: Colors.grey, fontSize: 16),),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        selectedFontSize: 13.0,
        unselectedFontSize: 13.0,
      ),
    ),
    );
  }
}
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pop_pages/side_page.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';


class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     body:
       Column(
        children: [
          Container(

            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),]
            ),
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 15),
            
            child: Row(
              children: [
                Icon(Icons.menu, size: 25, color: Colors.black54,),
                Expanded(child: Container(
                  alignment: Alignment.center,
                  child: Text('New Berlin, WI 53151, USA', style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black26),),
                )),
                IconButton(
                  icon: Icon(Icons.search, size: 25, color: Colors.black54,),
                  onPressed: () {
                    //showSearch(context: context, delegate: CustomSearchDeligate());
                    
                  },
                ),
              ],
            ),
            
          ),
          
          
        ],
      ), 
    );
  }
}

class CustomSearchDeligate extends SearchDelegate{
  List<String> searchTerms = [
    //search terms
    'New York',
    'New York City',
    'New York State',
  ];

  

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
        ),
        
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );

  }

  @override
  Widget buildResults(BuildContext context) {
    
    List<String> matchQuery = [];
    for(var term in searchTerms){
      if(term.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(term);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index){
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];

      for(var term in searchTerms){
      if(term.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(term);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index){
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}
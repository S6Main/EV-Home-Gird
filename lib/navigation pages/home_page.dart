
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  static const historyLength = 5;
  List<String> _searchHistory = [
    'Search history 1',
    'Search history 2',
    'Search history 3',
    'Search history 4',
    'Search history 5',
  ];
  List<String> _searchHistoryFiltered = [];
  String _selectedTerm = '';
  
  List<String> filterSearchTerms({
  required String filter,
}) {
  if (filter != null && filter.isNotEmpty) {
    // Reversed because we want the last added items to appear first in the UI
    return _searchHistory.reversed
        .where((term) => term.startsWith(filter))
        .toList();
  } else {
    return _searchHistory.reversed.toList();
  }
}

void addSearchTerm(String term) {
  if (_searchHistory.contains(term)) {
    // This method will be implemented soon
    putSearchTermFirst(term);
    return;
  }
  _searchHistory.add(term);
  if (_searchHistory.length > historyLength) {
    _searchHistory.removeRange(0, _searchHistory.length - historyLength);
  }
  // Changes in _searchHistory mean that we have to update the filteredSearchHistory
  _searchHistoryFiltered = filterSearchTerms(filter: '');
}

void deleteSearchTerm(String term) {
  _searchHistory.removeWhere((t) => t == term);
  _searchHistoryFiltered = filterSearchTerms(filter: '');
}

void putSearchTermFirst(String term) {
  deleteSearchTerm(term);
  addSearchTerm(term);
}

@override
void initState() {
  super.initState();
  _searchHistoryFiltered = filterSearchTerms(filter: '');
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            padding: const EdgeInsets.only(top: 55, left: 20, right: 20, bottom: 15),
            
            child: Row(
              children: [
                Icon(Icons.menu, size: 25, color: Colors.black54,),
                Expanded(child: Container(
                  alignment: Alignment.center,
                  child: Text('New Berlin, WI 53151, USA', style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black26),),
                )),
                Icon(Icons.search, size: 25, color: Colors.black54,),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ev_homegrid/constants.dart';

import '../_widgets/BackButton.dart';
import 'package:styled_text/styled_text.dart';


class TermsPage extends StatefulWidget {

  const TermsPage({Key? key}) : super(key: key);

  @override
  State<TermsPage> createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  

  String _lastUpdated = 'June 26, 2021';
  String _one = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sed ac, tortor vestibulum id urna, semper ut. Non integer augue sagittis pulvinar auctor. Lectus arcu, tempus, auctor nulla tellus. Proin cras nulla commodo amet lobortis posuere <link>pellentesque</link>.';
  String  _two = 'imperdiet arcu metus, auctor et ipsum turpis enim neque. Placerat amet tellus metus sed. Sed mauris semper semper diam. Sit libero, massa aenean habitasse suscipit ut viverra enim';
  String _three = 'feugiat morbi mi consequat turpis. Consectetur in laoreet libero mi, habitant mattis aliquet commodo. Sit sed risus quam vitae adipiscing volutpat quam sed arcu. Turpis ligula sollicitudin justo netus molestie ac sapien, turpis semper. Tincidunt congue nibh varius consectetur cursus. Porta viverra etiam duis ut. Pellentesque leo cras consectetur scelerisque. Viverra in leo ';
  String _four = 'nunc in egestas sed. In blandit suspendisse at in posuere sit tortor. Auctor sollicitudin sit nulla massa.Orci purus nunc neque non gravida lectus egestas. Fames sit ullamcorper felis venenatis pulvinar. Viverra pharetra, vitae non enim. Vel, tristique nibh velit tristique.';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children : [
            Container(
              height: 140,
              color: Colors.transparent,
              child: BackButtonCustom()),
            Padding(
              padding: const EdgeInsets.only(left: 50,top: 140,right: 50),
              child: Container(
                height: 50,
                color: Colors.transparent,
                width: double.infinity,
                alignment: Alignment.topLeft,
                child: Text('Privacy policy', style: TextStyle(fontSize: 36,color: Colors.black, fontWeight: FontWeight.bold),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35,top: 190 ,right: 35, bottom: 60),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      offset: Offset(0, 0),
                      color: Colors.grey.withOpacity(0.1),),],
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 20,bottom: 20),
                  child: new SingleChildScrollView(
                    scrollDirection: Axis.vertical,//.horizontal
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: 
                        StyledText(
                            text: '<normal>$_one</normal><title>\n\nAugue\n\n</title><normal>$_two</normal><title>\n\n pretiumUt</title>\n\n<normal>$_three</normal><title>\n\nAccumsan\n\n</title><normal>$_four</normal>',
                            tags: {
                              'normal':StyledTextTag(
                                  style:TextStyle(fontWeight: FontWeight.normal, fontSize: 20, color: Colors.black),),
                              'link':StyledTextTag(
                                  style:TextStyle(fontWeight: FontWeight.normal, fontSize: 20, color: Colors.black,decoration: TextDecoration.underline),),
                              'title':StyledTextTag(
                                  style:TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Colors.black),)
                            },
                        ),
                        // child: new Text(
                        //   "1 Description that is too long in text format(Here Data is coming from API) jdlksaf j klkjjflkdsjfkddfdfsdfds " + 
                        //   "2 Description that is too long in text format(Here Data is coming from API) d fsdfdsfsdfd dfdsfdsf sdfdsfsd d " + 
                        //   "3 Description that is too long in text format(Here Data is coming from API)  adfsfdsfdfsdfdsf   dsf dfd fds fs" + 
                        //   "4 Description that is too long in text format(Here Data is coming from API) dsaf dsafdfdfsd dfdsfsda fdas dsad" + 
                        //   "5 Description that is too long in text format(Here Data is coming from API) dsfdsfd fdsfds fds fdsf dsfds fds " + 
                        //   "6 Description that is too long in text format(Here Data is coming from API) asdfsdfdsf fsdf sdfsdfdsf sd dfdsf" + 
                        //   "7 Description that is too long in text format(Here Data is coming from API) df dsfdsfdsfdsfds df dsfds fds fsd" + 
                        //   "8 Description that is too long in text format(Here Data is coming from API)" + 
                        //   "9 Description that is too long in text format(Here Data is coming from API)" + 
                        //   "10 Description that is too long in text format(Here Data is coming from API)",     
                        //   style: new TextStyle(
                        //     fontSize: 30, color: Colors.black,
                        //   ),
                        // ),
                      ),
                    ),
                  ),
                ),

              ),
            ),
            Positioned(
              bottom: 30,
              child: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text('Last updated: $_lastUpdated', style: TextStyle(fontSize: 15,color: Colors.black.withOpacity(0.4), fontWeight: FontWeight.normal),),
              )),
          ] 
        ),
    ),);
  }
}
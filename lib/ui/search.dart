 import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/notifiers/user_notifier.dart';
import 'package:provider_demo/ui/detail.dart';

class Search extends StatefulWidget {
   @override
   _SearchState createState() => _SearchState();
 }
 
 class _SearchState extends State<Search> {

   
   @override
   Widget build(BuildContext context) {
       final usernotifier = Provider.of<UserNotifier>(context);

     return Scaffold(
       backgroundColor: Colors.white,
       appBar: AppBar(
         title: Text('Search'),
         centerTitle: true,
         backgroundColor: Colors.white,
         elevation: 0.0,
       ),
       body:Column(
         
         children: <Widget>[
         Padding(
           padding: const EdgeInsets.symmetric(horizontal:12.0),
           child: TextField(
             controller: usernotifier.filter,
             decoration: InputDecoration(
               hintText: 'Enter name or timein',
               border:OutlineInputBorder()
             ),
             onChanged: (string)=>usernotifier.searchOnchanged(string),
           ),
         ),
         Expanded(
           child: ListView.builder(
             shrinkWrap: true,
             padding: EdgeInsets.all(10.0),
             itemCount: usernotifier.filteredList.length,
             itemBuilder: (BuildContext context, int index){
               return Card(
                 child: Padding(
                   padding: EdgeInsets.all(10.0),
                   child: GestureDetector(
                     onTap:(){
                       Navigator.of(context).push(
                         MaterialPageRoute(
                           builder: (BuildContext context){
                               return Detail(
                            id: usernotifier.filteredList[index].id.toString(),
                            name: usernotifier.filteredList[index].name,
                            address: usernotifier.filteredList[index].address,
                            phone: usernotifier.filteredList[index].phone,
                            purpose: usernotifier.filteredList[index].purpose,
                            who: usernotifier.filteredList[index].who,
                            timeIn: usernotifier.filteredList[index].timeIn,
                          );
                           }
                         )
                          );
                        },
                         child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(usernotifier.filteredList[index].name,
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.black)),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(usernotifier.filteredList[index].timeIn,
                              style:
                                  TextStyle(fontSize: 14.0, color: Colors.grey))
                        ],
                      ),
                       
                   ),
                 ),
               );
             },
           ),
         )
       ],)
     );
   }
   @override
  void initState() {
    Future.microtask(() => Provider.of<UserNotifier>(context).search());
    super.initState();
  }
 }
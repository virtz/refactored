import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/notifiers/user_notifier.dart';

class Detail extends StatefulWidget {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String purpose;
  final String appointmentTime;
  final String who;
  final String timeIn;

  const Detail(
      {Key key,
      this.id,
      this.name,
      this.address,
      this.phone,
      this.purpose,
      this.who,
      this.timeIn, this.appointmentTime})
      : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {

     final usernotifier = Provider.of<UserNotifier>(context);
     
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Details'),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                 SizedBox(height: (MediaQuery.of(context).size.height / 16)),
                 Container(
                    width: (MediaQuery.of(context).size.width),
                    child:  Card(
                  child: Container(
                      height: (MediaQuery.of(context).size.height / 6.5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(widget.name,
                                style: TextStyle(
                                    fontSize: 19.0, fontWeight: FontWeight.w800)),
                            SizedBox(height: 8.0),
                            Text(widget.address),
                          ],
                        ),
                      )),
                ),
                
                 ),
                 Card(
                   child: Column(
                     children: <Widget>[
                       Container(
                         padding:EdgeInsets.all(12.0),
                         child: Column(
                           children: <Widget>[
                             Align(
                               alignment: Alignment.topLeft,
                               child: Text('Purpose',
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w700,
                                )),
                             ),
                              SizedBox(
                            height: 10.0,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(widget.purpose),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Divider(
                            thickness: 1.0,
                            indent: 1.0,
                            color: Colors.yellow,
                          )
                           ],
                         ),
                       ),
                        Container(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text('Phone',
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w700,
                                )),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(widget.phone),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Divider(
                            thickness: 1.0,
                            indent: 1.0,
                            color: Colors.yellow,
                          )
                        ],
                      ),
                    ),
                                 Container(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text('Time In',style:TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w700,
                          
                        )),
                      ),
                      SizedBox(height: 10.0,),
                       Align(
                        alignment: Alignment.topLeft,
                        child: Text(widget.timeIn),
                      ),
                      SizedBox(height: 5.0,),
                      Divider(
                        thickness: 1.0,
                        indent: 1.0,
                        color: Colors.yellow,
                      )
                    ],
                  ),
                ),
              //    SizedBox(
              //   height:(MediaQuery.of(context).size.height/21)
              // ),
                  Container(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text('Appointment Time',style:TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w700,
                          
                        )),
                      ),
                      SizedBox(height: 10.0,),
                       Align(
                        alignment: Alignment.topLeft,
                        child: Text(widget.appointmentTime),
                      ),
                      SizedBox(height: 5.0,),
                      Divider(
                        thickness: 1.0,
                        indent: 1.0,
                        color: Colors.yellow,
                      )
                    ],
                  ),
                ),
                 SizedBox(
                height:(MediaQuery.of(context).size.height/21)
              ),
                 Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: (MediaQuery.of(context).size.width/2- 30),
                          height: (MediaQuery.of(context).size.height /14),
                      child: RaisedButton(
                        onPressed: ()=>
                          usernotifier.acceptRequest(context, widget.id, widget.name),
                        //  print(widget.id),
                        
                        shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.white)),
                      color: Colors.white,
                      child: Text('Accept'),
                      ),
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: (MediaQuery.of(context).size.width/2 - 30),
                          height: (MediaQuery.of(context).size.height /14),
                      child: RaisedButton(onPressed: ()=>usernotifier.declineRequest(context, widget.id, widget.name),
                        shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.white)),
                      color: Colors.white,
                      child: Text('Decline'),
                      ),
                    ),
                  ),
                  
                ],
              ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: (MediaQuery.of(context).size.width),
                          height: (MediaQuery.of(context).size.height /14),
                      child: RaisedButton(
                        onPressed: () =>usernotifier.deleteVisitor(context, widget.id),
                        shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.white)),
                      color: Colors.white,
                      child: Text('Delete'),
                      ),
                    ),
                  ),
                  SizedBox(height:  (MediaQuery.of(context).size.height/20))
                     ],
                   ),
                 )
              ],
            ),
          ),
        ));
  }
}

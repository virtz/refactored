import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/notifiers/visitor_notifier.dart';
import 'package:provider_demo/utils/appdata.dart';


class VisitorSignIn extends StatefulWidget {
  @override
  _VisitorSignInState createState() => _VisitorSignInState();
}

class _VisitorSignInState extends State<VisitorSignIn> {


  @override
  Widget build(BuildContext context) {
      // final scaffoldKey = GlobalKey<ScaffoldState>();
    final visitorNotifier = Provider.of<VisitorNotifier>(context);
    var size = MediaQuery.of(context).size;
    // visitorNotifier.getUserList();
    return SafeArea(
        child: Scaffold(
      key: visitorNotifier.scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
         // key:RIKeys.riKey1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Align(alignment: Alignment.topLeft, child: BackButton()),
              Flexible(
                  //fit: FlexFit.loose,
                  child: Image.asset('assets/images/signin1.jpg')),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: visitorNotifier.name,
                      decoration: InputDecoration(
                          hintText: 'Enter name',
                          labelText: 'Name',
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: size.height / 36,
                    ),
                    TextField(
                      controller: visitorNotifier.address,
                      decoration: InputDecoration(
                          hintText: 'Enter address',
                          labelText: 'Address',
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: size.height / 36,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: visitorNotifier.phone,
                      decoration: InputDecoration(
                          hintText: 'Enter phone',
                          labelText: 'Phone',
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: size.height / 36,
                    ),
                    TextField(
                      controller: visitorNotifier.purpose,
                      decoration: InputDecoration(
                          hintText: 'Enter purpose',
                          labelText: 'Purpose',
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: size.height / 36,
                    ),
              
                      //todo:appointment time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                    Container(
                        width: size.width/2.5,
                       decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:5.0),
                        child: DropdownButtonHideUnderline(
                          child:DropdownButton<String>(
                            hint:Text('Appointment'),
                            value: visitorNotifier.mySelection1,
                            onChanged:visitorNotifier.changeTimeOption1,
                            items: time.map((time){
                              return DropdownMenuItem<String>(
                                value:time.name,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Text(time.name)),
                                ),
                              );
                            }).toList(),
                          ) ,
                        ),
                      ),
                    ),
                    Container(

                      width: size.width/2.5,
                       decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:5.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                             hint:Text('Time'),
                             value: visitorNotifier.mySelection2,
                             onChanged: visitorNotifier.changeTimeOption2,
                             items: time2.map((time2){
                               return DropdownMenuItem<String>(
                                 value: time2.name,
                                 child: Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Center(child: Text(time2.name)),
                                 ),
                               );
                             }).toList(),
                          ),
                        ),
                      ),
                    )
                    ],
                  ),
                   SizedBox(
                      height: size.height / 36,
                    ),
                    Consumer<VisitorNotifier>(
                      builder: (context, visitorNotifier, child) => Container(
                        width: size.width - 30,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white),
                        child: DropdownButtonHideUnderline(
                          child: new DropdownButton<String>(
                            items: visitorNotifier.users.map((user) {
                              return new DropdownMenuItem<String>(
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Text(user.name),
                                )),
                                value: user.name,
                              );
                            }).toList(),
                            hint: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Who you're here to see"),
                            ),
                            onChanged: visitorNotifier.changeOption,
                            value: visitorNotifier.mySelection,
                           
                          ),
                        
                        ),
                      ),
                   ),
                    SizedBox(
                      height: size.height / 36,
                    ),
                    Container(
                      width: size.width - 30,
                      child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          height: size.height / 13,
                          color: Theme.of(context).primaryColor,
                          onPressed: () => visitorNotifier.signIn(context),
                          child: Text(
                            'Sign in',
                            style: TextStyle(fontSize: 18.0),
                          )),
                    ),
                    SizedBox(
                      height: size.height / 36,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  initState() {
    super.initState();
    Future.microtask(() => Provider.of<VisitorNotifier>(context).getUserList());
  }
  
 
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/notifiers/user_notifier.dart';
import 'package:provider_demo/ui/visitor_sigin.dart';


class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
     final usernotifier = Provider.of<UserNotifier>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: size.height / 30,
            ),
            Align(
                alignment: Alignment.center,
                child: Text('Elixer',
                    style: TextStyle(
                        fontSize: 30.0, fontWeight: FontWeight.bold))),
            SizedBox(
              height: 4,
            ),
            Align(
                alignment: Alignment.center,
                child: Text('the best at visitor management',
                    style: TextStyle(
                        fontSize: 15.0, fontStyle: FontStyle.italic))),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(color: Colors.transparent),
                    child: Image.asset('assets/images/visitor.jpg')),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45))),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 8.0, right: 8.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 18.0),
                        child: Text('Hi, are you an',
                            style: TextStyle(
                                fontSize: 23.0, fontWeight: FontWeight.w700)),
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        height: size.height / 11,
                        color: Colors.white,
                        minWidth: size.width - 50,
                        onPressed: () =>usernotifier.checkSignedIn(context),
                        child: Text(
                          'Employee ?',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        elevation: 5.0,
                      ),
                      //  SizedBox(height: size.height/50,),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Text('or ',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w700)),
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        height: size.height / 11,
                        color: Colors.white,
                        minWidth: size.width - 50,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  VisitorSignIn()));    Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  VisitorSignIn()));
                        },
                        elevation: 5.0,
                        child: Text(
                          'Visitor ?',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

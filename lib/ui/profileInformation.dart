import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/notifiers/user_notifier.dart';

class ProfileInfo extends StatefulWidget {
  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  Widget build(BuildContext context) {
    final usernotifier = Provider.of<UserNotifier>(context);
    usernotifier.getUserCredentials();
     var size = MediaQuery.of(context).size;
    return Scaffold(
      key:usernotifier.scaffoldKey2,
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Profile Information"),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: usernotifier.isLoading
            ? Container()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                          height: (MediaQuery.of(context).size.height / 30)),
                      Container(
                        width: (MediaQuery.of(context).size.width),
                        child: Container(
                          width: (MediaQuery.of(context).size.height / 6.5),
                          child: Center(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  usernotifier.name1 == null
                                      ? "your name"
                                      : usernotifier.name1,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500),
                                )),
                          ),
                        ),
                      ),
                      Card(
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(12.0),
                              child: Column(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text('User ID',
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
                                    child: Text(usernotifier.id == null
                                        ? 'your Id'
                                        : usernotifier.id),
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
                                    child: Text('Email',
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
                                    child: Text(usernotifier.email1 == null
                                        ? "your email"
                                        : usernotifier.email1),
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
                                    child: Text('Admin Status',
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
                                    child: Text(usernotifier.isAdmin == "false"
                                        ? "You're not an Admin"
                                        : "You're an Admin"),
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
                                  child: Text('Status',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w700,
                                      )),
                                ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(usernotifier.status == null
                                              ? "your status"
                                              : usernotifier.status)),
                                      FlatButton(
                                        color: Colors.yellow,
                                        child: Text('Change'),
                                        onPressed: () {
                                          usernotifier.changeStatusDialogue(
                                              context,
                                              usernotifier.chnStatus,
                                              'Status Change',
                                              size.height/2,
                                              'assets/images/fresh_notification.png');
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                                  SizedBox(
                              height:
                                  (MediaQuery.of(context).size.height / 30)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: (MediaQuery.of(context).size.width),
                              height: (MediaQuery.of(context).size.height / 14),
                              child: RaisedButton(
                                onPressed: () {
                                 usernotifier.deleteMyAcct(context);
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.white)),
                                color: Colors.white,
                                child: Text('Delete Account'),
                              ),
                            ),
                          )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ));
  }

  initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<UserNotifier>(context).getUserCredentials());
  }
}

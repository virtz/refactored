import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider_demo/models/user.dart';

import 'package:provider_demo/models/visitor.dart';
import 'package:provider_demo/services/visitorService.dart';
import 'package:provider_demo/ui/users_page.dart';
import 'package:provider_demo/ui/visitor_sigin.dart';
import 'package:provider_demo/utils/tools.dart';

class VisitorNotifier with ChangeNotifier {
 
  VisitorNotifier();
  Visitor visitor;
  String mySelection;
  var data = [];
  var users = List<User>();
  bool b = false;
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController purpose = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  getUserList() {
    VisitorService.getUsers().then((response) {
      Iterable list = json.decode(response.body);
      users = list.map((model) => User.fromJson(model)).toList();
      notifyListeners();
      return users;
    });
  }

  void changeOption(newVal) {
    mySelection = newVal;
    print(mySelection);
    notifyListeners();
  }

  clearTextFields() {
    name.text = "";
    address.text = "";
    phone.text = "";
    purpose.text = "";
    notifyListeners();
  }

  signIn(BuildContext context) async {
    if (name.text == "" || name.text.length <= 5) {
      showSnackBar(
          message: 'Please enter your name or name is too short',
          key: scaffoldKey);
      return;
    }
    if (address.text == "" || address.text.length <= 5) {
      showSnackBar(
          message: 'Please enter your address or address is too short',
          key: scaffoldKey);
      return;
    }
    if (phone.text == "") {
      showSnackBar(message: 'Please enter your phone', key: scaffoldKey);
      return;
    }
    if (purpose.text == "") {
      showSnackBar(message: 'Please enter your purpose', key: scaffoldKey);
      return;
    }
    if (mySelection == "") {
      showSnackBar(
          message: "We need to know who you're here to see", key: scaffoldKey);
      return;
    }

    displayProgressDialog(context);

    bool success = await VisitorService.signIn(
            name.text, address.text, phone.text, purpose.text, mySelection)
        .whenComplete(() {});
    clearTextFields();
    closeProgressDialog(context);
    if (success = true && success != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => Users()),
          (Route route) => route == null);
    } else {
      showSnackBar(message: "Sorry An Error Occured", key: scaffoldKey);
    }
    notifyListeners();
  }

  signOut(context) async {
    bool a = await VisitorService.signOut().whenComplete(() {});
    print(a);
    if (a == true) {
      //  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>VisitorSignIn()));
    }
  }

  alertDialogue(
      BuildContext context, String message, String header, double height) {
    showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Center(child: Text(header)),
            content: Container(
              height: height,
              child: Column(
                children: <Widget>[
                  Divider(),
                  Expanded(child: Image.asset('assets/images/thought.png')),
                  Text(message),
                  SizedBox(height: 30.0)
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel", style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
              FlatButton(
                  child:
                      Text("Continue", style: TextStyle(color: Colors.black)),
                  onPressed: () async {
                    b = true;
                    bool a = await VisitorService.signOut().whenComplete(() {});
                    print(a);
                    if (a == true) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  VisitorSignIn()),
                          (Route route) => route == null);
                    }
                  }),
            ],
          );
        });
  }
}

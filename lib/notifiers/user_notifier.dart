import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider_demo/models/visitor.dart';
import 'package:provider_demo/services/api.dart';
import 'package:provider_demo/ui/employee_login.dart';
import 'package:provider_demo/ui/notifications.dart';

import 'package:provider_demo/utils/tools.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserNotifier with ChangeNotifier {
  bool isAdmin = false;
  var visitors = List<Visitor>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  TextEditingController ename = TextEditingController();
  TextEditingController eemail = TextEditingController();
  TextEditingController epassword = TextEditingController();
  int vague = 0;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final escaffoldKey = GlobalKey<ScaffoldState>();

  onChange(val) {
    isAdmin = val;
    notifyListeners();
  }

  changeObscureText() {
    if (vague == 0) {
      vague = 1;
    } else if (vague == 1) {
      vague = 0;
    }
    notifyListeners();
  }

  getVisitorInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var who = prefs.getString('name');
    var eWho = prefs.getString('eName');

    Api.getVisitors().then((response) {
      Iterable list = json.decode(response.body);
      visitors = list
          .map((model) => Visitor.fromJson(model))
          .where((i) => i.who == eWho || i.who == who)
          .toList();
      print(visitors);

      return visitors;
    });
    notifyListeners();
  }

  signup(BuildContext context) async {
    if (name.text == "" || name.text.length <= 5) {
      showSnackBar(
          message: 'Please enter your name or name is too short',
          key: scaffoldKey);
      return;
    }
    if (email.text == "") {
      showSnackBar(message: 'Please enter your email', key: scaffoldKey);
      return;
    }
    if (password.text == "" || password.text.length <= 5) {
      showSnackBar(
          message: 'Please enter your password or password is too short',
          key: scaffoldKey);
      return;
    } else if (password.text.length <= 5) {
      showSnackBar(message: 'Password is too short', key: scaffoldKey);
    }
    displayProgressDialog(context);
    String success = await Api.signUp(
            name.text, email.text, password.text, isAdmin.toString())
        .whenComplete(() {
      clearTextFields();
    });
    if (success == "success") {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => EmployeeLogin()),
          (Route route) => route == null);
    } else {
      success = null
          ? success = "Sorry An Erro Occured"
          : success = "Can't reach server at the moment";
      showSnackBar(message: success, key: scaffoldKey);
    }
  }

  clearTextFields() {
    name.text = "";
    email.text = "";
    password.text = "";
  }

  clearTextField2() {
    eemail.text = "";
    epassword.text = "";
    ename.text = "";
  }

  signIn(BuildContext context) async {
    if (eemail.text == "" || eemail.text.length <= 5) {
      showSnackBar(message: 'Please enter valid email', key: escaffoldKey);
      return;
    }
    if (epassword.text == "" || epassword.text.length <= 5) {
      showSnackBar(message: "Please enter valid password", key: escaffoldKey);
      return;
    }
    displayProgressDialog(context);

    bool success = await Api.signIn(ename.text, eemail.text, epassword.text)
        .whenComplete(() {
      notifyListeners();
    });
    clearTextField2();
    closeProgressDialog(context);
    if (success == true) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => Notifications()),
          (Route route) => route == null);
    } else {
      showSnackBar(message: success.toString(), key: escaffoldKey);
    }
    notifyListeners();
  }

  alertDialogue(BuildContext context, String message, String header,
      double height, String imageLnk) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Center(child: Text(header)),
            content: Container(
              height: height,
              child: Column(
                children: <Widget>[
                  Divider(),
                  Expanded(child: Image.asset(imageLnk)),
                  Text(message),
                  SizedBox(height: 30.0)
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel", style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                  child: Text("Ok", style: TextStyle(color: Colors.black)),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  checkSignedIn(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedIn = prefs.getBool('isLoggedin');
    loggedIn == true
        ? Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => Notifications()),
            (Route route) => route == null)
        : Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => EmployeeLogin()),
            (Route route) => route == null);
  }

  // signOut(BuildContext context) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.remove('isLoggedin');
  //   prefs.remove('token');

  //   Navigator.of(context).pushAndRemoveUntil(
  //       MaterialPageRoute(builder: (BuildContext context) => EmployeeLogin()),
  //       (Route route) => route == null);

  //       notifyListeners();
  // }

  signoutDialogue(BuildContext context, String message, String header,
      double height, String imageLnk) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Center(child: Text(header)),
            content: Container(
              height: height,
              child: Column(
                children: <Widget>[
                  Divider(),
                  Expanded(child: Image.asset(imageLnk)),
                  Text(message),
                  SizedBox(height: 30.0)
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel", style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                  child: Text("Yes, Continue", style: TextStyle(color: Colors.black)),
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove('isLoggedin');
                    prefs.remove('token');

                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => EmployeeLogin()),
                        (Route route) => route == null);
                  notifyListeners();
                  }),
            ],
          );
        });
  }
}

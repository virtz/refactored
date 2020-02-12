import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider_demo/models/user.dart';
import 'package:provider_demo/models/visitor.dart';
import 'package:provider_demo/services/api.dart';
import 'package:provider_demo/services/debouncer.dart';
import 'package:provider_demo/services/visitorService.dart';
import 'package:provider_demo/ui/detail.dart';
import 'package:provider_demo/ui/employee_login.dart';
import 'package:provider_demo/ui/employee_signup.dart';
import 'package:provider_demo/ui/notifications.dart';
import 'package:provider_demo/ui/search.dart';
import 'package:provider_demo/ui/settings.dart';

import 'package:provider_demo/utils/tools.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserNotifier with ChangeNotifier {
  //variables
  bool isAdmin = false;
  var visitors = List<Visitor>();
  var users = List<User>();
  String mySelection;
  String mySelection1;
  //text editing controllers

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  TextEditingController ename = TextEditingController();
  TextEditingController eemail = TextEditingController();
  TextEditingController epassword = TextEditingController();
  int vague = 0;

  //scaffold keys
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final escaffoldKey = GlobalKey<ScaffoldState>();
  final scaffoldKey1 = GlobalKey<ScaffoldState>();
  final scaffoldKey2 = GlobalKey<ScaffoldState>();

//other variables
  List<Visitor> visitors1 = List<Visitor>();
  List<Visitor> filteredList = List();
  final debouncer = Debouncer(milliseconds: 500);
  TextEditingController filter = new TextEditingController();
  TextEditingController chnStatus = new TextEditingController();

//user variables
  String name1;
  String email1;
  String id;
  String status;
  String isAdmin1;
  bool switchOn = true;
  bool isLoading = true;

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
    notifyListeners();
  }

  clearTextField2() {
    eemail.text = "";
    epassword.text = "";
    ename.text = "";
    notifyListeners();
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
                  notifyListeners();
                },
              ),
              FlatButton(
                  child: Text("Ok", style: TextStyle(color: Colors.black)),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    notifyListeners();
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
                  child: Text("Yes, Continue",
                      style: TextStyle(color: Colors.black)),
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

  openSearch(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext contex) => Search()));
  }

  openDetails(BuildContext context, int index) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => Detail(
              id: visitors[index].id.toString(),
              name: visitors[index].name,
              address: visitors[index].address,
              phone: visitors[index].phone,
              purpose: visitors[index].purpose,
              appointmentTime: visitors[index].appoinmentTime,
              who: visitors[index].who,
              timeIn: visitors[index].timeIn,
            )));
    print(visitors[index].appoinmentTime);
    notifyListeners();
  }

  // deleteVisitor(String id){

  // }

  acceptRequest(BuildContext context, String id, String name) {
    String status = "Accepted";
    Api.updateVisitorStats(id, status, name).whenComplete(() {
      Navigator.of(context).pop();
      print(status);
    }).catchError((e) => print(e));
    notifyListeners();
  }

  declineRequest(BuildContext context, String id, String name) {
    String status = "Declined";

    Api.updateVisitorStats(id, status, name).whenComplete(() {
      Navigator.of(context).pop();
      print(status);
    }).catchError((e) => print(e));

    notifyListeners();
  }

  deleteVisitor(BuildContext context, String id) {
    Api.deleteVisitor(id).whenComplete(() {
      Navigator.of(context).pop();
    }).catchError((e) => print(e));
    notifyListeners();
  }

  search() {
    Api.getVisitor2().then((visitorsfromServer) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var who = prefs.getString('name');
      var eWho = prefs.getString('eName');
      visitors1 = visitorsfromServer
          .where((i) => i.who == who || i.who == eWho)
          .toList();
      filteredList = visitors1;
      notifyListeners();
    });
  }

  searchOnchanged(String string) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var who = prefs.getString('name');
    var eWho = prefs.getString('eName');
    filteredList = visitors1
        .where((u) =>
            u.who == who ||
            u.who == eWho &&
                (u.name.toLowerCase().contains(string.toLowerCase()) ||
                    u.timeIn.toLowerCase().contains(string.toLowerCase())))
        .toList();
    notifyListeners();
  }

  openSettings(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => Settings()));
    notifyListeners();
  }

  getUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id');
    name1 = prefs.getString('eName');
    email1 = prefs.getString('email');
    status = prefs.getString('status');
    isAdmin1 = prefs.getString('isAdmin');
    isLoading = false;

    notifyListeners();
  }

  changeStatuss() async {
    bool a = await Api.updateStatus(id, chnStatus.text);
    if (a == true) {
      print("Update successfull");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('status', chnStatus.text);
      prefs.setString('id', id);

      status = prefs.getString('status');
      notifyListeners();
    } else {
      print("An error occured");
    }
  }

  changeStatusDialogue(BuildContext context, TextEditingController changeStatus,
      String header, double height, String imageLnk) {
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
                  TextField(
                    controller: changeStatus,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30.0)
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel", style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.of(context).pop();
                  notifyListeners();
                },
              ),
              FlatButton(
                child: Text("Yes, Continue",
                    style: TextStyle(color: Colors.black)),
                onPressed: () {
                  changeStatuss();
                  Navigator.of(context).pop();
                  notifyListeners();
                },
              ),
            ],
          );
        });
  }

  deleteMyAcct(BuildContext context) async {
    bool a = await Api.deleteMyAcct(id);
    print(id);
    if (a == true) {
      print('Account Deleted');
      showSnackBar(message: "Your Account Has Been Deleted", key: scaffoldKey2);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => EmployeeSign()),
          (Route route) => route == null);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('id');
      prefs.remove('name');
      prefs.remove('isAdmin');
      prefs.remove('status');
      prefs.remove('token');
      prefs.remove('isLoggedin');

      notifyListeners();
    } else {
      showSnackBar(message: "An Error Occurred", key: scaffoldKey2);
    }
  }

  getUsers() {
    VisitorService.getUsers().then((response) {
      Iterable list = json.decode(response.body);
      users = list.map((model) => User.fromJson(model)).toList();
    });
  }

  deleteUser(BuildContext context, int index,String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var adminStatus = prefs.getString('isAdmin');
    if (adminStatus == 'true') {
      Api.deleteUser(id).whenComplete(() {
        //Navigator.of(context).pop();
      });
    } else {
      unabletoDelete(context, "You cannot delete this resource", "Unathorized",
          300, "assets/images/no_notification.png");
    }
  }

  unabletoDelete(BuildContext context, String message, String header,
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
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Ok", style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.of(context).pop();
                  notifyListeners();
                },
              ),
            ],
          );
        });
  }
}

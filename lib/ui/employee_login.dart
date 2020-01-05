import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/notifiers/user_notifier.dart';
import 'package:provider_demo/ui/employee_signup.dart';

class EmployeeLogin extends StatefulWidget {
  @override
  _EmployeeLoginState createState() => _EmployeeLoginState();
}

class _EmployeeLoginState extends State<EmployeeLogin> {
  @override
  Widget build(BuildContext context) {
     final userNotifier = Provider.of<UserNotifier>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key:userNotifier.escaffoldKey,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Expanded(child: Image.asset('assets/images/employee.png')),
          Column(
            children: <Widget>[
               TextField(
                controller: userNotifier.ename,
                decoration: InputDecoration(
                    hintText: 'Enter name',
                    labelText: 'Name',
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: size.height / 36,
              ),
              TextField(
                controller: userNotifier.eemail,
                decoration: InputDecoration(
                    hintText: 'Enter email',
                    labelText: 'Email',
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: size.height / 36,
              ),
              GestureDetector(
                onDoubleTap: ()=>userNotifier.changeObscureText(),
                              child: TextField(
                  obscureText: userNotifier.vague ==0?true:false,
                   controller: userNotifier.epassword,
                  decoration: InputDecoration(
                      hintText: 'Enter password',
                      labelText: 'Password',
                      border: OutlineInputBorder()),
                ),
              ),
              SizedBox(
                height: size.height / 36,
              ),
              Container(
                width: size.width - 29,
                child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    height: size.height / 13,
                    color: Theme.of(context).primaryColor,
                    onPressed: () =>userNotifier.signIn(context),
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 18.0),
                    )),
              ),
              SizedBox(
                height: size.height / 43,
              ),
              GestureDetector(
                onTap: (){
                       Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  EmployeeSign()));
                },
                child: RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        text: "Not a registered employee ? ",
                        children: <TextSpan>[
                      TextSpan(text: 'Sign up', style: TextStyle())
                    ])),
              ),
              SizedBox(
                height: size.height / 20,
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

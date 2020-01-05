

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/notifiers/user_notifier.dart';

class EmployeeSign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     final userNotifier = Provider.of<UserNotifier>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key:userNotifier.scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Expanded(child: Image.asset('assets/images/employee_sign.png')),
          Column(
            children: <Widget>[
               TextField(
                 controller: userNotifier.name,
                decoration: InputDecoration(
                    hintText: 'Enter name',
                    labelText: 'Name',
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: size.height / 36,
              ),
              TextField(
                controller: userNotifier.email,
                decoration: InputDecoration(
                    hintText: 'Enter email',
                    labelText: 'Email',
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: size.height / 36,
              ),
              GestureDetector(
                onDoubleTap:()=> userNotifier.changeObscureText(),
                              child: TextField(
                                controller: userNotifier.password,
                  obscureText: userNotifier.vague == 0?true:false,
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
                    onPressed: () {
                      userNotifier.signup(context);
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(fontSize: 18.0),
                    )),
              ),
              SizedBox(
                height: size.height / 36,
              ),
              Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                   Text("Admin"),
                   Consumer<UserNotifier>(
                      builder: (context, userNotifier, child) =>
                                         Checkbox(
                       activeColor: Theme.of(context).primaryColor,
                       checkColor:Colors.black ,
                       tristate: false,
                       onChanged: userNotifier.onChange,
                       value: userNotifier.isAdmin,
                     ),
                   )
                ],),
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
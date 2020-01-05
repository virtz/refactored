import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/notifiers/user_notifier.dart';
import 'package:provider_demo/notifiers/visitor_notifier.dart';
import 'package:provider_demo/ui/landing_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
       ChangeNotifierProvider<UserNotifier>(
         create:(_)=>UserNotifier()
       ),
            ChangeNotifierProvider<VisitorNotifier>(
         create:(_)=>VisitorNotifier()
       ),
      ],
           child: MaterialApp(
          title: 'V.M.S',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.yellow,
          ),
          home: LandingPage()));
    
  }
}

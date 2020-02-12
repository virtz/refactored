import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/notifiers/user_notifier.dart';
import 'package:provider_demo/ui/profileInformation.dart';
import 'package:provider_demo/ui/users_page.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

        final usernotifier = Provider.of<UserNotifier>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Settings"),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
                SizedBox(height: (MediaQuery.of(context).size.height / 20)),
                 ListTile(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                    return ProfileInfo();
                  }));
                },
                leading: Text(
                  'Profile Information',
                  style: TextStyle(fontSize: 17.0,
                  fontWeight: FontWeight.w500),
                ),
                trailing: Icon(
                  FontAwesomeIcons.info,
                  size: 17.0,
                ),
              ),
              ListTile(leading: Text('Sign Out',style:TextStyle(fontSize: 17.0,
              fontWeight: FontWeight.w500)),trailing: Icon(FontAwesomeIcons.signOutAlt),
              onTap: () =>usernotifier.signoutDialogue(
            context,
            'You want to sign out ?',
            "Sign Out",
            size.height / 2.5,
            "assets/images/thought.png"),),
              ListTile(leading: Text('Users',style:TextStyle(fontSize: 17.0,
              fontWeight: FontWeight.w500)),trailing: Icon(Icons.person),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                 return  Users();
                  }));
              },),
            ],
          ),
        ));
  }
}

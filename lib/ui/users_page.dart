import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/notifiers/user_notifier.dart';
import 'package:provider_demo/notifiers/visitor_notifier.dart';

class Users extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Users> {
  @override
  Widget build(BuildContext context) {
    final visitorNotifier = Provider.of<VisitorNotifier>(context);
    final usernotifier = Provider.of<UserNotifier>(context);
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: FutureBuilder(
          future: visitorNotifier.getUserList(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: visitorNotifier.users.length,
              itemBuilder: (context, index) {
                return Container(
                  child: GestureDetector(
                    onDoubleTap: () {
                      // _alertDialogue1(
                      //     context,
                      //     "${visitors[index].name} requested to see you on ${visitors[index].timeIn} ",
                      //     'Visit Requests');
                    },
                    child: Consumer<VisitorNotifier>(
                      builder: (context, visitorNotifier, child) => Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        elevation: 1.5,
                        child: ListTile(
                            onTap: () {},
                            leading: Text(visitorNotifier.users[index].name,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w700)),
                            trailing: FlatButton(
                                onPressed: () {
                                  usernotifier.deleteUser(context, index,visitorNotifier.users[index].id);
                                },
                                child: Text('Delete'))),
                      ),
                    ),
                  ),
                );
              },
            );
          }),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () =>visitorNotifier.alertDialogue(context,"You're about to sign out",'Sign out',size.height/3),
      //   backgroundColor: Theme.of(context).primaryColor,
      //   child: Icon(Icons.exit_to_app,color: Colors.black,),
      // )
    );
  }
}

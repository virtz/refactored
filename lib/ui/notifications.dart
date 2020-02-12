import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/notifiers/user_notifier.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    final usernotifier = Provider.of<UserNotifier>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Notifications'),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left:4.0,right:4.0),
            child: IconButton(
              onPressed: ()=>usernotifier.openSearch(context),
              icon: Icon(Icons.search),
            ),
          ),
            Padding(
              padding: const EdgeInsets.only(left:4.0,right: 8.0),
              child: IconButton(
              onPressed: ()=>usernotifier.openSettings(context),
              icon: Icon(Icons.settings),
          ),
            ),
        ],
      ),
      body: Container(
        child: FutureBuilder(
            future: usernotifier.getVisitorInfo(),
            builder: (context, snapshot) {
              if (usernotifier.visitors.length == 0) {
                return noDataFound();
              }
              return ListView.builder(
                itemCount: usernotifier.visitors.length,
                itemBuilder: (context, index) {
                  return Container(
                      child: GestureDetector(
                    onDoubleTap: () => usernotifier.alertDialogue(
                        context,
                        "${usernotifier.visitors[index].name} requested to see you on ${usernotifier.visitors[index].timeIn}",
                        'Visit Requests',
                        size.height / 2,
                        'assets/images/fresh_notification.png'),
                    child: Consumer<UserNotifier>(
                      builder: (context, userNotifier, child) => Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        elevation: 1.5,
                        child: ListTile(
                          onTap: () =>userNotifier.openDetails(context, index),
                          leading: Text(usernotifier.visitors[index].name,
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.w700)),
                          trailing: Text(usernotifier.visitors[index].timeIn,
                              style: TextStyle(
                                  fontSize: 11.0, fontStyle: FontStyle.italic)),
                        ),
                      ),
                    ),
                  ));
                },
              );
            }),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => usernotifier.signoutDialogue(
      //       context,
      //       'You want to sign out ?',
      //       "Sign Out",
      //       size.height / 2.5,
      //       "assets/images/thought.png"),
      //   backgroundColor: Theme.of(context).primaryColor,
      //   child: Icon(
      //     Icons.exit_to_app,
      //     color: Colors.black,
      //   ),
      // ),
    );
  }

  initState() {
    super.initState();
    Future.microtask(() => Provider.of<UserNotifier>(context).getVisitorInfo());
  }

  Widget noDataFound() {
    return Center(
      child: Container(
        width: (MediaQuery.of(context).size.width),
        height: (MediaQuery.of(context).size.height / 2),
        child: Column(
          children: <Widget>[
            Image.asset("assets/images/no_notification.png"),
            SizedBox(),
            Text('You have no new notifications',
                style: TextStyle(fontSize: 19.0))
          ],
        ),
      ),
    );
  }
}

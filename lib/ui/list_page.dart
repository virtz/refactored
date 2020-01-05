import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/notifiers/user_notifier.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usernotifier = Provider.of<UserNotifier>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:8.0),
        child: Container(
          child: FutureBuilder(
              future: usernotifier.getVisitorInfo(),
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: usernotifier.visitors.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: GestureDetector(
                        onDoubleTap: () {
                          // _alertDialogue1(
                          //     context,
                          //     "${visitors[index].name} requested to see you on ${visitors[index].timeIn} ",
                          //     'Visit Requests');
                        },
                        child: Consumer<UserNotifier>(
                          builder: (context, usernotifier, child) => Card(
                            shape: RoundedRectangleBorder(
                            
                                borderRadius: BorderRadius.circular(5.0)
                                ),
                            elevation: 1.5,
                            child: ListTile(
                                onTap: () {},
                                leading: Text(usernotifier.visitors[index].name,
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w700)),
                                trailing: Text(
                                  usernotifier.visitors[index].timeIn,
                                  style: TextStyle(
                                      fontSize: 11.0,
                                      fontStyle: FontStyle.italic),
                                )),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}

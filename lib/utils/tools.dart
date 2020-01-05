import 'package:flutter/material.dart';
import 'package:provider_demo/utils/progress_dialog.dart';


displayProgressDialog(BuildContext context) {
  Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return ProgressDialog();
      }));
}

closeProgressDialog(BuildContext context) {
  Navigator.of(context).pop();
}

showSnackBar({BuildContext context, final key, String message}) {
  message == null ? message == " " : message;
  key.currentState.showSnackBar(new SnackBar(
    backgroundColor: Colors.yellow,
    content: Text(message, style: TextStyle(color: Colors.black)),
  ));
}


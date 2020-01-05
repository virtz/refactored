import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String purpose;
  final String who;
  final String timeIn;

  const Detail(
      {Key key,
      this.id,
      this.name,
      this.address,
      this.phone,
      this.purpose,
      this.who,
      this.timeIn})
      : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

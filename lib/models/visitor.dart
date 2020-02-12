import 'package:json_annotation/json_annotation.dart';
part 'visitor.g.dart';


@JsonSerializable()
class Visitor {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String purpose;
  final String appoinmentTime;
  final String who;
  final String timeIn;
  final String status;

  Visitor(
      {this.id, this.name, this.address, this.phone, this.purpose, this.appoinmentTime,this.who, this.timeIn,this.status});

   factory Visitor.fromJson(Map<String,dynamic>json) =>_$VisitorFromJson(json);
   Map<String,dynamic> toJson() =>_$VisitorToJson(this);
}
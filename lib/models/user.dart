

import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';


@JsonSerializable()
class User {
   final String status;
  final String id;
  final String name;
  final String email;
  final String isAdmin;
 
 

User({this.id,this.name,this.email,this.isAdmin,this.status});

   factory User.fromJson(Map<String,dynamic>json) =>_$UserFromJson(json);
   Map<String,dynamic> toJson() =>_$UserToJson(this);
}
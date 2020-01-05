// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Visitor _$VisitorFromJson(Map<String, dynamic> json) {
  return Visitor(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
      purpose: json['purpose'] as String,
      who: json['who'] as String,
      timeIn: json['timeIn'] as String,
      status: json['status'] as String);
}

Map<String, dynamic> _$VisitorToJson(Visitor instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'phone': instance.phone,
      'purpose': instance.purpose,
      'who': instance.who,
      'timeIn': instance.timeIn,
      'status': instance.status
    };

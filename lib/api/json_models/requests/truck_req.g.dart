// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'truck_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TruckRequest _$TruckRequestFromJson(Map<String, dynamic> json) {
  return TruckRequest(
    noIdentity: json['no_identity'] as String,
    noPol: json['no_pol'] as String,
    mark: json['mark'] as String,
    owner: json['owner'] as String,
    hp: json['hp'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$TruckRequestToJson(TruckRequest instance) =>
    <String, dynamic>{
      'no_identity': instance.noIdentity,
      'no_pol': instance.noPol,
      'mark': instance.mark,
      'owner': instance.owner,
      'hp': instance.hp,
      'email': instance.email,
    };

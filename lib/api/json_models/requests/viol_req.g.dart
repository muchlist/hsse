// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'viol_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ViolRequest _$ViolRequestFromJson(Map<String, dynamic> json) {
  return ViolRequest(
    noIdentity: json['no_identity'] as String,
    state: json['state'] as int,
    typeViolation: json['type_violation'] as String,
    detailViolation: json['detail_violation'] as String,
    timeViolation: json['time_violation'] as int,
    location: json['location'] as String,
  );
}

Map<String, dynamic> _$ViolRequestToJson(ViolRequest instance) =>
    <String, dynamic>{
      'no_identity': instance.noIdentity,
      'state': instance.state,
      'type_violation': instance.typeViolation,
      'detail_violation': instance.detailViolation,
      'time_violation': instance.timeViolation,
      'location': instance.location,
    };

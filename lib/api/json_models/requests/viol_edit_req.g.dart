// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'viol_edit_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ViolEditRequest _$ViolEditRequestFromJson(Map<String, dynamic> json) {
  return ViolEditRequest(
    filterTimestamp: json['filter_timestamp'] as int,
    noIdentity: json['no_identity'] as String,
    typeViolation: json['type_violation'] as String,
    detailViolation: json['detail_violation'] as String,
    timeViolation: json['time_violation'] as int,
    location: json['location'] as String,
  );
}

Map<String, dynamic> _$ViolEditRequestToJson(ViolEditRequest instance) =>
    <String, dynamic>{
      'filter_timestamp': instance.filterTimestamp,
      'no_identity': instance.noIdentity,
      'type_violation': instance.typeViolation,
      'detail_violation': instance.detailViolation,
      'time_violation': instance.timeViolation,
      'location': instance.location,
    };

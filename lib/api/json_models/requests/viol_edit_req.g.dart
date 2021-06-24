// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'viol_edit_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ViolEditRequest _$ViolEditRequestFromJson(Map<String, dynamic> json) {
  return ViolEditRequest(
    filterTimestamp: json['filter_timestamp'] as int,
    noIdentity: json['no_identity'] as String,
    typeViolEditation: json['type_viol_editation'] as String,
    detailViolEditation: json['detail_viol_editation'] as String,
    timeViolEditation: json['time_viol_editation'] as int,
    location: json['location'] as String,
  );
}

Map<String, dynamic> _$ViolEditRequestToJson(ViolEditRequest instance) =>
    <String, dynamic>{
      'filter_timestamp': instance.filterTimestamp,
      'no_identity': instance.noIdentity,
      'type_viol_editation': instance.typeViolEditation,
      'detail_viol_editation': instance.detailViolEditation,
      'time_viol_editation': instance.timeViolEditation,
      'location': instance.location,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'truck_edit_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TruckEditRequest _$TruckEditRequestFromJson(Map<String, dynamic> json) {
  return TruckEditRequest(
    filterTimestamp: json['filter_timestamp'] as int,
    noIdentity: json['no_identity'] as String,
    noPol: json['no_pol'] as String,
    mark: json['mark'] as String,
    owner: json['owner'] as String,
    hp: json['hp'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$TruckEditRequestToJson(TruckEditRequest instance) =>
    <String, dynamic>{
      'filter_timestamp': instance.filterTimestamp,
      'no_identity': instance.noIdentity,
      'no_pol': instance.noPol,
      'mark': instance.mark,
      'owner': instance.owner,
      'hp': instance.hp,
      'email': instance.email,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'truck_list_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TruckListResponse _$TruckListResponseFromJson(Map<String, dynamic> json) {
  return TruckListResponse(
    json['error'] == null
        ? null
        : ErrorResp.fromJson(json['error'] as Map<String, dynamic>),
    (json['data'] as List<dynamic>?)
            ?.map((e) => TruckMinData.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$TruckListResponseToJson(TruckListResponse instance) =>
    <String, dynamic>{
      'error': instance.error?.toJson(),
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

TruckMinData _$TruckMinDataFromJson(Map<String, dynamic> json) {
  return TruckMinData(
    json['id'] as String,
    json['branch'] as String,
    json['no_identity'] as String,
    json['no_pol'] as String,
    json['mark'] as String,
    json['owner'] as String,
    json['hp'] as String,
    json['email'] as String,
    json['deleted'] as bool,
    json['score'] as int,
    json['reset_score_date'] as int,
    json['blocked'] as bool,
    json['block_start'] as int,
    json['block_end'] as int,
  );
}

Map<String, dynamic> _$TruckMinDataToJson(TruckMinData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branch': instance.branch,
      'no_identity': instance.noIdentity,
      'no_pol': instance.noPol,
      'mark': instance.mark,
      'owner': instance.owner,
      'hp': instance.hp,
      'email': instance.email,
      'deleted': instance.deleted,
      'score': instance.score,
      'reset_score_date': instance.resetScoreDate,
      'blocked': instance.blocked,
      'block_start': instance.blockStart,
      'block_end': instance.blockEnd,
    };

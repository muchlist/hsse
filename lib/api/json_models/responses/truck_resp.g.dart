// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'truck_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TruckDetailResponse _$TruckDetailResponseFromJson(Map<String, dynamic> json) {
  return TruckDetailResponse(
    json['error'] == null
        ? null
        : ErrorResp.fromJson(json['error'] as Map<String, dynamic>),
    json['data'] == null
        ? null
        : TruckData.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TruckDetailResponseToJson(
        TruckDetailResponse instance) =>
    <String, dynamic>{
      'error': instance.error?.toJson(),
      'data': instance.data?.toJson(),
    };

TruckData _$TruckDataFromJson(Map<String, dynamic> json) {
  return TruckData(
    json['id'] as String,
    json['created_at'] as int,
    json['created_by'] as String,
    json['created_by_id'] as String,
    json['updated_at'] as int,
    json['updated_by'] as String,
    json['updated_by_id'] as String,
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

Map<String, dynamic> _$TruckDataToJson(TruckData instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'created_by': instance.createdBy,
      'created_by_id': instance.createdById,
      'updated_at': instance.updatedAt,
      'updated_by': instance.updatedBy,
      'updated_by_id': instance.updatedById,
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

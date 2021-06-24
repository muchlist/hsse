// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rules_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RulesDetailResponse _$RulesDetailResponseFromJson(Map<String, dynamic> json) {
  return RulesDetailResponse(
    json['error'] == null
        ? null
        : ErrorResp.fromJson(json['error'] as Map<String, dynamic>),
    json['data'] == null
        ? null
        : RulesData.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RulesDetailResponseToJson(
        RulesDetailResponse instance) =>
    <String, dynamic>{
      'error': instance.error?.toJson(),
      'data': instance.data?.toJson(),
    };

RulesData _$RulesDataFromJson(Map<String, dynamic> json) {
  return RulesData(
    json['id'] as String,
    json['updated_at'] as int,
    json['updated_by'] as String,
    json['updated_by_id'] as String,
    json['branch'] as String,
    json['score'] as int,
    json['block_time'] as int,
    json['description'] as String,
  );
}

Map<String, dynamic> _$RulesDataToJson(RulesData instance) => <String, dynamic>{
      'id': instance.id,
      'updated_at': instance.updatedAt,
      'updated_by': instance.updatedBy,
      'updated_by_id': instance.updatedById,
      'branch': instance.branch,
      'score': instance.score,
      'block_time': instance.blockTime,
      'description': instance.description,
    };

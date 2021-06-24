// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rules_list_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RulesListResponse _$RulesListResponseFromJson(Map<String, dynamic> json) {
  return RulesListResponse(
    json['error'] == null
        ? null
        : ErrorResp.fromJson(json['error'] as Map<String, dynamic>),
    (json['data'] as List<dynamic>?)
            ?.map((e) => RulesMinData.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$RulesListResponseToJson(RulesListResponse instance) =>
    <String, dynamic>{
      'error': instance.error?.toJson(),
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

RulesMinData _$RulesMinDataFromJson(Map<String, dynamic> json) {
  return RulesMinData(
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

Map<String, dynamic> _$RulesMinDataToJson(RulesMinData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'updated_at': instance.updatedAt,
      'updated_by': instance.updatedBy,
      'updated_by_id': instance.updatedById,
      'branch': instance.branch,
      'score': instance.score,
      'block_time': instance.blockTime,
      'description': instance.description,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rules_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RulesRequest _$RulesRequestFromJson(Map<String, dynamic> json) {
  return RulesRequest(
    score: json['score'] as int,
    blockTime: json['block_time'] as int,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$RulesRequestToJson(RulesRequest instance) =>
    <String, dynamic>{
      'score': instance.score,
      'block_time': instance.blockTime,
      'description': instance.description,
    };

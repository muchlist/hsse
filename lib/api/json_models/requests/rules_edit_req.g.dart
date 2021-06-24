// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rules_edit_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RulesEditRequest _$RulesEditRequestFromJson(Map<String, dynamic> json) {
  return RulesEditRequest(
    filterTimestamp: json['filter_timestamp'] as int,
    score: json['score'] as int,
    blockTime: json['block_time'] as int,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$RulesEditRequestToJson(RulesEditRequest instance) =>
    <String, dynamic>{
      'filter_timestamp': instance.filterTimestamp,
      'score': instance.score,
      'block_time': instance.blockTime,
      'description': instance.description,
    };

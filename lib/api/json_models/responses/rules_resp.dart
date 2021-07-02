import 'package:json_annotation/json_annotation.dart';

import 'error_resp.dart';

part 'rules_resp.g.dart';

@JsonSerializable(explicitToJson: true)
class RulesDetailResponse {
  RulesDetailResponse(this.error, this.data);

  factory RulesDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$RulesDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RulesDetailResponseToJson(this);
  final ErrorResp? error;
  final RulesData? data;
}

@JsonSerializable(explicitToJson: true)
class RulesData {
  RulesData(this.id, this.updatedAt, this.updatedBy, this.updatedById,
      this.branch, this.score, this.blockTime, this.description);

  factory RulesData.fromJson(Map<String, dynamic> json) =>
      _$RulesDataFromJson(json);

  Map<String, dynamic> toJson() => _$RulesDataToJson(this);

  final String id;
  @JsonKey(name: "updated_at")
  final int updatedAt;
  @JsonKey(name: "updated_by")
  final String updatedBy;
  @JsonKey(name: "updated_by_id")
  final String updatedById;
  final String branch;
  final int score;
  @JsonKey(name: "block_time")
  final int blockTime;
  final String description;
}

import 'package:json_annotation/json_annotation.dart';

import 'error_resp.dart';

part 'rules_list_resp.g.dart';

@JsonSerializable(explicitToJson: true)
class RulesListResponse {
  final ErrorResp? error;
  @JsonKey(defaultValue: [])
  final List<RulesMinData> data;

  RulesListResponse(this.error, this.data);

  factory RulesListResponse.fromJson(Map<String, dynamic> json) =>
      _$RulesListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RulesListResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RulesMinData {
  RulesMinData(this.id, this.updatedAt, this.updatedBy, this.updatedById,
      this.branch, this.score, this.blockTime, this.description);

  factory RulesMinData.fromJson(Map<String, dynamic> json) =>
      _$RulesMinDataFromJson(json);

  Map<String, dynamic> toJson() => _$RulesMinDataToJson(this);

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

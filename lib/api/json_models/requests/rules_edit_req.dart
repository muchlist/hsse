import 'package:json_annotation/json_annotation.dart';

part 'rules_edit_req.g.dart';

@JsonSerializable()
class RulesEditRequest {
  RulesEditRequest(
      {required this.filterTimestamp,
      required this.score,
      required this.blockTime,
      required this.description});

  @JsonKey(name: "filter_timestamp")
  final int filterTimestamp;
  final int score;
  @JsonKey(name: "block_time")
  final int blockTime;
  final String description;

  factory RulesEditRequest.fromJson(Map<String, dynamic> json) =>
      _$RulesEditRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RulesEditRequestToJson(this);
}

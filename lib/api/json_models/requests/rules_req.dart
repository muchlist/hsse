import 'package:json_annotation/json_annotation.dart';

part 'rules_req.g.dart';

@JsonSerializable()
class RulesRequest {
  RulesRequest(
      {required this.score,
      required this.blockTime,
      required this.description});

  final int score;
  @JsonKey(name: "block_time")
  final int blockTime;
  final String description;

  factory RulesRequest.fromJson(Map<String, dynamic> json) =>
      _$RulesRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RulesRequestToJson(this);
}

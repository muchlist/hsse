import 'package:json_annotation/json_annotation.dart';

part 'viol_req.g.dart';

@JsonSerializable()
class ViolRequest {
  ViolRequest({
    required this.noIdentity,
    required this.state,
    required this.typeViolation,
    required this.detailViolation,
    required this.timeViolation,
    required this.location,
  });

  factory ViolRequest.fromJson(Map<String, dynamic> json) =>
      _$ViolRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ViolRequestToJson(this);

  @JsonKey(name: "no_identity")
  final String noIdentity;
  final int state;
  @JsonKey(name: "type_violation")
  final String typeViolation;
  @JsonKey(name: "detail_violation")
  final String detailViolation;
  @JsonKey(name: "time_violation")
  final int timeViolation;
  final String location;
}

import 'package:json_annotation/json_annotation.dart';

part 'viol_edit_req.g.dart';

@JsonSerializable()
class ViolEditRequest {
  ViolEditRequest({
    required this.filterTimestamp,
    required this.noIdentity,
    required this.typeViolation,
    required this.detailViolation,
    required this.timeViolation,
    required this.location,
  });

  factory ViolEditRequest.fromJson(Map<String, dynamic> json) =>
      _$ViolEditRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ViolEditRequestToJson(this);

  @JsonKey(name: "filter_timestamp")
  final int filterTimestamp;
  @JsonKey(name: "no_identity")
  final String noIdentity;
  @JsonKey(name: "type_violation")
  final String typeViolation;
  @JsonKey(name: "detail_violation")
  final String detailViolation;
  @JsonKey(name: "time_violation")
  final int timeViolation;
  final String location;
}

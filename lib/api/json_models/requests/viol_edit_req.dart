import 'package:json_annotation/json_annotation.dart';

part 'viol_edit_req.g.dart';

@JsonSerializable()
class ViolEditRequest {
  ViolEditRequest({
    required this.filterTimestamp,
    required this.noIdentity,
    required this.typeViolEditation,
    required this.detailViolEditation,
    required this.timeViolEditation,
    required this.location,
  });

  @JsonKey(name: "filter_timestamp")
  final int filterTimestamp;
  @JsonKey(name: "no_identity")
  final String noIdentity;
  @JsonKey(name: "type_viol_editation")
  final String typeViolEditation;
  @JsonKey(name: "detail_viol_editation")
  final String detailViolEditation;
  @JsonKey(name: "time_viol_editation")
  final int timeViolEditation;
  final String location;

  factory ViolEditRequest.fromJson(Map<String, dynamic> json) =>
      _$ViolEditRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ViolEditRequestToJson(this);
}

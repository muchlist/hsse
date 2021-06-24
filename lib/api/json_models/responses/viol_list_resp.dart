import 'package:json_annotation/json_annotation.dart';

import 'error_resp.dart';

part 'viol_list_resp.g.dart';

@JsonSerializable(explicitToJson: true)
class ViolListResponse {
  final ErrorResp? error;
  @JsonKey(defaultValue: [])
  final List<ViolMinData> data;

  ViolListResponse(this.error, this.data);

  factory ViolListResponse.fromJson(Map<String, dynamic> json) =>
      _$ViolListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ViolListResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ViolMinData {
  ViolMinData(
      this.id,
      this.createdAt,
      this.createdBy,
      this.approvedAt,
      this.approvedBy,
      this.branch,
      this.state,
      this.noIdentity,
      this.noPol,
      this.mark,
      this.owner,
      this.typeViolation,
      this.detailViolation,
      this.timeViolation,
      this.location,
      this.images);

  final String id;
  @JsonKey(name: "created_at")
  final int createdAt;
  @JsonKey(name: "created_by")
  final String createdBy;
  @JsonKey(name: "approved_at")
  final int approvedAt;
  @JsonKey(name: "approved_by")
  final String approvedBy;
  final String branch;
  final int state;
  @JsonKey(name: "no_identity")
  final String noIdentity;
  @JsonKey(name: "no_pol")
  final String noPol;
  final String mark;
  final String owner;
  @JsonKey(name: "type_violation")
  final String typeViolation;
  @JsonKey(name: "detail_violation")
  final String detailViolation;
  @JsonKey(name: "time_violation")
  final int timeViolation;
  final String location;
  @JsonKey(defaultValue: [])
  final List<String> images;

  factory ViolMinData.fromJson(Map<String, dynamic> json) =>
      _$ViolMinDataFromJson(json);

  Map<String, dynamic> toJson() => _$ViolMinDataToJson(this);
}

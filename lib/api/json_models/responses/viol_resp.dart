import 'package:json_annotation/json_annotation.dart';

import 'error_resp.dart';

part 'viol_resp.g.dart';

@JsonSerializable(explicitToJson: true)
class ViolDetailResponse {
  final ErrorResp? error;
  final ViolData? data;

  ViolDetailResponse(this.error, this.data);

  factory ViolDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$ViolDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ViolDetailResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ViolData {
  ViolData(
      this.id,
      this.createdAt,
      this.createdBy,
      this.createdById,
      this.updatedAt,
      this.updatedBy,
      this.updatedById,
      this.approvedAt,
      this.approvedBy,
      this.approvedById,
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
  @JsonKey(name: "created_by_id")
  final String createdById;
  @JsonKey(name: "updated_at")
  final int updatedAt;
  @JsonKey(name: "updated_by")
  final String updatedBy;
  @JsonKey(name: "updated_by_id")
  final String updatedById;
  @JsonKey(name: "approved_at")
  final int approvedAt;
  @JsonKey(name: "approved_by")
  final String approvedBy;
  @JsonKey(name: "approved_by_id")
  final String approvedById;
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

  factory ViolData.fromJson(Map<String, dynamic> json) =>
      _$ViolDataFromJson(json);

  Map<String, dynamic> toJson() => _$ViolDataToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

import 'error_resp.dart';

part 'truck_resp.g.dart';

@JsonSerializable(explicitToJson: true)
class TruckDetailResponse {
  final ErrorResp? error;
  final TruckData? data;

  TruckDetailResponse(this.error, this.data);

  factory TruckDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$TruckDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TruckDetailResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TruckData {
  TruckData(
      this.id,
      this.createdAt,
      this.createdBy,
      this.createdById,
      this.updatedAt,
      this.updatedBy,
      this.updatedById,
      this.branch,
      this.noIdentity,
      this.noPol,
      this.mark,
      this.owner,
      this.hp,
      this.email,
      this.deleted,
      this.score,
      this.resetScoreDate,
      this.blocked,
      this.blockStart,
      this.blockEnd);

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
  final String branch;
  @JsonKey(name: "no_identity")
  final String noIdentity;
  @JsonKey(name: "no_pol")
  final String noPol;
  final String mark;
  final String owner;
  final String hp;
  final String email;
  final bool deleted;
  final int score;
  @JsonKey(name: "reset_score_date")
  final int resetScoreDate;
  final bool blocked;
  @JsonKey(name: "block_start")
  final int blockStart;
  @JsonKey(name: "block_end")
  final int blockEnd;

  factory TruckData.fromJson(Map<String, dynamic> json) =>
      _$TruckDataFromJson(json);

  Map<String, dynamic> toJson() => _$TruckDataToJson(this);
}

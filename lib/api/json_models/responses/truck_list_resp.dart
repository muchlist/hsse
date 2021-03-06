import 'package:json_annotation/json_annotation.dart';

import 'error_resp.dart';

part 'truck_list_resp.g.dart';

@JsonSerializable(explicitToJson: true)
class TruckListResponse {
  TruckListResponse(this.error, this.data);

  factory TruckListResponse.fromJson(Map<String, dynamic> json) =>
      _$TruckListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TruckListResponseToJson(this);

  final ErrorResp? error;
  @JsonKey(defaultValue: <TruckMinData>[])
  final List<TruckMinData> data;
}

@JsonSerializable(explicitToJson: true)
class TruckMinData {
  TruckMinData(
    this.id,
    this.branch,
    this.noIdentity,
    this.noPol,
    this.mark,
    this.owner,
    this.hp,
    this.email,
    // ignore: avoid_positional_boolean_parameters
    this.deleted,
    this.score,
    this.resetScoreDate,
    this.blocked,
    this.blockStart,
    this.blockEnd,
  );

  factory TruckMinData.fromJson(Map<String, dynamic> json) =>
      _$TruckMinDataFromJson(json);

  Map<String, dynamic> toJson() => _$TruckMinDataToJson(this);

  final String id;
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
}

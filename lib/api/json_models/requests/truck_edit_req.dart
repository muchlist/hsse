import 'package:json_annotation/json_annotation.dart';

part 'truck_edit_req.g.dart';

@JsonSerializable()
class TruckEditRequest {
  TruckEditRequest({
    required this.filterTimestamp,
    required this.noIdentity,
    required this.noPol,
    required this.mark,
    required this.owner,
    required this.hp,
    required this.email,
  });

  @JsonKey(name: "filter_timestamp")
  final int filterTimestamp;
  @JsonKey(name: "no_identity")
  final String noIdentity;
  @JsonKey(name: "no_pol")
  final String noPol;
  final String mark;
  final String owner;
  final String hp;
  final String email;

  factory TruckEditRequest.fromJson(Map<String, dynamic> json) =>
      _$TruckEditRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TruckEditRequestToJson(this);
}

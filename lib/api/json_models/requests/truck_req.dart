import 'package:json_annotation/json_annotation.dart';

part 'truck_req.g.dart';

@JsonSerializable()
class TruckRequest {
  TruckRequest({
    required this.noIdentity,
    required this.noPol,
    required this.mark,
    required this.owner,
    required this.hp,
    required this.email,
  });

  @JsonKey(name: "no_identity")
  final String noIdentity;
  @JsonKey(name: "no_pol")
  final String noPol;
  final String mark;
  final String owner;
  final String hp;
  final String email;

  factory TruckRequest.fromJson(Map<String, dynamic> json) =>
      _$TruckRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TruckRequestToJson(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'viol_list_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ViolListResponse _$ViolListResponseFromJson(Map<String, dynamic> json) {
  return ViolListResponse(
    json['error'] == null
        ? null
        : ErrorResp.fromJson(json['error'] as Map<String, dynamic>),
    (json['data'] as List<dynamic>?)
            ?.map((e) => ViolMinData.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$ViolListResponseToJson(ViolListResponse instance) =>
    <String, dynamic>{
      'error': instance.error?.toJson(),
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

ViolMinData _$ViolMinDataFromJson(Map<String, dynamic> json) {
  return ViolMinData(
    json['id'] as String,
    json['created_at'] as int,
    json['created_by'] as String,
    json['approved_at'] as int,
    json['approved_by'] as String,
    json['branch'] as String,
    json['state'] as int,
    json['n_viol'] as int? ?? 0,
    json['no_identity'] as String,
    json['no_pol'] as String,
    json['owner'] as String,
    json['type_violation'] as String,
    json['detail_violation'] as String,
    json['time_violation'] as int,
    json['location'] as String,
    (json['images'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
  );
}

Map<String, dynamic> _$ViolMinDataToJson(ViolMinData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'created_by': instance.createdBy,
      'approved_at': instance.approvedAt,
      'approved_by': instance.approvedBy,
      'branch': instance.branch,
      'state': instance.state,
      'n_viol': instance.nViol,
      'no_identity': instance.noIdentity,
      'no_pol': instance.noPol,
      'owner': instance.owner,
      'type_violation': instance.typeViolation,
      'detail_violation': instance.detailViolation,
      'time_violation': instance.timeViolation,
      'location': instance.location,
      'images': instance.images,
    };

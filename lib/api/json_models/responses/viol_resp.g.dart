// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'viol_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ViolDetailResponse _$ViolDetailResponseFromJson(Map<String, dynamic> json) {
  return ViolDetailResponse(
    json['error'] == null
        ? null
        : ErrorResp.fromJson(json['error'] as Map<String, dynamic>),
    json['data'] == null
        ? null
        : ViolData.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ViolDetailResponseToJson(ViolDetailResponse instance) =>
    <String, dynamic>{
      'error': instance.error?.toJson(),
      'data': instance.data?.toJson(),
    };

ViolData _$ViolDataFromJson(Map<String, dynamic> json) {
  return ViolData(
    json['id'] as String,
    json['created_at'] as int,
    json['created_by'] as String,
    json['created_by_id'] as String,
    json['updated_at'] as int,
    json['updated_by'] as String,
    json['updated_by_id'] as String,
    json['approved_at'] as int,
    json['approved_by'] as String,
    json['approved_by_id'] as String,
    json['branch'] as String,
    json['state'] as int,
    json['n_viol'] as int? ?? 0,
    json['no_identity'] as String,
    json['no_pol'] as String,
    json['mark'] as String,
    json['owner'] as String,
    json['type_violation'] as String,
    json['detail_violation'] as String,
    json['time_violation'] as int,
    json['location'] as String,
    (json['images'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
  );
}

Map<String, dynamic> _$ViolDataToJson(ViolData instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'created_by': instance.createdBy,
      'created_by_id': instance.createdById,
      'updated_at': instance.updatedAt,
      'updated_by': instance.updatedBy,
      'updated_by_id': instance.updatedById,
      'approved_at': instance.approvedAt,
      'approved_by': instance.approvedBy,
      'approved_by_id': instance.approvedById,
      'branch': instance.branch,
      'state': instance.state,
      'n_viol': instance.nViol,
      'no_identity': instance.noIdentity,
      'no_pol': instance.noPol,
      'mark': instance.mark,
      'owner': instance.owner,
      'type_violation': instance.typeViolation,
      'detail_violation': instance.detailViolation,
      'time_violation': instance.timeViolation,
      'location': instance.location,
      'images': instance.images,
    };

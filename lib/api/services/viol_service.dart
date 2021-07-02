import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hsse/api/filter_models/viol_filter.dart';
import 'package:hsse/api/json_models/requests/viol_edit_req.dart';
import 'package:hsse/api/json_models/requests/viol_req.dart';
import 'package:hsse/api/json_models/responses/message_resp.dart';
import 'package:hsse/api/json_models/responses/viol_list_resp.dart';
import 'package:hsse/api/json_models/responses/viol_resp.dart';

import '../http_client.dart';
import '../json_parsers/json_parsers.dart';

class ViolService {
  const ViolService();

  Future<MessageResponse> createViol(ViolRequest payload) {
    return RequestREST(endpoint: "/violation", data: payload.toJson())
        .executePost<MessageResponse>(const MessageParser());
  }

  Future<ViolDetailResponse> editViol(String id, ViolEditRequest payload) {
    return RequestREST(endpoint: "/violation/$id", data: payload.toJson())
        .executePut<ViolDetailResponse>(const ViolParser());
  }

  Future<ViolDetailResponse> getViol(String id) {
    return RequestREST(endpoint: "/violation/$id")
        .executeGet<ViolDetailResponse>(const ViolParser());
  }

  Future<MessageResponse> deleteViol(String id) {
    return RequestREST(endpoint: "/violation/$id")
        .executeDelete<MessageResponse>(const MessageParser());
  }

  Future<ViolListResponse> findViol(FilterViol f) {
    String query = "";

    if (f.lambung != null) {
      query = query + "lambung=${f.lambung}&";
    }
    if (f.state != null) {
      query = query + "state=${f.state}&";
    }
    if (f.limit != null) {
      query = query + "limit=${f.limit}&";
    }
    if (f.start != null) {
      query = query + "start=${f.start}&";
    }
    if (f.end != null) {
      query = query + "end=${f.end}";
    }

    return RequestREST(endpoint: "/violation?$query")
        .executeGet<ViolListResponse>(const ViolListParser());
  }

  Future<ViolDetailResponse> sendDraftViol(String id) {
    return RequestREST(endpoint: "/violation-draft/$id")
        .executeGet<ViolDetailResponse>(const ViolParser());
  }

  Future<ViolDetailResponse> sendConfirmViol(String id) {
    return RequestREST(endpoint: "/violation-confirm/$id")
        .executeGet<ViolDetailResponse>(const ViolParser());
  }

  Future<ViolDetailResponse> approveViol(String id) {
    return RequestREST(endpoint: "/violation-approve/$id")
        .executeGet<ViolDetailResponse>(const ViolParser());
  }

  Future<ViolDetailResponse> uploadImage(String id, File file) async {
    return RequestREST(
        endpoint: "/violation-upload-image/$id",
        data: <String, dynamic>{
          "image": await MultipartFile.fromFile(file.path)
        }).executeUpload(const ViolParser());
  }

  // params : imageName with extension
  Future<ViolDetailResponse> deleteImageViol(String id, String imageName) {
    return RequestREST(endpoint: "/violation-delete-image/$id/$imageName")
        .executeGet<ViolDetailResponse>(const ViolParser());
  }
}

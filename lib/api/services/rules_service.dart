import 'package:hsse/api/json_models/requests/rules_edit_req.dart';
import 'package:hsse/api/json_models/requests/rules_req.dart';
import 'package:hsse/api/json_models/responses/message_resp.dart';
import 'package:hsse/api/json_models/responses/rules_list_resp.dart';
import 'package:hsse/api/json_models/responses/rules_resp.dart';

import '../http_client.dart';
import '../json_parsers/json_parsers.dart';

class RulesService {
  const RulesService();

  Future<MessageResponse> createRules(RulesRequest payload) {
    return RequestREST(endpoint: "/rules", data: payload.toJson())
        .executePost<MessageResponse>(MessageParser());
  }

  Future<RulesDetailResponse> editRules(String id, RulesEditRequest payload) {
    return RequestREST(endpoint: "/rules/$id", data: payload.toJson())
        .executePut<RulesDetailResponse>(RulesParser());
  }

  Future<RulesDetailResponse> getRules(String id) {
    return RequestREST(endpoint: "/rules/$id")
        .executeGet<RulesDetailResponse>(RulesParser());
  }

  Future<MessageResponse> deleteRules(String id) {
    return RequestREST(endpoint: "/rules/$id")
        .executeDelete<MessageResponse>(MessageParser());
  }

  Future<RulesListResponse> findRules() {
    return RequestREST(endpoint: "/rules")
        .executeGet<RulesListResponse>(RulesListParser());
  }
}

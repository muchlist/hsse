import 'package:hsse/api/filter_models/truck_filter.dart';
import 'package:hsse/api/json_models/requests/truck_edit_req.dart';
import 'package:hsse/api/json_models/requests/truck_req.dart';
import 'package:hsse/api/json_models/responses/message_resp.dart';
import 'package:hsse/api/json_models/responses/truck_list_resp.dart';
import 'package:hsse/api/json_models/responses/truck_resp.dart';

import '../http_client.dart';
import '../json_parsers/json_parsers.dart';

class TruckService {
  const TruckService();

  Future<MessageResponse> createTruck(TruckRequest payload) {
    return RequestREST(endpoint: "/truck", data: payload.toJson())
        .executePost<MessageResponse>(MessageParser());
  }

  Future<TruckDetailResponse> editTruck(String id, TruckEditRequest payload) {
    return RequestREST(endpoint: "/truck/$id", data: payload.toJson())
        .executePut<TruckDetailResponse>(TruckParser());
  }

  Future<TruckDetailResponse> getTruck(String id) {
    return RequestREST(endpoint: "/truck/$id")
        .executeGet<TruckDetailResponse>(TruckParser());
  }

  Future<MessageResponse> deleteTruck(String id) {
    return RequestREST(endpoint: "/truck/$id")
        .executeDelete<MessageResponse>(MessageParser());
  }

  Future<TruckListResponse> findTruck(FilterTruck f) {
    var query = "";

    if (f.branch != null) {
      query = query + "branch=${f.branch}&";
    }
    if (f.identity != null) {
      query = query + "identity=${f.identity}&";
    }
    if (f.owner != null) {
      query = query + "owner=${f.owner}&";
    }
    if (f.active != null) {
      query = query + "active=${f.active}&";
    }
    if (f.block != null) {
      query = query + "block=${f.block}";
    }

    return RequestREST(endpoint: "/truck?$query")
        .executeGet<TruckListResponse>(TruckListParser());
  }
}

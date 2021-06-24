import 'package:hsse/api/json_models/responses/error_resp.dart';
import 'package:hsse/api/json_models/responses/truck_list_resp.dart';
import 'package:hsse/api/json_models/responses/truck_resp.dart';

import 'json_parsers.dart';
import 'object_decoder.dart';

class TruckParser extends JsonParser<TruckDetailResponse>
    with ObjectDecoder<TruckDetailResponse> {
  const TruckParser();

  @override
  Future<TruckDetailResponse> parseFromJson(String json) async {
    try {
      final decoded = decodeJsonObject(json);
      return TruckDetailResponse.fromJson(decoded);
    } catch (e) {
      return TruckDetailResponse(ErrorResp(0, e.toString(), "", []), null);
    }
  }
}

class TruckListParser extends JsonParser<TruckListResponse>
    with ObjectDecoder<TruckListResponse> {
  const TruckListParser();

  @override
  Future<TruckListResponse> parseFromJson(String json) async {
    try {
      final decoded = decodeJsonObject(json);
      return TruckListResponse.fromJson(decoded);
    } catch (e) {
      return TruckListResponse(ErrorResp(0, e.toString(), "", []), []);
    }
  }
}

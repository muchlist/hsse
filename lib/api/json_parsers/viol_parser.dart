import 'package:hsse/api/json_models/responses/error_resp.dart';
import 'package:hsse/api/json_models/responses/viol_list_resp.dart';
import 'package:hsse/api/json_models/responses/viol_resp.dart';

import 'json_parsers.dart';
import 'object_decoder.dart';

class ViolParser extends JsonParser<ViolDetailResponse>
    with ObjectDecoder<ViolDetailResponse> {
  const ViolParser();

  @override
  Future<ViolDetailResponse> parseFromJson(String json) async {
    try {
      final decoded = decodeJsonObject(json);
      return ViolDetailResponse.fromJson(decoded);
    } catch (e) {
      return ViolDetailResponse(ErrorResp(0, e.toString(), "", []), null);
    }
  }
}

class ViolListParser extends JsonParser<ViolListResponse>
    with ObjectDecoder<ViolListResponse> {
  const ViolListParser();

  @override
  Future<ViolListResponse> parseFromJson(String json) async {
    try {
      final decoded = decodeJsonObject(json);
      return ViolListResponse.fromJson(decoded);
    } catch (e) {
      return ViolListResponse(ErrorResp(0, e.toString(), "", []), []);
    }
  }
}

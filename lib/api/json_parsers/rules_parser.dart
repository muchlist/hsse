import 'package:hsse/api/json_models/responses/error_resp.dart';
import 'package:hsse/api/json_models/responses/rules_list_resp.dart';
import 'package:hsse/api/json_models/responses/rules_resp.dart';

import 'json_parsers.dart';
import 'object_decoder.dart';

class RulesParser extends JsonParser<RulesDetailResponse>
    with ObjectDecoder<RulesDetailResponse> {
  const RulesParser();

  @override
  Future<RulesDetailResponse> parseFromJson(String json) async {
    try {
      final decoded = decodeJsonObject(json);
      return RulesDetailResponse.fromJson(decoded);
    } catch (e) {
      return RulesDetailResponse(ErrorResp(0, e.toString(), "", []), null);
    }
  }
}

class RulesListParser extends JsonParser<RulesListResponse>
    with ObjectDecoder<RulesListResponse> {
  const RulesListParser();

  @override
  Future<RulesListResponse> parseFromJson(String json) async {
    try {
      final decoded = decodeJsonObject(json);
      return RulesListResponse.fromJson(decoded);
    } catch (e) {
      return RulesListResponse(ErrorResp(0, e.toString(), "", []), []);
    }
  }
}

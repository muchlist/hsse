import 'package:hsse/api/json_models/responses/error_resp.dart';
import 'package:hsse/api/json_models/responses/login_resp.dart';

import 'json_parsers.dart';
import 'object_decoder.dart';

class LoginParser extends JsonParser<LoginResponse>
    with ObjectDecoder<LoginResponse> {
  const LoginParser();

  @override
  Future<LoginResponse> parseFromJson(String json) async {
    try {
      final decoded = decodeJsonObject(json);
      return LoginResponse.fromJson(decoded);
    } catch (e) {
      return LoginResponse(ErrorResp(0, e.toString(), "", []), null);
    }
  }
}

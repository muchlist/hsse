import 'package:hsse/api/json_models/responses/error_resp.dart';
import 'package:hsse/api/json_models/responses/message_resp.dart';

import 'json_parsers.dart';
import 'object_decoder.dart';

class MessageParser extends JsonParser<MessageResponse>
    with ObjectDecoder<MessageResponse> {
  const MessageParser();

  @override
  Future<MessageResponse> parseFromJson(String json) async {
    try {
      final Map<String, dynamic> decoded = decodeJsonObject(json);
      return MessageResponse.fromJson(decoded);
    } catch (e) {
      return MessageResponse(ErrorResp(0, e.toString(), "", <String>[]), null);
    }
  }
}

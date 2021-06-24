library json_parser;

export 'login_parser.dart';
export 'message_parser.dart';
export 'rules_parser.dart';
export 'truck_parser.dart';
export 'viol_parser.dart';

abstract class JsonParser<T> {
  const JsonParser();

  Future<T> parseFromJson(String json);
}

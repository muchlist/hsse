import 'package:dio/dio.dart';
import 'package:hsse/config/config.dart';
import 'package:hsse/singleton/shared_pref.dart';

import 'json_parsers/json_parsers.dart';

class RequestREST {
  RequestREST({required this.endpoint, this.data = const <String, dynamic>{}});

  final String endpoint;
  final Map<String, dynamic> data;

  static final Dio _client = Dio(BaseOptions(
    baseUrl: ConstUrl.baseApiUrl,
    connectTimeout: 10000, // 10 second
    receiveTimeout: 10000,
    sendTimeout: 10000,
    headers: <String, String>{
      "Authorization": "Bearer ${SharedPrefs().getToken() ?? ""}",
      "Accept": "*/*",
      "Content-Type": "application/json"
    },
    followRedirects: false,
    validateStatus: (int? status) {
      return status! < 501;
    },
  ));

  // GET <<<<<<<<<<<
  Future<T> executeGet<T>(JsonParser<T> parser) async {
    try {
      final Response<String> response = await _client.get<String>(
        endpoint,
        options: Options(
          headers: <String, dynamic>{
            "Authorization": "Bearer ${SharedPrefs().getToken() ?? ""}",
          },
        ),
      );
      return parser.parseFromJson(response.data ?? "");
    } on DioError catch (e) {
      return Future<T>.error(_dioErrorHandler(e));
    } catch (e) {
      return Future<T>.error(e);
    }
  }

  // POST <<<<<<<<<<<
  Future<T> executePost<T>(JsonParser<T> parser) async {
    // final formData = FormData.fromMap(data);
    try {
      final Response<String> response = await _client.post<String>(
        endpoint,
        data: data,
        options: Options(
          headers: <String, dynamic>{
            "Authorization": "Bearer ${SharedPrefs().getToken() ?? ""}",
          },
        ),
      );
      return parser.parseFromJson(response.data ?? "");
    } on DioError catch (e) {
      return Future<T>.error(_dioErrorHandler(e));
    } catch (e) {
      return Future<T>.error(e);
    }
  }

  // PUT <<<<<<<<<<<
  Future<T> executePut<T>(JsonParser<T> parser) async {
    // final formData = FormData.fromMap(data);
    try {
      final Response<String> response = await _client.put<String>(
        endpoint,
        data: data,
        options: Options(
          headers: <String, dynamic>{
            "Authorization": "Bearer ${SharedPrefs().getToken() ?? ""}",
          },
        ),
      );
      return parser.parseFromJson(response.data ?? "");
    } on DioError catch (e) {
      return Future<T>.error(_dioErrorHandler(e));
    } catch (e) {
      return Future<T>.error(e);
    }
  }

  // DELETE <<<<<<<<<<<
  Future<T> executeDelete<T>(JsonParser<T> parser) async {
    final Response<String> response = await _client.delete<String>(
      endpoint,
      options: Options(
        headers: <String, dynamic>{
          "Authorization": "Bearer ${SharedPrefs().getToken() ?? ""}",
        },
      ),
    );
    return parser.parseFromJson(response.data ?? "");
  }

  // UPLOAD <<<<<<<<<<<
  Future<T> executeUpload<T>(JsonParser<T> parser) async {
    final FormData formData = FormData.fromMap(data);

    try {
      final Response<String> response = await _client.post<String>(
        endpoint,
        data: formData,
        options: Options(
          headers: <String, dynamic>{
            "Authorization": "Bearer ${SharedPrefs().getToken() ?? ""}",
          },
        ),
      );
      return parser.parseFromJson(response.data ?? "");
    } on DioError catch (e) {
      return Future<T>.error(_dioErrorHandler(e));
    } catch (e) {
      return Future<T>.error(e);
    }
  }

  String _dioErrorHandler(DioError e) {
    if (e.type == DioErrorType.connectTimeout ||
        e.type == DioErrorType.receiveTimeout ||
        e.type == DioErrorType.sendTimeout) {
      return "Connection timeout";
    }
    if (e.message.contains("Connection refused")) {
      return "Connection refused";
    }

    return e.message;
  }
}

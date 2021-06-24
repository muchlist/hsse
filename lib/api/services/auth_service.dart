import 'package:hsse/api/json_models/responses/login_resp.dart';

import '../http_client.dart';
import '../json_parsers/json_parsers.dart';

class AuthService {
  const AuthService();

  Future<LoginResponse> login(String id, String password) {
    return RequestREST(
            endpoint: "/login", data: {"id": id, "password": password})
        .executePost<LoginResponse>(LoginParser());
  }

  Future<LoginResponse> sendFCMToken(String token) {
    return RequestREST(endpoint: "/update-fcm", data: {"fcm_token": token})
        .executePost<LoginResponse>(LoginParser());
  }
}

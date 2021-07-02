import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  factory SharedPrefs() {
    return _singleton;
  }
  SharedPrefs._internal();
  static final SharedPrefs _singleton = SharedPrefs._internal();

  late SharedPreferences localStorage;
  Future<void> init() async {
    localStorage = await SharedPreferences.getInstance();
  }

  final String _tokenSaved = "token";
  final String _branchSaved = "branch";
  final String _rolesSaved = "roles";
  final String _nameSaved = "name";
  final String _fireTokenSaved = "firebaseToken";

  String? getToken() {
    return localStorage.getString(_tokenSaved);
  }

  // harus menggunakan await saaat melakukan set value
  Future<bool> setToken(String value) {
    return localStorage.setString(_tokenSaved, value);
  }

  String? getFireToken() {
    return localStorage.getString(_fireTokenSaved);
  }

  Future<bool> setFireToken(String value) {
    return localStorage.setString(_fireTokenSaved, value);
  }

  String? getName() {
    return localStorage.getString(_nameSaved);
  }

  Future<bool> setName(String value) {
    return localStorage.setString(_nameSaved, value);
  }

  String? getBranch() {
    return localStorage.getString(_branchSaved);
  }

  Future<bool> setBranch(String value) {
    return localStorage.setString(_branchSaved, value);
  }

  List<String> getRoles() {
    final String? rolesString = localStorage.getString(_rolesSaved);
    if (rolesString != null && rolesString.isNotEmpty) {
      return rolesString.split(",");
    }
    return <String>[];
  }

  Future<bool> setRoles(List<String> value) {
    String rolesString = "";
    if (value.isNotEmpty) {
      rolesString = value.join(",");
    }
    return localStorage.setString(_rolesSaved, rolesString);
  }
}

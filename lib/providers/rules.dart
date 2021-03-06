import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:hsse/api/json_models/requests/rules_edit_req.dart';
import 'package:hsse/api/json_models/requests/rules_req.dart';
import 'package:hsse/api/json_models/responses/message_resp.dart';
import 'package:hsse/api/json_models/responses/rules_list_resp.dart';
import 'package:hsse/api/json_models/responses/rules_resp.dart';
import 'package:hsse/api/services/rules_service.dart';
import 'package:hsse/utils/enum_state.dart';

class RulesProvider extends ChangeNotifier {
  RulesProvider(this._rulesService);
  final RulesService _rulesService;

  // =======================================================
  // List Rules

  // * state
  ViewState _state = ViewState.idle;
  ViewState get state => _state;
  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  // rules list cache
  List<RulesMinData> _rulesList = <RulesMinData>[];
  List<RulesMinData> get rulesList {
    return UnmodifiableListView<RulesMinData>(_rulesList);
  }

  // * Mendapatkan rules
  Future<void> findRules({bool loading = true}) async {
    if (loading) {
      setState(ViewState.busy);
    }

    String error = "";
    try {
      final RulesListResponse response = await _rulesService.findRules();
      if (response.error != null) {
        error = response.error!.message;
      } else {
        _rulesList = response.data;
      }
    } catch (e) {
      error = e.toString();
    }

    setState(ViewState.idle);

    if (error.isNotEmpty) {
      return Future<void>.error(error);
    }
  }

// ========================================================
  // detail rules

  // * detail state
  ViewState _detailState = ViewState.idle;
  ViewState get detailState => _detailState;
  void setDetailState(ViewState viewState) {
    _detailState = viewState;
    notifyListeners();
  }

  String rulesID = "";

  // rules detail cache
  RulesData _rulesDetail = RulesData("", 0, "", "", "", 0, 0, "");
  RulesData get rulesDetail {
    return _rulesDetail;
  }

  void removeDetail() {
    _rulesDetail = RulesData("", 0, "", "", "", 0, 0, "");
  }

  // get detail rules
  // * Mendapatkan rules
  Future<RulesData> getDetail() async {
    setDetailState(ViewState.busy);

    String error = "";
    try {
      final RulesDetailResponse response =
          await _rulesService.getRules(rulesID);
      if (response.error != null) {
        error = response.error!.message;
      } else {
        _rulesDetail = response.data!;
      }
    } catch (e) {
      error = e.toString();
    }

    setDetailState(ViewState.idle);
    if (error.isNotEmpty) {
      return Future<RulesData>.error(error);
    }

    return _rulesDetail;
  }

  // return future true jika add rules berhasil
  // memanggil findRules sehingga tidak perlu notifyListener
  Future<bool> addRules(RulesRequest payload) async {
    setState(ViewState.busy);
    String error = "";

    try {
      final MessageResponse response = await _rulesService.createRules(payload);
      if (response.error != null) {
        error = response.error!.message;
      }
    } catch (e) {
      error = e.toString();
    }

    setState(ViewState.idle);
    if (error.isNotEmpty) {
      return Future<bool>.error(error);
    }
    await findRules(loading: false);
    return true;
  }

  //

  // return future RulesDetail jika edit rules berhasil
  Future<bool> editRules(RulesEditRequest payload) async {
    setState(ViewState.busy);
    String error = "";

    try {
      final RulesDetailResponse response =
          await _rulesService.editRules(rulesID, payload);
      if (response.error != null) {
        error = response.error!.message;
      } else {
        _rulesDetail = response.data!;
      }
    } catch (e) {
      error = e.toString();
    }

    setState(ViewState.idle);
    if (error.isNotEmpty) {
      return Future<bool>.error(error);
    }

    await findRules(loading: false);
    return true;
  }

  // remove rules
  Future<bool> removeRules() async {
    String error = "";

    try {
      final MessageResponse response = await _rulesService.deleteRules(rulesID);
      if (response.error != null) {
        error = response.error!.message;
      }
    } catch (e) {
      error = e.toString();
    }

    notifyListeners();
    if (error.isNotEmpty) {
      return Future<bool>.error(error);
    }
    await findRules(loading: false);
    return true;
  }

  // * detail state
  ViewState _rulesChangeState = ViewState.idle;
  ViewState get rulesChangeState => _rulesChangeState;
  void setRulesChangeState(ViewState viewState) {
    _rulesChangeState = viewState;
    notifyListeners();
  }

  // dipanggil ketika data sudah tidak dibutuhkan lagi,
  // di on dispose
  void onClose() {
    removeDetail();
    _rulesList = <RulesMinData>[];
  }
}

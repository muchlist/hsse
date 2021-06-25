import 'dart:collection';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hsse/api/filter_models/viol_filter.dart';
import 'package:hsse/api/json_models/requests/viol_edit_req.dart';
import 'package:hsse/api/json_models/requests/viol_req.dart';
import 'package:hsse/api/json_models/responses/viol_list_resp.dart';
import 'package:hsse/api/json_models/responses/viol_resp.dart';
import 'package:hsse/api/services/viol_service.dart';
import 'package:hsse/utils/enum_state.dart';
import 'package:hsse/utils/image_compress.dart';

class ViolProvider extends ChangeNotifier {
  final ViolService _violService;
  ViolProvider(this._violService);

  // =======================================================
  // List Viol

  // * state
  ViewState _state = ViewState.idle;
  ViewState get state => _state;
  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  // viol list cache
  List<ViolMinData> _violList = [];
  List<ViolMinData> get violList {
    return UnmodifiableListView(_violList);
  }

  // *memasang filter pada pencarian viol
  FilterViol _filterViol = FilterViol(limit: 200);
  void setFilter(FilterViol filter) {
    _filterViol = filter;
  }

  // * Mendapatkan viol
  Future<void> findViol({bool loading = true}) async {
    if (loading) {
      setState(ViewState.busy);
    }

    var error = "";
    try {
      final response = await _violService.findViol(_filterViol);
      if (response.error != null) {
        error = response.error!.message;
      } else {
        _violList = response.data;
      }
    } catch (e) {
      error = e.toString();
    }

    setState(ViewState.idle);

    if (error.isNotEmpty) {
      return Future.error(error);
    }
  }

// ========================================================
  // detail viol

  // * detail state
  ViewState _detailState = ViewState.idle;
  ViewState get detailState => _detailState;
  void setDetailState(ViewState viewState) {
    _detailState = viewState;
    notifyListeners();
  }

  String _violIDSaved = "";
  void setViolID(String violID) {
    _violIDSaved = violID;
  }

  String getViolId() => _violIDSaved;

  // viol detail cache
  ViolData _violDetail = ViolData("", 0, "", "", 0, "", "", 0, "", "", "", 0,
      "", "", "", "", "", "", 0, "", []);
  ViolData get violDetail {
    return _violDetail;
  }

  void removeDetail() {
    _violDetail = ViolData("", 0, "", "", 0, "", "", 0, "", "", "", 0, "", "",
        "", "", "", "", 0, "", []);
  }

  // get detail viol
  // * Mendapatkan viol
  Future<void> getDetail() async {
    setDetailState(ViewState.busy);

    var error = "";
    try {
      final response = await _violService.getViol(_violIDSaved);
      if (response.error != null) {
        error = response.error!.message;
      } else {
        final violData = response.data!;
        _violDetail = violData;
      }
    } catch (e) {
      error = e.toString();
    }

    setDetailState(ViewState.idle);
    if (error.isNotEmpty) {
      return Future.error(error);
    }
  }

  // return future true jika add viol berhasil
  // memanggil findViol sehingga tidak perlu notifyListener
  Future<bool> addViol(ViolRequest payload) async {
    setState(ViewState.busy);
    var error = "";

    try {
      final response = await _violService.createViol(payload);
      if (response.error != null) {
        error = response.error!.message;
      }
    } catch (e) {
      error = e.toString();
    }

    setState(ViewState.idle);
    if (error.isNotEmpty) {
      return Future.error(error);
    }
    await findViol(loading: false);
    return true;
  }

  // // viol option cache
  // OptLocationType _violOption = OptLocationType(["None"], ["None"]);
  // OptLocationType get violOption {
  //   return _violOption;
  // }

  // // * Mendapatkan check option
  // Future<void> findOptionViol() async {
  //   try {
  //     final response =
  //         await _violService.getOptCreateViol(App.getBranch() ?? "");
  //     _violOption = response;
  //   } catch (e) {
  //     return Future.error(e.toString());
  //   }
  //   notifyListeners();
  // }

  // return future ViolDetail jika edit viol berhasil
  Future<bool> editViol(ViolEditRequest payload) async {
    setState(ViewState.busy);
    var error = "";

    try {
      final response = await _violService.editViol(_violIDSaved, payload);
      if (response.error != null) {
        error = response.error!.message;
      } else {
        _violDetail = response.data!;
      }
    } catch (e) {
      error = e.toString();
    }

    setState(ViewState.idle);
    if (error.isNotEmpty) {
      return Future.error(error);
    }

    await findViol(loading: false);
    return true;
  }

  // * update image
  // return future true jika update image berhasil
  Future<bool> uploadImage(String id, File file) async {
    var error = "";

    final fileCompressed = await compressFile(file);

    try {
      final response = await _violService.uploadImage(id, fileCompressed);
      if (response.error != null) {
        error = response.error!.message;
      } else {
        _violDetail = response.data!;
      }
    } catch (e) {
      error = e.toString();
    }

    notifyListeners();

    if (error.isNotEmpty) {
      return Future.error(error);
    }
    return true;
  }

  // remove viol
  Future<bool> removeViol() async {
    var error = "";

    try {
      final response = await _violService.deleteViol(_violIDSaved);
      if (response.error != null) {
        error = response.error!.message;
      }
    } catch (e) {
      error = e.toString();
    }

    notifyListeners();
    if (error.isNotEmpty) {
      return Future.error(error);
    }
    await findViol(loading: false);
    return true;
  }

  // * detail state
  ViewState _violChangeState = ViewState.idle;
  ViewState get violChangeState => _violChangeState;
  void setViolChangeState(ViewState viewState) {
    _violChangeState = viewState;
    notifyListeners();
  }

  // dipanggil ketika data sudah tidak dibutuhkan lagi,
  // di on dispose
  void onClose() {
    removeDetail();
    _violList = [];
  }
}

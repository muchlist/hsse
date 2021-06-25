import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:hsse/api/filter_models/truck_filter.dart';
import 'package:hsse/api/json_models/requests/truck_edit_req.dart';
import 'package:hsse/api/json_models/requests/truck_req.dart';
import 'package:hsse/api/json_models/responses/truck_list_resp.dart';
import 'package:hsse/api/json_models/responses/truck_resp.dart';
import 'package:hsse/api/services/truck_service.dart';
import 'package:hsse/singleton/shared_pref.dart';
import 'package:hsse/utils/enum_state.dart';

class TruckProvider extends ChangeNotifier {
  final TruckService _truckService;
  TruckProvider(this._truckService);

  // =======================================================
  // List Truck

  // * state
  ViewState _state = ViewState.idle;
  ViewState get state => _state;
  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  // truck list cache
  List<TruckMinData> _truckList = [];
  List<TruckMinData> get truckList {
    return UnmodifiableListView(_truckList);
  }

  // *memasang filter pada pencarian truck
  FilterTruck _filterTruck = FilterTruck(branch: SharedPrefs().getBranch());
  void setFilter(FilterTruck filter) {
    _filterTruck = filter;
  }

  // * Mendapatkan truck
  Future<void> findTruck({bool loading = true}) async {
    if (loading) {
      setState(ViewState.busy);
    }

    var error = "";
    try {
      final response = await _truckService.findTruck(_filterTruck);
      if (response.error != null) {
        error = response.error!.message;
      } else {
        _truckList = response.data;
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
  // detail truck

  // * detail state
  ViewState _detailState = ViewState.idle;
  ViewState get detailState => _detailState;
  void setDetailState(ViewState viewState) {
    _detailState = viewState;
    notifyListeners();
  }

  String _truckIDSaved = "";
  void setTruckID(String truckID) {
    _truckIDSaved = truckID;
  }

  String getTruckId() => _truckIDSaved;

  // truck detail cache
  TruckData _truckDetail = TruckData("", 0, "", "", 0, "", "", "", "", "", "",
      "", "", "", false, 0, 0, false, 0, 0);
  TruckData get truckDetail {
    return _truckDetail;
  }

  void removeDetail() {
    _truckDetail = TruckData("", 0, "", "", 0, "", "", "", "", "", "", "", "",
        "", false, 0, 0, false, 0, 0);
  }

  // get detail truck
  // * Mendapatkan truck
  Future<void> getDetail() async {
    setDetailState(ViewState.busy);

    var error = "";
    try {
      final response = await _truckService.getTruck(_truckIDSaved);
      if (response.error != null) {
        error = response.error!.message;
      } else {
        final truckData = response.data!;
        _truckDetail = truckData;
      }
    } catch (e) {
      error = e.toString();
    }

    setDetailState(ViewState.idle);
    if (error.isNotEmpty) {
      return Future.error(error);
    }
  }

  // return future true jika add truck berhasil
  // memanggil findTruck sehingga tidak perlu notifyListener
  Future<bool> addTruck(TruckRequest payload) async {
    setState(ViewState.busy);
    var error = "";

    try {
      final response = await _truckService.createTruck(payload);
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
    await findTruck(loading: false);
    return true;
  }

  // // truck option cache
  // OptLocationType _truckOption = OptLocationType(["None"], ["None"]);
  // OptLocationType get truckOption {
  //   return _truckOption;
  // }

  // // * Mendapatkan check option
  // Future<void> findOptionTruck() async {
  //   try {
  //     final response =
  //         await _truckService.getOptCreateTruck(App.getBranch() ?? "");
  //     _truckOption = response;
  //   } catch (e) {
  //     return Future.error(e.toString());
  //   }
  //   notifyListeners();
  // }

  // return future TruckDetail jika edit truck berhasil
  Future<bool> editTruck(TruckEditRequest payload) async {
    setState(ViewState.busy);
    var error = "";

    try {
      final response = await _truckService.editTruck(_truckIDSaved, payload);
      if (response.error != null) {
        error = response.error!.message;
      } else {
        _truckDetail = response.data!;
      }
    } catch (e) {
      error = e.toString();
    }

    setState(ViewState.idle);
    if (error.isNotEmpty) {
      return Future.error(error);
    }

    await findTruck(loading: false);
    return true;
  }

  // remove truck
  Future<bool> removeTruck() async {
    var error = "";

    try {
      final response = await _truckService.deleteTruck(_truckIDSaved);
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
    await findTruck(loading: false);
    return true;
  }

  // * detail state
  ViewState _truckChangeState = ViewState.idle;
  ViewState get truckChangeState => _truckChangeState;
  void setTruckChangeState(ViewState viewState) {
    _truckChangeState = viewState;
    notifyListeners();
  }

  // dipanggil ketika data sudah tidak dibutuhkan lagi,
  // di on dispose
  void onClose() {
    removeDetail();
    _truckList = [];
  }
}

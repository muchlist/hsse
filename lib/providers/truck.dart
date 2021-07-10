import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:hsse/api/filter_models/truck_filter.dart';
import 'package:hsse/api/json_models/requests/truck_edit_req.dart';
import 'package:hsse/api/json_models/requests/truck_req.dart';
import 'package:hsse/api/json_models/responses/message_resp.dart';
import 'package:hsse/api/json_models/responses/truck_list_resp.dart';
import 'package:hsse/api/json_models/responses/truck_resp.dart';
import 'package:hsse/api/services/truck_service.dart';
import 'package:hsse/singleton/shared_pref.dart';
import 'package:hsse/utils/enum_state.dart';

class TruckProvider extends ChangeNotifier {
  TruckProvider(this._truckService);
  final TruckService _truckService;

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
  List<TruckMinData> _truckList = <TruckMinData>[];
  List<TruckMinData> get truckList {
    return UnmodifiableListView<TruckMinData>(_truckList);
  }

  // *memasang filter pada pencarian truck
  FilterTruck filterTruck = FilterTruck(branch: SharedPrefs().getBranch());

  // * Mendapatkan truck
  Future<void> findTruck({bool loading = true}) async {
    if (loading) {
      setState(ViewState.busy);
    }

    String error = "";
    try {
      final TruckListResponse response =
          await _truckService.findTruck(filterTruck);
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
      return Future<void>.error(error);
    }
  }

// ========================================================
  // search truck
  // truck search list cache
  List<TruckMinData> _truckSearchList = <TruckMinData>[];
  List<TruckMinData> get truckSearchList {
    return UnmodifiableListView<TruckMinData>(_truckSearchList);
  }

  // * Mendapatkan truck
  Future<void> searchTruck(String noIdentity) async {
    final FilterTruck filter = FilterTruck(
        branch: SharedPrefs().getBranch(), identity: noIdentity.toUpperCase());

    String error = "";
    try {
      final TruckListResponse response = await _truckService.findTruck(filter);
      if (response.error != null) {
        error = response.error!.message;
      } else {
        _truckSearchList = response.data;
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
  // detail truck

  // * detail state
  ViewState _detailState = ViewState.idle;
  ViewState get detailState => _detailState;
  void setDetailState(ViewState viewState) {
    _detailState = viewState;
    notifyListeners();
  }

  /// truckID jika kurang dari 10 digit artinya nomor lambung
  String truckID = "";

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

    String error = "";
    try {
      late TruckDetailResponse response;
      if (truckID.length < 10) {
        // cari berdasarkan nomor lambung
        response = await _truckService.getTruckByLambung(truckID);
      } else {
        // cari berdsasarkan ObjectID
        response = await _truckService.getTruck(truckID);
      }

      if (response.error != null) {
        error = response.error!.message;
      } else {
        final TruckData truckData = response.data!;
        _truckDetail = truckData;
      }
    } catch (e) {
      error = e.toString();
    }

    setDetailState(ViewState.idle);
    if (error.isNotEmpty) {
      return Future<void>.error(error);
    }
  }

  // return future true jika add truck berhasil
  // memanggil findTruck sehingga tidak perlu notifyListener
  Future<bool> addTruck(TruckRequest payload) async {
    setState(ViewState.busy);
    String error = "";

    try {
      final MessageResponse response = await _truckService.createTruck(payload);
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
    await findTruck(loading: false);
    return true;
  }

  // return future TruckDetail jika edit truck berhasil
  Future<bool> editTruck(TruckEditRequest payload) async {
    setState(ViewState.busy);
    String error = "";

    try {
      final TruckDetailResponse response =
          await _truckService.editTruck(truckID, payload);
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
      return Future<bool>.error(error);
    }

    await findTruck(loading: false);
    return true;
  }

  // remove truck
  Future<bool> removeTruck() async {
    String error = "";

    try {
      final MessageResponse response = await _truckService.deleteTruck(truckID);
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
    _truckList = <TruckMinData>[];
  }
}

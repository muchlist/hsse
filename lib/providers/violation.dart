import 'dart:collection';

import 'package:flutter/cupertino.dart';
import '../models/violation.dart';

class ViolationProvider extends ChangeNotifier {
  List<Violation> _violations = [
    Violation(
        id: "DA 9021",
        detail: "Pelanggaran truck Sopir memasuki area kerja tanpa APD",
        date: DateTime.now().subtract(Duration(days: 3, hours: 8)),
        location: "Terminal petikemas",
        imgUrl: "images/example2.jpg",
        approved: true,
        approvedDate: DateTime.now(),
        approver: "Big Boss"),
    Violation(
        id: "DA 1111",
        detail: "Kenderaan tanpa rotari dilarang masuk " * 3,
        date: DateTime.now().subtract(Duration(days: 11)),
        location: "Terminal petikemas",
        imgUrl: "images/example.jpg",
        approved: true,
        approvedDate: DateTime.now(),
        approver: "Big Boss"),
    Violation(
        id: "NAN",
        detail: "Orang gila kedapatan memasuki area kerja",
        date: DateTime.now().subtract(Duration(hours: 11)),
        location: "Terminal petikemas",
        imgUrl: "",
        approved: false,
        approvedDate: DateTime.now(),
        approver: "Big Boss"),
  ];
  List<Violation> get violations {
    return UnmodifiableListView(_violations);
  }

  Violation? _violationDetail;
  Violation? get detail => _violationDetail;
  void setDetail(int index) {
    _violationDetail = _violations[index];
  }

  var _dummyNum = 2;
  void addDummyData() {
    var imgUrl = "";
    if (_dummyNum % 2 == 0) {
      imgUrl = "images/fake.jpg";
    }

    _violations.add(Violation(
        id: "Dummy $_dummyNum",
        detail: "Lorem ipsum sir dolor amet " * _dummyNum,
        date: DateTime.now(),
        location: "Dummy Location",
        imgUrl: imgUrl,
        approved: false,
        approvedDate: DateTime.now(),
        approver: ""));
    _dummyNum++;
    notifyListeners();
  }
}

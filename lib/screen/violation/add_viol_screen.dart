import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hsse/config/options.dart';
import 'package:hsse/router/routes.dart';
import 'package:hsse/screen/components/custom_button.dart';
import 'package:hsse/screen/components/flushbar.dart';
import 'package:hsse/screen/components/text_form.dart';
import 'package:hsse/screen/components/ui_helper.dart';
import 'package:hsse/search/truck_search.dart';
import 'package:hsse/utils/enum_state.dart';
import 'package:provider/provider.dart';
import 'package:hsse/api/json_models/requests/viol_req.dart';
import 'package:hsse/providers/viol.dart';
import 'package:hsse/utils/utils.dart';

class AddViolScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Tambah Pelanggaran"),
      ),
      body: AddViolBody(),
    );
  }
}

class AddViolBody extends StatefulWidget {
  @override
  _AddViolBodyState createState() => _AddViolBodyState();
}

class _AddViolBodyState extends State<AddViolBody> {
  final _key = GlobalKey<FormState>();

  var _selectedNoIdentity = "";
  String? _selectedLocation;
  String? _selectedType;

  final detailController = TextEditingController();

  DateTime? _dateSelected;

  String getDateString() {
    if (_dateSelected == null) {
      return "Waktu pelanggaran";
    }
    return _dateSelected!.getFullTimeFormat();
  }

  void _showDateTimePicker() {
    DatePicker.showDateTimePicker(context,
        locale: LocaleType.id,
        showTitleActions: true,
        minTime: DateTime(DateTime.now().year - 10),
        maxTime: DateTime(DateTime.now().year + 1), onConfirm: (date) {
      setState(() {
        _dateSelected = date;
      });
    }, currentTime: _dateSelected);
  }

  void _addViol() {
    if (_key.currentState?.validate() ?? false) {
      // validasi tambahan
      var errorMessage = "";
      if (_selectedNoIdentity.isEmpty) {
        errorMessage = errorMessage + "Nomor lambung tidak boleh kosong. ";
      }
      if (_selectedLocation == null) {
        errorMessage = errorMessage + "Lokasi tidak boleh kosong. ";
      }
      if (_selectedType == null) {
        errorMessage = errorMessage + "Tipe tidak boleh kosong. ";
      }
      if (errorMessage.isNotEmpty) {
        showToastWarning(context: context, message: errorMessage, onTop: true);
        return;
      }

      // Payload
      final payload = ViolRequest(
        noIdentity: _selectedNoIdentity,
        state: 0,
        typeViolation: _selectedType!,
        detailViolation: detailController.text,
        timeViolation: (_dateSelected != null) ? _dateSelected!.toInt() : 0,
        location: _selectedLocation!,
      );

      // Call Provider
      Future.delayed(
          Duration.zero,
          () => context.read<ViolProvider>().addViol(payload).then((value) {
                if (value) {
                  // Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(
                      context, RouteGenerator.detail);
                  showToastSuccess(
                      context: context,
                      message: "Berhasil menambahkan pelanggaran");
                }
              }).onError((error, _) {
                if (error != null) {
                  showToastError(
                      context: context, message: error.toString(), onTop: true);
                }
              }));
    }
  }

  @override
  void dispose() {
    detailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          // Consumer ------------------------------------------------------
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // * Skor pelanggaran text ------------------------
                const Text(
                  "Nomor lambung",
                  style: TextStyle(fontSize: 16),
                ),
                GestureDetector(
                  onTap: () async {
                    final searchResult = await showSearch<String?>(
                      context: context,
                      delegate: TruckSearchDelegate(),
                    );
                    if (searchResult != null && searchResult.isNotEmpty) {
                      setState(() {
                        _selectedNoIdentity = searchResult;
                      });
                    }
                  },
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedNoIdentity,
                          ),
                          Icon(CupertinoIcons.search),
                        ]),
                  ),
                ),
                verticalSpaceSmall,

                // * Tipe text ------------------------
                const Text(
                  "Tipe Pelanggaran",
                  style: TextStyle(fontSize: 16),
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(color: Colors.white),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: Text("Tipe"),
                      value: (_selectedType != null) ? _selectedType : null,
                      items: typeViolations.map((loc) {
                        return DropdownMenuItem<String>(
                          value: loc,
                          child: Text(loc),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedType = value;
                          FocusScope.of(context).requestFocus(FocusNode());
                        });
                      },
                    ),
                  ),
                ),

                verticalSpaceMedium,

                // * Detail text ------------------------
                const Text(
                  "Detail Pelanggaran",
                  style: TextStyle(fontSize: 16),
                ),

                CustomTextForm(
                  controller: detailController,
                  minLines: 2,
                  maxLines: 4,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "Detail tidak boleh kosong";
                    }
                    return null;
                  },
                ),

                verticalSpaceMedium,

                // * Lokasi text ------------------------
                const Text(
                  "Lokasi Pelanggaran",
                  style: TextStyle(fontSize: 16),
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(color: Colors.white),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: Text("Lokasi"),
                      value: (_selectedLocation != null)
                          ? _selectedLocation
                          : null,
                      items: locationViolations.map((loc) {
                        return DropdownMenuItem<String>(
                          value: loc,
                          child: Text(loc),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedLocation = value;
                          FocusScope.of(context).requestFocus(FocusNode());
                        });
                      },
                    ),
                  ),
                ),

                verticalSpaceMedium,

                // * Waktu pelanggaran text ------------------------
                const Text(
                  "Waktu Pelanggaran",
                  style: TextStyle(fontSize: 16),
                ),

                GestureDetector(
                  onTap: _showDateTimePicker,
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getDateString(),
                          ),
                          Icon(CupertinoIcons.calendar),
                        ]),
                  ),
                ),

                verticalSpaceMedium,

                Consumer<ViolProvider>(builder: (_, data, __) {
                  return (data.state == ViewState.busy)
                      ? Center(child: const CircularProgressIndicator())
                      : Center(
                          child: HomeLikeButton(
                              iconData: CupertinoIcons.add,
                              text: "Simpan Pelanggaran",
                              tapTap: _addViol),
                        );
                }),

                verticalSpaceMedium,
              ],
            ),
          )),
    );
  }
}

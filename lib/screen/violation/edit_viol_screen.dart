import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hsse/api/json_models/requests/viol_edit_req.dart';
import 'package:hsse/api/json_models/responses/viol_resp.dart';
import 'package:hsse/config/options.dart';
import 'package:hsse/screen/components/custom_button.dart';
import 'package:hsse/screen/components/flushbar.dart';
import 'package:hsse/screen/components/text_form.dart';
import 'package:hsse/screen/components/ui_helper.dart';
import 'package:hsse/search/truck_search.dart';
import 'package:hsse/utils/enum_state.dart';
import 'package:provider/provider.dart';
import 'package:hsse/providers/viol.dart';
import 'package:hsse/utils/utils.dart';

class EditViolScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Tambah Pelanggaran"),
      ),
      body: EditViolBody(),
    );
  }
}

class EditViolBody extends StatefulWidget {
  @override
  _EditViolBodyState createState() => _EditViolBodyState();
}

class _EditViolBodyState extends State<EditViolBody> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late ViolProvider violProvider;

  String _selectedNoIdentity = "";
  String? _selectedLocation;
  String? _selectedType;

  final TextEditingController detailController = TextEditingController();

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
        minTime: DateTime(DateTime.now().year - 10),
        maxTime: DateTime(DateTime.now().year + 1), onConfirm: (DateTime date) {
      setState(() {
        _dateSelected = date;
      });
    }, currentTime: _dateSelected);
  }

  void _editViol(int timestamp) {
    if (_key.currentState?.validate() ?? false) {
      // validasi tambahan
      String errorMessage = "";
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
        showToastWarning(context: context, message: errorMessage);
        return;
      }

      // Payload
      final ViolEditRequest payload = ViolEditRequest(
          noIdentity: _selectedNoIdentity,
          typeViolation: _selectedType!,
          detailViolation: detailController.text,
          timeViolation: 0,
          location: _selectedLocation!,
          filterTimestamp: timestamp);

      // Call Provider
      Future<void>.delayed(
          Duration.zero,
          () =>
              context.read<ViolProvider>().editViol(payload).then((bool value) {
                if (value) {
                  Navigator.of(context).pop();
                }
              }).onError((Object? error, _) {
                if (error != null) {
                  showToastError(context: context, message: error.toString());
                }
              }));
    }
  }

  @override
  void initState() {
    violProvider = context.read<ViolProvider>();
    final ViolData detail = violProvider.violDetail;

    setState(() {
      _selectedNoIdentity = detail.noIdentity;
      _dateSelected = detail.timeViolation.toDate();
      detailController.text = detail.detailViolation;
      if (typeViolations.contains(detail.typeViolation)) {
        _selectedType = detail.typeViolation;
      }
      if (locationViolations.contains(detail.location)) {
        _selectedLocation = detail.location;
      }
    });
    super.initState();
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
              children: <Widget>[
                // * Skor pelanggaran text ------------------------
                const Text(
                  "Nomor lambung",
                  style: TextStyle(fontSize: 16),
                ),
                GestureDetector(
                  onTap: () async {
                    final String? searchResult = await showSearch<String?>(
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
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            _selectedNoIdentity,
                          ),
                          const Icon(CupertinoIcons.search),
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
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: const Text("Tipe"),
                      value: (_selectedType != null) ? _selectedType : null,
                      items: typeViolations.map((String loc) {
                        return DropdownMenuItem<String>(
                          value: loc,
                          child: Text(loc),
                        );
                      }).toList(),
                      onChanged: (String? value) {
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
                  validator: (String? text) {
                    if (text == null || text.isEmpty) {
                      return "Detail tidak boleh kosong";
                    }
                    return null;
                  },
                ),

                verticalSpaceMedium,

                // * Tipe text ------------------------
                const Text(
                  "Lokasi Pelanggaran",
                  style: TextStyle(fontSize: 16),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: const Text("Lokasi"),
                      value: (_selectedLocation != null)
                          ? _selectedLocation
                          : null,
                      items: locationViolations.map((String loc) {
                        return DropdownMenuItem<String>(
                          value: loc,
                          child: Text(loc),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _selectedLocation = value;
                          FocusScope.of(context).requestFocus(FocusNode());
                        });
                      },
                    ),
                  ),
                ),

                verticalSpaceSmall,

                // * Waktu pelanggaran text ------------------------
                const Text(
                  "Waktu Pelanggaran",
                  style: TextStyle(fontSize: 16),
                ),

                GestureDetector(
                  onTap: _showDateTimePicker,
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            getDateString(),
                          ),
                          const Icon(CupertinoIcons.calendar),
                        ]),
                  ),
                ),

                verticalSpaceMedium,

                Consumer<ViolProvider>(builder: (_, ViolProvider data, __) {
                  return (data.state == ViewState.busy)
                      ? const Center(child: CircularProgressIndicator())
                      : Center(
                          child: HomeLikeButton(
                              iconData: Icons.edit,
                              text: "Edit Pelanggaran",
                              tapTap: () =>
                                  _editViol(data.violDetail.updatedAt)),
                        );
                }),

                verticalSpaceMedium,
              ],
            ),
          )),
    );
  }
}

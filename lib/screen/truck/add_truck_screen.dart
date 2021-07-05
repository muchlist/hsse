import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hsse/screen/components/custom_button.dart';
import 'package:hsse/screen/components/flushbar.dart';
import 'package:hsse/screen/components/text_form.dart';
import 'package:hsse/screen/components/ui_helper.dart';
import 'package:hsse/utils/enum_state.dart';
import 'package:hsse/utils/validator_regex.dart';
import 'package:provider/provider.dart';
import 'package:hsse/api/json_models/requests/truck_req.dart';
import 'package:hsse/providers/truck.dart';

class AddTruckScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Tambah Aturan"),
      ),
      body: AddTruckBody(),
    );
  }
}

class AddTruckBody extends StatefulWidget {
  @override
  _AddTruckBodyState createState() => _AddTruckBodyState();
}

class _AddTruckBodyState extends State<AddTruckBody> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController noIdentityController = TextEditingController();
  final TextEditingController noPolController = TextEditingController();
  final TextEditingController markController = TextEditingController();
  final TextEditingController ownerController = TextEditingController();
  final TextEditingController hpController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  void _addTruck() {
    if (_key.currentState?.validate() ?? false) {
      // Payload
      final TruckRequest payload = TruckRequest(
        noIdentity: noIdentityController.text,
        noPol: noPolController.text,
        mark: markController.text,
        owner: ownerController.text,
        hp: hpController.text,
        email: emailController.text,
      );

      // Call Provider
      Future<void>.delayed(
          Duration.zero,
          () => context
                  .read<TruckProvider>()
                  .addTruck(payload)
                  .then((bool value) {
                if (value) {
                  Navigator.of(context).pop();
                  showToastSuccess(
                      context: context, message: "Berhasil menambahkan truck");
                }
              }).onError((Object? error, _) {
                if (error != null) {
                  showToastError(context: context, message: error.toString());
                }
              }));
    }
  }

  @override
  void dispose() {
    noIdentityController.dispose();
    noPolController.dispose();
    markController.dispose();
    ownerController.dispose();
    hpController.dispose();
    emailController.dispose();

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
                // * Nomor Lambung text ------------------------
                const Text(
                  "Nomor Lambung",
                  style: TextStyle(fontSize: 16),
                ),
                CustomTextForm(
                  controller: noIdentityController,
                  textInputType: TextInputType.number,
                  validator: (String? text) {
                    if (text == null || text.isEmpty) {
                      return "Nomor lambung tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                verticalSpaceSmall,

                // * Nomor Polisi text ------------------------
                const Text(
                  "Nomor Polisi",
                  style: TextStyle(fontSize: 16),
                ),
                CustomTextForm(
                  controller: noPolController,
                  validator: (String? text) {
                    if (text == null || text.isEmpty) {
                      return "Nomor polisi tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                verticalSpaceSmall,

                // * mark text ------------------------
                const Text(
                  "Ciri ciri truck",
                  style: TextStyle(fontSize: 16),
                ),
                CustomTextForm(
                  controller: markController,
                ),
                verticalSpaceSmall,

                // * Nomor Polisi text ------------------------
                const Text(
                  "Pemilik truck",
                  style: TextStyle(fontSize: 16),
                ),
                CustomTextForm(
                  controller: ownerController,
                  validator: (String? text) {
                    if (text == null || text.isEmpty) {
                      return "Nama pemilik tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                verticalSpaceSmall,

                // * HP text ------------------------
                const Text(
                  "Nomor whatsapp",
                  style: TextStyle(fontSize: 16),
                ),

                CustomTextForm(
                  controller: hpController,
                  textInputType: TextInputType.phone,
                ),

                verticalSpaceSmall,

                // * email text ------------------------
                const Text(
                  "Email",
                  style: TextStyle(fontSize: 16),
                ),

                CustomTextForm(
                  controller: emailController,
                  textInputType: TextInputType.emailAddress,
                  validator: (String? text) {
                    if (text == null || text.isEmpty) {
                      return "Email tidak boleh kosong";
                    }
                    if (!ValueValidator().isEmail(text)) {
                      return "Email tidak valid";
                    }
                    return null;
                  },
                ),

                verticalSpaceMedium,

                Consumer<TruckProvider>(builder: (_, TruckProvider data, __) {
                  return (data.state == ViewState.busy)
                      ? const Center(child: CircularProgressIndicator())
                      : Center(
                          child: HomeLikeButton(
                              iconData: CupertinoIcons.add,
                              text: "Simpan Truck",
                              tapTap: _addTruck),
                        );
                }),

                verticalSpaceMedium,
              ],
            ),
          )),
    );
  }
}

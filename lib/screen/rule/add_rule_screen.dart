import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hsse/screen/components/custom_button.dart';
import 'package:hsse/screen/components/flushbar.dart';
import 'package:hsse/screen/components/text_form.dart';
import 'package:hsse/screen/components/ui_helper.dart';
import 'package:hsse/utils/enum_state.dart';
import 'package:provider/provider.dart';
import 'package:hsse/api/json_models/requests/rules_req.dart';
import 'package:hsse/providers/rules.dart';

class AddRulesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Tambah Aturan"),
      ),
      body: AddRulesBody(),
    );
  }
}

class AddRulesBody extends StatefulWidget {
  @override
  _AddRulesBodyState createState() => _AddRulesBodyState();
}

class _AddRulesBodyState extends State<AddRulesBody> {
  final _key = GlobalKey<FormState>();

  final scoreController = TextEditingController();
  final blockController = TextEditingController();
  final descController = TextEditingController();

  void _addRules() {
    if (_key.currentState?.validate() ?? false) {
      var score = 0;
      var blockDay = 0;
      if (scoreController.text.isNotEmpty) {
        score = int.parse(scoreController.text);
      }
      if (blockController.text.isNotEmpty) {
        blockDay = int.parse(blockController.text);
      }

      // Payload
      final payload = RulesRequest(
          score: score,
          blockTime: blockDay * 86400,
          description: descController.text);

      // Call Provider
      Future.delayed(
          Duration.zero,
          () => context.read<RulesProvider>().addRules(payload).then((value) {
                if (value) {
                  Navigator.of(context).pop();
                  showToastSuccess(
                      context: context, message: "Berhasil menambahkan aturan");
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
    scoreController.dispose();
    blockController.dispose();
    descController.dispose();

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
                  "Skor pelanggaran",
                  style: TextStyle(fontSize: 16),
                ),
                CustomTextForm(
                  controller: scoreController,
                  textInputType: TextInputType.number,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return null;
                    } else if (int.tryParse(text) != null &&
                        int.parse(text) >= 0) {
                      return null;
                    }
                    return "Skor harus berupa angka";
                  },
                ),
                verticalSpaceSmall,

                // * Desc text ------------------------
                const Text(
                  "Desc",
                  style: TextStyle(fontSize: 16),
                ),

                CustomTextForm(
                  controller: descController,
                  minLines: 2,
                  maxLines: 4,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "Desc tidak boleh kosong";
                    }
                    return null;
                  },
                ),

                verticalSpaceSmall,

                // * Blokir text ------------------------
                const Text(
                  "Blokir (hari)",
                  style: TextStyle(fontSize: 16),
                ),

                CustomTextForm(
                  controller: blockController,
                  textInputType: TextInputType.number,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return null;
                    } else if (int.tryParse(text) != null &&
                        int.parse(text) >= 0) {
                      return null;
                    }
                    return "Blokir (hari) harus berupa angka";
                  },
                ),

                verticalSpaceMedium,

                Consumer<RulesProvider>(builder: (_, data, __) {
                  return (data.state == ViewState.busy)
                      ? Center(child: const CircularProgressIndicator())
                      : Center(
                          child: HomeLikeButton(
                              iconData: CupertinoIcons.add,
                              text: "Buat Aturan",
                              tapTap: _addRules),
                        );
                }),

                verticalSpaceMedium,
              ],
            ),
          )),
    );
  }
}

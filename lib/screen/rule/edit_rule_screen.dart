import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hsse/api/json_models/requests/rules_edit_req.dart';
import 'package:hsse/api/json_models/responses/rules_resp.dart';
import 'package:hsse/screen/components/custom_button.dart';
import 'package:hsse/screen/components/flushbar.dart';
import 'package:hsse/screen/components/text_form.dart';
import 'package:hsse/screen/components/ui_helper.dart';
import 'package:hsse/utils/enum_state.dart';
import 'package:provider/provider.dart';
import 'package:hsse/providers/rules.dart';

class EditRulesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Edit Aturan"),
      ),
      body: EditRulesBody(),
    );
  }
}

class EditRulesBody extends StatefulWidget {
  @override
  _EditRulesBodyState createState() => _EditRulesBodyState();
}

class _EditRulesBodyState extends State<EditRulesBody> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController scoreController = TextEditingController();
  final TextEditingController blockController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  void _editRules(int timeStamp) {
    if (_key.currentState?.validate() ?? false) {
      int score = 0;
      int blockDay = 0;
      if (scoreController.text.isNotEmpty) {
        score = int.parse(scoreController.text);
      }
      if (blockController.text.isNotEmpty) {
        blockDay = int.parse(blockController.text);
      }

      // Payload
      final RulesEditRequest payload = RulesEditRequest(
        score: score,
        blockTime: blockDay * 86400,
        description: descController.text,
        filterTimestamp: timeStamp,
      );

      // Call Provider
      Future<void>.delayed(
        Duration.zero,
        () =>
            context.read<RulesProvider>().editRules(payload).then((bool value) {
          if (value) {
            Navigator.of(context).pop();
            showToastSuccess(
                context: context, message: "Berhasil mengubah aturan");
          }
        }).onError(
          (Object? error, _) {
            if (error != null) {
              showToastError(context: context, message: error.toString());
            }
          },
        ),
      );
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
  void initState() {
    Future<void>.delayed(
      Duration.zero,
      () => context.read<RulesProvider>().getDetail().then((RulesData value) {
        setState(() {
          scoreController.text = value.score.toString();
          descController.text = value.description;
          blockController.text = (value.blockTime ~/ 86400).toString();
        });
      }).onError(
        (Object? error, _) {
          if (error != null) {
            showToastError(context: context, message: error.toString());
          }
        },
      ),
    );
    super.initState();
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
                  "Skor pelanggaran",
                  style: TextStyle(fontSize: 16),
                ),
                CustomTextForm(
                  controller: scoreController,
                  textInputType: TextInputType.number,
                  validator: (String? text) {
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
                  validator: (String? text) {
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
                  validator: (String? text) {
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

                Consumer<RulesProvider>(builder: (_, RulesProvider data, __) {
                  return (data.state == ViewState.busy)
                      ? const Center(child: CircularProgressIndicator())
                      : Center(
                          child: HomeLikeButton(
                              iconData: CupertinoIcons.add,
                              text: "Ubah aturan",
                              tapTap: () =>
                                  _editRules(data.rulesDetail.updatedAt)),
                        );
                }),

                verticalSpaceMedium,
              ],
            ),
          )),
    );
  }
}

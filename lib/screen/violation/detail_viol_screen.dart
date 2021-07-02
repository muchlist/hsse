import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hsse/api/json_models/responses/viol_resp.dart';
import 'package:hsse/config/config.dart';
import 'package:hsse/providers/viol.dart';
import 'package:hsse/router/routes.dart';
import 'package:hsse/screen/components/cached_image.dart';
import 'package:hsse/screen/components/confirm_dialog.dart';
import 'package:hsse/screen/components/custom_button.dart';
import 'package:hsse/screen/components/disable_glow.dart';
import 'package:hsse/screen/components/flushbar.dart';
import 'package:hsse/screen/components/ui_helper.dart';
import 'package:hsse/utils/enum_state.dart';
import 'package:hsse/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

GlobalKey<RefreshIndicatorState> refreshKeyDetailScreen =
    GlobalKey<RefreshIndicatorState>();

class ViolDetailScreen extends StatelessWidget {
  const ViolDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Detail Pelanggaran"),
      ),
      body: const ViolDetailScreenBody(),
    );
  }
}

class ViolDetailScreenBody extends StatefulWidget {
  const ViolDetailScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  _ViolDetailScreenBodyState createState() => _ViolDetailScreenBodyState();
}

class _ViolDetailScreenBodyState extends State<ViolDetailScreenBody> {
  late ViolProvider _violProvider;

  Future<void> _loadDetail() {
    return Future<void>.delayed(Duration.zero, () {
      _violProvider.getDetail().onError((Object? error, _) {
        showToastError(context: context, message: error.toString());
      });
    });
  }

  Future<void> _ready() {
    return Future<void>.delayed(Duration.zero, () {
      _violProvider.sendConfirm().then((_) {
        showToastSuccess(
            context: context,
            message: "Dokumen berhasil dikirim, meminta persetujuan HSSE");
      }).onError((Object? error, _) {
        showToastError(context: context, message: error.toString());
      });
    });
  }

  Future<void> _approve() {
    return Future<void>.delayed(Duration.zero, () {
      _violProvider.approve().then((_) {
        showToastSuccess(
            context: context, message: "Dokumen berhasil di approve");
      }).onError((Object? error, _) {
        showToastError(context: context, message: error.toString());
      });
    });
  }

  Future<void> _reject() {
    return Future<void>.delayed(Duration.zero, () {
      _violProvider.reject().onError((Object? error, _) {
        showToastError(context: context, message: error.toString());
      });
    });
  }

  late File? _image;
  final ImagePicker picker = ImagePicker();

  Future<void> _getImageAndUpload(
      {required BuildContext context,
      required ImageSource source,
      required String id}) async {
    final PickedFile? pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      return;
    }

    // compress and upload
    await _violProvider.uploadImage(_image!).then((bool value) {
      if (value) {
        showToastSuccess(
          context: context,
          message: "Berhasil mengupload gambar",
        );
      }
    }).onError((Object? error, _) {
      showToastError(context: context, message: error.toString());
      // ignore: prefer_void_to_null
      return Future<Null>.error(error.toString());
    });
  }

  Future<void> _deleteImage(String imageWithExtention) {
    return Future<void>.delayed(Duration.zero, () {
      _violProvider.deleteImage(imageWithExtention).then((_) {
        showToastSuccess(context: context, message: "Berhasil menghapus foto");
      }).onError((Object? error, _) {
        showToastError(context: context, message: error.toString());
      });
    });
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
      );
    } else {
      showToastError(context: context, message: "Error saat membuka link pdf!");
    }
  }

  @override
  void initState() {
    _violProvider = context.read<ViolProvider>();
    _loadDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ViolProvider>(
      builder: (_, ViolProvider data, __) {
        final ViolData detail = data.violDetail;

        if (data.detailState == ViewState.busy) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              top: 0,
              left: 0,
              right: 0,
              child: RefreshIndicator(
                key: refreshKeyDetailScreen,
                onRefresh: _loadDetail,
                child: DisableOverScrollGlow(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text("TRUCK"),
                          verticalSpaceSmall,
                          buildUpperScreen(detail),
                          verticalSpaceRegular,
                          const Text("PELAPORAN"),
                          verticalSpaceSmall,
                          buildMidScreen(detail),
                          verticalSpaceRegular,
                          const Text("LAMPIRAN"),
                          verticalSpaceSmall,
                          // jika foto 0 dan state 2 maka hilangkan space kosong
                          if (!(detail.images.isEmpty && detail.state == 2))
                            buildPhotoList(detail),
                          verticalSpaceMedium,
                          if (detail.state == 2) // approved
                            Center(
                              child: HomeLikeButton(
                                  iconData: Icons.download,
                                  text: "Download PDF",
                                  tapTap: () {
                                    final String url =
                                        "${ConstUrl.baseUrl}pdf/${detail.id}.pdf";
                                    _launchInBrowser(url);
                                  }),
                            ),
                          if (detail.state == 0) //draft
                            Center(
                              child: HomeLikeButton(
                                  iconData: Icons.edit,
                                  text: "Edit ",
                                  color: Colors.deepOrange.shade300,
                                  tapTap: () {
                                    Navigator.pushNamed(
                                        context, RouteGenerator.editViol);
                                  }),
                            ),
                          const SizedBox(height: 150)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: (detail.state == 2)
                  ? buildBottomApproved(detail)
                  : (detail.state == 1)
                      ? buildBottomScreen()
                      : buildBottomDraft(),
            )
          ],
        );
      },
    );
  }

  Container buildUpperScreen(ViolData data) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "🚚  Nomor Lambung",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            descText("${data.noIdentity} (${data.noPol})"),
            verticalSpaceSmall,
            const Text(
              "👤  Pemilik",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            descText(data.owner),
            verticalSpaceSmall,
            const Text(
              "🚥  Tipe pelanggaran",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            descText(data.typeViolation),
            verticalSpaceSmall,
            const Text(
              "🌪  Pelanggaran",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            descText(data.detailViolation),
            verticalSpaceSmall,
            const Text(
              "🔢 Pelanggaran ke -",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            if (data.state == 2)
              descText("${data.nViol} (terkonfirmasi sistem)")
            else
              descText("${data.nViol} (perkiraan)"),
            verticalSpaceSmall,
            const Text(
              "🛣  Lokasi",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            descText(data.location),
            verticalSpaceSmall,
            const Text(
              "⏲  Waktu kejadian",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            descText(data.timeViolation.getCompleteDateString()),
          ],
        ),
      ),
    );
  }

  Container buildMidScreen(ViolData data) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "👮‍♂️  Pelapor",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            descText(data.createdBy),
            verticalSpaceSmall,
            const Text(
              "⏲  Waktu lapor",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            descText(data.createdAt.getCompleteDateString()),
          ],
        ),
      ),
    );
  }

  Widget buildBottomScreen() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ConfirmButton(
              iconData: Icons.check,
              text: "Setuju ",
              tapTap: _approve,
            ),
            ConfirmButton(
              iconData: Icons.close,
              text: "Batal ",
              tapTap: _reject,
              color: Colors.redAccent,
            )
          ],
        ),
      ),
    );
  }

  Widget buildBottomApproved(ViolData data) {
    return Container(
      // height: 50,
      color: TColor.primary.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.double_arrow_sharp,
              color: Colors.white,
            ),
            horizontalSpaceRegular,
            Flexible(
              child: Text(
                "DISETUJUI OLEH ${data.approvedBy}",
                style: const TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            horizontalSpaceTiny,
            const Icon(
              Icons.double_arrow_sharp,
              color: Colors.white,
            ),
            horizontalSpaceRegular,
            const Flexible(
              child: Text(
                "EMAIL DIKIRIM",
                style: TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildBottomDraft() {
    return Container(
      // height: 60,
      color: Colors.deepOrange.shade400.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.drafts,
              color: Colors.white,
            ),
            horizontalSpaceRegular,
            const Expanded(
              child: Text(
                "DRAFT\nHarap lengkapi dokumen sebelum ke proses selanjutnya",
                style: TextStyle(color: Colors.white, fontSize: 12),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
            ConfirmButton(
              iconData: Icons.send,
              text: "Kirim ",
              tapTap: _ready,
              color: Colors.blue.shade400,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPhotoList(ViolData data) {
    return SizedBox(
      height: 150,
      child: DisableOverScrollGlow(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: data.images.length + 1,
          itemBuilder: (BuildContext ctx, int index) {
            if (index == data.images.length) {
              return (data.approvedAt > 0)
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: GestureDetector(
                        onTap: () {
                          _getImageAndUpload(
                              context: context,
                              source: ImageSource.camera,
                              id: data.id);
                        },
                        onLongPress: () {
                          _getImageAndUpload(
                              context: context,
                              source: ImageSource.gallery,
                              id: data.id);
                        },
                        child: const Icon(
                          Icons.add_circle_outline,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ));
            }
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: GestureDetector(
                onLongPress: () async {
                  if (data.state == 2) {
                    return;
                  }
                  final bool? confirmed = await confirmDialog(
                      context,
                      "Menghapus gambar",
                      "Apakah yakin ingin menghapus gambar ini ?");
                  if (confirmed != null && confirmed) {
                    await _deleteImage(data.images[index]);
                  }
                },
                child: CachedImage(
                  urlPath: "${ConstUrl.baseUrl}${data.images[index]}",
                  width: 200,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget descText(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 8, top: 4),
      child: Text(
        text,
        style: const TextStyle(color: Colors.grey, fontSize: 16),
      ),
    );
  }
}

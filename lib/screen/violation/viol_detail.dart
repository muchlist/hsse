import 'package:flutter/material.dart';
import 'package:hsse/api/json_models/responses/viol_resp.dart';
import 'package:hsse/config/config.dart';
import 'package:hsse/providers/viol.dart';
import 'package:hsse/screen/components/cached_image.dart';
import 'package:hsse/screen/components/custom_button.dart';
import 'package:hsse/screen/components/disable_glow.dart';
import 'package:hsse/screen/components/flushbar.dart';
import 'package:hsse/screen/components/ui_helper.dart';
import 'package:hsse/utils/enum_state.dart';
import 'package:hsse/utils/utils.dart';
import 'package:provider/provider.dart';

var refreshKeyDetailScreen = GlobalKey<RefreshIndicatorState>();

class ViolDetailScreen extends StatelessWidget {
  const ViolDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Detail Pelanggaran"),
      ),
      body: ViolDetailScreenBody(),
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
    return Future.delayed(Duration.zero, () {
      _violProvider.getDetail().onError((error, _) {
        showToastError(context: context, message: error.toString());
      });
    });
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
      builder: (_, data, __) {
        var detail = data.violDetail;

        if (data.detailState == ViewState.busy) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Stack(
          children: [
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
                        children: [
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
                          ListPhoto(detail: detail),
                          SizedBox(height: 150)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(bottom: 0, left: 0, right: 0, child: buildBottomScreen())
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
          children: [
            const Text(
              "🚚  Nomor Lambung",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            descText(data.noIdentity),
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
          children: [
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
          children: [
            ConfirmButton(
                iconData: Icons.check, text: "Setuju ", tapTap: () {}),
            ConfirmButton(
              iconData: Icons.close,
              text: "Batal ",
              tapTap: () {},
              color: Colors.redAccent,
            )
          ],
        ),
      ),
    );
  }

  Padding descText(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 8, top: 4),
      child: Text(
        text,
        style: const TextStyle(color: Colors.grey, fontSize: 16),
      ),
    );
  }
}

class ListPhoto extends StatelessWidget {
  const ListPhoto({
    Key? key,
    required this.detail,
  }) : super(key: key);

  final ViolData detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: DisableOverScrollGlow(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: detail.images.length + 1,
          itemBuilder: (ctx, index) {
            if (index == detail.images.length) {
              return (detail.approvedAt > 0)
                  ? SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.add_circle_outline,
                            size: 40,
                            color: Colors.grey,
                          )),
                    );
            }
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: CachedImage(
                urlPath: "${ConstUrl.baseUrl}${detail.images[index]}",
                width: 200,
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hsse/api/json_models/responses/truck_resp.dart';
import 'package:hsse/providers/truck.dart';
import 'package:hsse/router/routes.dart';
import 'package:hsse/screen/components/custom_button.dart';
import 'package:hsse/screen/components/disable_glow.dart';
import 'package:hsse/screen/components/flushbar.dart';
import 'package:hsse/screen/components/ui_helper.dart';
import 'package:hsse/singleton/shared_pref.dart';
import 'package:hsse/utils/enum_state.dart';
import 'package:hsse/utils/utils.dart';
import 'package:provider/provider.dart';

GlobalKey<RefreshIndicatorState> refreshKeyDetailScreen =
    GlobalKey<RefreshIndicatorState>();

class TruckDetailScreen extends StatelessWidget {
  const TruckDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Detail Truck"),
      ),
      body: const TruckDetailScreenBody(),
    );
  }
}

class TruckDetailScreenBody extends StatefulWidget {
  const TruckDetailScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  _TruckDetailScreenBodyState createState() => _TruckDetailScreenBodyState();
}

class _TruckDetailScreenBodyState extends State<TruckDetailScreenBody> {
  late TruckProvider _truckProvider;

  Future<void> _loadDetail() {
    return Future<void>.delayed(Duration.zero, () {
      _truckProvider.getDetail().onError((Object? error, _) {
        showToastError(context: context, message: error.toString());
      });
    });
  }

  @override
  void initState() {
    _truckProvider = context.read<TruckProvider>();
    _loadDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TruckProvider>(
      builder: (_, TruckProvider data, __) {
        final TruckData detail = data.truckDetail;

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
                          const Text("PELANGGARAN"),
                          verticalSpaceSmall,
                          buildMidScreen(detail),
                          verticalSpaceRegular,
                          if (SharedPrefs().getRoles().contains("HSSE")) //draft
                            Center(
                              child: HomeLikeButton(
                                  iconData: Icons.edit,
                                  text: "Edit ",
                                  color: Colors.deepOrange.shade300,
                                  tapTap: () {
                                    data.truckID = data.truckDetail.id;
                                    Navigator.pushNamed(
                                        context, RouteGenerator.editTruck);
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
          ],
        );
      },
    );
  }

  Container buildUpperScreen(TruckData data) {
    final bool isHsse = SharedPrefs().getRoles().contains("HSSE");

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
              "🔹 Nomor Lambung",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            descText("${data.noIdentity} (${data.noPol})"),
            verticalSpaceSmall,
            const Text(
              "🔹 Pemilik",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            descText(data.owner),
            verticalSpaceSmall,
            const Text(
              "🔹 Tanda",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            descText(data.mark),
            verticalSpaceSmall,
            const Text(
              "🔹 Email",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            if (isHsse) descText(data.email) else descText("******"),
            verticalSpaceSmall,
            const Text(
              "🔹 HP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            if (isHsse) descText(data.hp) else descText("******"),
            verticalSpaceSmall,
          ],
        ),
      ),
    );
  }

  Container buildMidScreen(TruckData data) {
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
              "🔹 Total Pelanggaran",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            descText(data.score.toString()),
            verticalSpaceSmall,
            const Text(
              "🔹 Status Blokir",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            if (data.blocked)
              descText(
                  "Diblokir sampai ${data.blockEnd.getCompleteDateString()}")
            else
              descText("Nihil"),
            verticalSpaceSmall,
          ],
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

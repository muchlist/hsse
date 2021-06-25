import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hsse/providers/viol.dart';
import 'package:hsse/screen/components/empty_box.dart';
import 'package:hsse/screen/components/flushbar.dart';
import 'package:hsse/screen/components/ui_helper.dart';
import 'package:hsse/screen/components/violation_tile.dart';
import 'package:hsse/singleton/shared_pref.dart';
import 'package:hsse/utils/enum_state.dart';
import 'package:provider/provider.dart';

var refreshKeyHomeHsseScreen = GlobalKey<RefreshIndicatorState>();

class HomeHsseScreen extends StatefulWidget {
  const HomeHsseScreen({Key? key}) : super(key: key);

  @override
  _HomeHsseScreenState createState() => _HomeHsseScreenState();
}

class _HomeHsseScreenState extends State<HomeHsseScreen> {
  RichText buildHomeTitle(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: "Hi  ${SharedPrefs().getName()}\n",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          children: <TextSpan>[
            const TextSpan(
                text: "Selamat datang",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal))
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: buildHomeTitle(context),
        actions: [
          IconButton(
            icon: Icon(
              CupertinoIcons.person_crop_circle,
              size: 28,
            ),
            onPressed: () {},
          ),
          horizontalSpaceSmall
        ],
      ),
      body: HomeHsseBody(),
    );
  }
}

class HomeHsseBody extends StatefulWidget {
  const HomeHsseBody({
    Key? key,
  }) : super(key: key);

  @override
  _HomeHsseBodyState createState() => _HomeHsseBodyState();
}

class _HomeHsseBodyState extends State<HomeHsseBody> {
  late ViolProvider _violProvider;

  Future<void> _loadViol() {
    return Future.delayed(Duration.zero, () {
      _violProvider.findViol().onError((error, _) {
        showToastError(context: context, message: error.toString());
      });
    });
  }

  Widget buildGridView(ViolProvider data) {
    return StaggeredGridView.countBuilder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            data
              ..removeDetail()
              ..setID(data.violList[index].id);
            // Navigator.pushNamed(context, RouteGenerator.violDetail);
          },
          child: ViolationTile(data: data.violListReady[index])),
      staggeredTileBuilder: (_) => StaggeredTile.fit(1),
      itemCount: data.violListReady.length,
    );
  }

  @override
  void initState() {
    super.initState();
    _violProvider = context.read<ViolProvider>();
    _loadViol();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ViolProvider>(builder: (_, data, __) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: (data.violList.length != 0)
                  ? bulldHomeHsseBody(data)
                  : (data.state == ViewState.idle)
                      ? EmptyBox(loadTap: _loadViol)
                      : Center()),
          (data.state == ViewState.busy)
              ? Center(child: CircularProgressIndicator())
              : Center(),
        ],
      );
    });
  }

  Widget bulldHomeHsseBody(ViolProvider data) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (data.violListReady.length != 0)
              const Text(
                "Perlu persetujuan :",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            SizedBox(height: 10),
            buildGridView(data),
          ],
        ),
      ),
    );
  }
}

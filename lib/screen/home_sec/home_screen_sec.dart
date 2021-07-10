import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hsse/config/theme_color.dart';
import 'package:hsse/providers/viol.dart';
import 'package:hsse/router/routes.dart';
import 'package:hsse/screen/components/circle_menu.dart';
import 'package:hsse/screen/components/custom_button.dart';
import 'package:hsse/screen/components/disable_glow.dart';
import 'package:hsse/screen/components/empty_box.dart';
import 'package:hsse/screen/components/flushbar.dart';
import 'package:hsse/screen/components/ui_helper.dart';
import 'package:hsse/screen/components/violation_tile.dart';
import 'package:hsse/singleton/shared_pref.dart';
import 'package:hsse/utils/enum_state.dart';
import 'package:provider/provider.dart';

GlobalKey<RefreshIndicatorState> refreshKeyHomeSecurityScreen =
    GlobalKey<RefreshIndicatorState>();

class HomeSecurityScreen extends StatefulWidget {
  const HomeSecurityScreen({Key? key}) : super(key: key);

  @override
  _HomeSecurityScreenState createState() => _HomeSecurityScreenState();
}

class _HomeSecurityScreenState extends State<HomeSecurityScreen> {
  RichText buildHomeTitle(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: "Hi  ${SharedPrefs().getName()}\n",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          children: const <TextSpan>[
            TextSpan(
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
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              CupertinoIcons.person_crop_circle,
              size: 28,
            ),
            onPressed: () {},
          ),
          horizontalSpaceSmall
        ],
      ),
      body: const HomeSecurityBody(),
    );
  }
}

class HomeSecurityBody extends StatefulWidget {
  const HomeSecurityBody({
    Key? key,
  }) : super(key: key);

  @override
  _HomeSecurityBodyState createState() => _HomeSecurityBodyState();
}

class _HomeSecurityBodyState extends State<HomeSecurityBody> {
  late ViolProvider _violProvider;

  Future<void> _loadViol() {
    return Future<void>.delayed(Duration.zero, () {
      _violProvider.findViol().onError((Object? error, _) {
        showToastError(context: context, message: error.toString());
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _violProvider = context.read<ViolProvider>();
    _loadViol();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ViolProvider>(builder: (_, ViolProvider data, __) {
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: (data.violList.isNotEmpty)
                  ? bulldHomeSecurityBody(data)
                  : (data.state == ViewState.idle)
                      ? NoConnectionBox(loadTap: _loadViol)
                      : const Center()),
          if (data.state == ViewState.busy)
            const Center(child: CircularProgressIndicator())
          else
            const Center(),
        ],
      );
    });
  }

  Widget bulldHomeSecurityBody(ViolProvider data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: RefreshIndicator(
        key: refreshKeyHomeSecurityScreen,
        onRefresh: _loadViol,
        child: DisableOverScrollGlow(
          child: CustomScrollView(slivers: <Widget>[
            if (data.violListDraftnReady.isNotEmpty)
              buildSliverHeadText("Belum disetujui :"),
            if (data.violListDraftnReady.isNotEmpty) buildGridViewReady(data),
            buildSliverHeadText("Riwayat :"),
            buildGridViewApproved(data),
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: HomeLikeButton(
                            iconData: CupertinoIcons.plus,
                            text: "Tambah ",
                            tapTap: () => Navigator.pushNamed(
                                context, RouteGenerator.addViol)),
                      ),
                    ),
                    Positioned(
                      right: 15,
                      bottom: 0,
                      child: HomeLikeButton(
                          iconData: CupertinoIcons.rocket,
                          text: ". . .",
                          tapTap: () => Navigator.pushNamed(
                              context, RouteGenerator.history)),
                    ),
                  ],
                ),
              ),
            )),
            buildSliverHeadText("Menu lainnya:"),
            buildMenuList(),
          ]),
        ),
      ),
    );
  }

  Widget buildGridViewReady(ViolProvider data) {
    return SliverStaggeredGrid.countBuilder(
      crossAxisCount: (screenIsMobile(context)) ? 2 : 3,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () {
            data
              ..removeDetail()
              ..violID = data.violListDraftnReady[index].id;
            Navigator.pushNamed(context, RouteGenerator.detail);
          },
          child: ViolationTile(data: data.violListDraftnReady[index])),
      staggeredTileBuilder: (_) => const StaggeredTile.fit(1),
      itemCount: data.violListDraftnReady.length,
    );
  }

  Widget buildGridViewApproved(ViolProvider data) {
    return SliverStaggeredGrid.countBuilder(
      crossAxisCount: (screenIsMobile(context)) ? 2 : 3,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () {
            data
              ..removeDetail()
              ..violID = data.violListApproved[index].id;
            Navigator.pushNamed(context, RouteGenerator.detail);
          },
          child: ViolationTile(data: data.violListApproved[index])),
      staggeredTileBuilder: (_) => const StaggeredTile.fit(1),
      itemCount: data.violListApproved.length,
    );
  }

  Widget buildSliverHeadText(String text) {
    return SliverToBoxAdapter(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(text,
          style: const TextStyle(
            fontSize: 18,
          )),
    ));
  }

  Widget buildMenuList() {
    return SliverToBoxAdapter(
        child: SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, RouteGenerator.trucks),
                  child: CircleMenu(
                    color: TColor.primary,
                    iconData: Icons.commute_sharp,
                    tapTap: () {},
                    text: 'Truck',
                  ),
                ),
              ],
            )));
  }
}

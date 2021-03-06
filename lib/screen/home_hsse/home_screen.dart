import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hsse/config/theme_color.dart';
import 'package:hsse/providers/auth.dart';
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

GlobalKey<RefreshIndicatorState> refreshKeyHomeHsseScreen =
    GlobalKey<RefreshIndicatorState>();

class HomeHsseScreen extends StatefulWidget {
  const HomeHsseScreen({Key? key}) : super(key: key);

  @override
  _HomeHsseScreenState createState() => _HomeHsseScreenState();
}

class _HomeHsseScreenState extends State<HomeHsseScreen> {
  late FirebaseMessaging messaging;

  Future<bool?> _logoutConfirm(BuildContext context) {
    return showDialog<bool?>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Konfirmasi logout"),
            content: const Text(
                "Apakah anda yakin ingin ingin logout? salah pencet? maaf karena kami meletakkan tombol logout didekat tombol pencarian."),
            actions: <Widget>[
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).accentColor),
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("Jangan Logout")),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("Logout"))
            ],
          );
        });
  }

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
  void initState() {
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((String? value) async {
      final String? firebaseTokenSaved = SharedPrefs().getFireToken();
      if (value != firebaseTokenSaved) {
        if (value != null) {
          final bool success =
              await context.read<AuthProvider>().sendFCMToken(value);
          if (success) {
            await SharedPrefs().setFireToken(value);
          }
        }
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        showToastWarning(
          context: context,
          message: message.notification?.body ?? "",
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // notifikasi di klik
    });

    super.initState();
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
              onPressed: () async {
                final bool? logout = await _logoutConfirm(context);
                if (logout != null && logout) {
                  await SharedPrefs().setToken("");
                  await Navigator.pushNamedAndRemoveUntil(context,
                      RouteGenerator.login, (Route<dynamic> route) => false);
                }
              }),
          horizontalSpaceSmall
        ],
      ),
      body: const HomeHsseBody(),
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
                  ? bulldHomeHsseBody(data)
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

  Widget bulldHomeHsseBody(ViolProvider data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: RefreshIndicator(
        key: refreshKeyHomeHsseScreen,
        onRefresh: _loadViol,
        child: DisableOverScrollGlow(
          child: CustomScrollView(slivers: <Widget>[
            if (data.violListReady.isNotEmpty)
              buildSliverHeadText("Perlu persetujuan :"),
            if (data.violListReady.isNotEmpty) buildGridViewReady(data),
            buildSliverHeadText("Riwayat :"),
            buildGridViewApproved(data),
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Center(
                child: HomeLikeButton(
                    iconData: CupertinoIcons.rocket,
                    text: "Lihat semua",
                    tapTap: () =>
                        Navigator.pushNamed(context, RouteGenerator.history)),
              ),
            )),
            buildSliverHeadText("Menu Master :"),
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
              ..violID = data.violListReady[index].id;
            Navigator.pushNamed(context, RouteGenerator.detail);
          },
          child: ViolationTile(data: data.violListReady[index])),
      staggeredTileBuilder: (_) => const StaggeredTile.fit(1),
      itemCount: data.violListReady.length,
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
                GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, RouteGenerator.rules),
                  child: CircleMenu(
                    tapTap: () {},
                    color: TColor.primary,
                    iconData: Icons.book,
                    text: 'Rules',
                  ),
                ),
              ],
            )));
  }
}

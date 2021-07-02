import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hsse/providers/viol.dart';
import 'package:hsse/router/routes.dart';
import 'package:hsse/screen/components/flushbar.dart';
import 'package:hsse/screen/components/ui_helper.dart';
import 'package:hsse/screen/components/violation_tile.dart';
import 'package:hsse/search/viol_search.dart';
import 'package:provider/provider.dart';

GlobalKey<RefreshIndicatorState> refreshKeyHistoryScreen =
    GlobalKey<RefreshIndicatorState>();

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Riwayat Pelanggaran"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              CupertinoIcons.search,
              size: 28,
            ),
            onPressed: () async {
              final String? searchResult = await showSearch(
                context: context,
                delegate: ViolSearchDelegate(),
              );
              if (searchResult != null && searchResult != "") {
                context.read<ViolProvider>()
                  ..removeDetail()
                  ..violID = searchResult;
                await Navigator.pushNamed(context, RouteGenerator.detail);
              }
            },
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.decrease_indent,
              size: 28,
            ),
          ),
          horizontalSpaceSmall
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, RouteGenerator.addViol);
          },
          label: const Text("Tambah")),
      body: const HistoryBody(),
    );
  }
}

class HistoryBody extends StatelessWidget {
  const HistoryBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ViolProvider>(builder: (_, ViolProvider data, __) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: RefreshIndicator(
          key: refreshKeyHistoryScreen,
          onRefresh: () {
            return Future<void>.delayed(Duration.zero, () {
              data.findViol().onError((Object? error, _) {
                showToastError(context: context, message: error.toString());
              });
            });
          },
          child: StaggeredGridView.countBuilder(
            crossAxisCount: (screenIsMobile(context)) ? 2 : 3,
            itemBuilder: (BuildContext context, int index) => GestureDetector(
                onTap: () {
                  data
                    ..removeDetail()
                    ..violID = data.violList[index].id;
                  Navigator.pushNamed(context, RouteGenerator.detail);
                },
                child: ViolationTile(data: data.violList[index])),
            staggeredTileBuilder: (_) => const StaggeredTile.fit(1),
            itemCount: data.violList.length,
          ),
        ),
      );
    });
  }
}

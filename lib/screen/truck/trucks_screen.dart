import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hsse/providers/truck.dart';
import 'package:hsse/router/routes.dart';
import 'package:hsse/screen/components/flushbar.dart';
import 'package:hsse/screen/components/truck_list_tile.dart';
import 'package:hsse/screen/components/ui_helper.dart';
import 'package:hsse/search/truck_search2.dart';
import 'package:provider/provider.dart';

GlobalKey<RefreshIndicatorState> refreshKeyTruckScreen =
    GlobalKey<RefreshIndicatorState>();

class TruckScreen extends StatelessWidget {
  const TruckScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Truck"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              CupertinoIcons.search,
              size: 28,
            ),
            onPressed: () async {
              final String? searchResult = await showSearch<String?>(
                context: context,
                delegate: TruckSearchDelegate2(),
              );
              if (searchResult != null && searchResult != "") {
                context.read<TruckProvider>()
                  ..removeDetail()
                  ..truckID = searchResult;
                await Navigator.pushNamed(context, RouteGenerator.truckDetail);
              }
            },
          ),
          horizontalSpaceSmall
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          onPressed: () {
            // Navigator.pushNamed(context, RouteGenerator.addTruck);
          },
          label: const Text("Tambah")),
      body: const TruckBody(),
    );
  }
}

class TruckBody extends StatefulWidget {
  const TruckBody({
    Key? key,
  }) : super(key: key);

  @override
  _TruckBodyState createState() => _TruckBodyState();
}

class _TruckBodyState extends State<TruckBody> {
  Future<void> _loadTruck() {
    return Future<void>.delayed(Duration.zero, () {
      context.read<TruckProvider>().findTruck().onError((Object? error, _) {
        showToastError(context: context, message: error.toString());
      });
    });
  }

  @override
  void initState() {
    _loadTruck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TruckProvider>(builder: (_, TruckProvider data, __) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: RefreshIndicator(
          key: refreshKeyTruckScreen,
          onRefresh: _loadTruck,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    data
                      ..removeDetail()
                      ..truckID = data.truckList[index].id;
                    Navigator.pushNamed(context, RouteGenerator.truckDetail);
                  },
                  child: TruckListTile(
                    data: data.truckList[index],
                  ));
            },
            itemCount: data.truckList.length,
          ),
        ),
      );
    });
  }
}

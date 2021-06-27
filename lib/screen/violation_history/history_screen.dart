import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hsse/providers/viol.dart';
import 'package:hsse/screen/components/ui_helper.dart';
import 'package:hsse/screen/components/violation_tile.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Riwayat Pelanggaran"),
        actions: [
          IconButton(
            icon: Icon(
              CupertinoIcons.search,
              size: 28,
            ),
            onPressed: () async {
              // final searchResult = await showSearch(
              //   context: context,
              //   delegate: ComputerSearchDelegate(),
              // );
              // if (searchResult != null) {
              //   _computerProvider
              //     ..removeDetail()
              //     ..setComputerID(searchResult);
              //   await Navigator.pushNamed(
              //       context, RouteGenerator.computerDetail);
              // }
            },
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.decrease_indent,
              size: 28,
            ),
          ),
          horizontalSpaceSmall
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          onPressed: () {
            // Navigator.pushNamed(context, RouteGenerator.computerAdd);
          },
          label: Text("Tambah")),
      body: HistoryBody(),
    );
  }
}

class HistoryBody extends StatelessWidget {
  const HistoryBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ViolProvider>(builder: (_, data, __) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: StaggeredGridView.countBuilder(
          // shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: (screenIsMobile(context)) ? 2 : 3,
          itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                data
                  ..removeDetail()
                  ..setID(data.violList[index].id);
                // Navigator.pushNamed(context, RouteGenerator.violDetail);
              },
              child: ViolationTile(data: data.violList[index])),
          staggeredTileBuilder: (_) => StaggeredTile.fit(1),
          itemCount: data.violList.length,
        ),
      );
    });
  }
}

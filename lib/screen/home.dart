import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hsse/providers/violation.dart';
import 'package:hsse/router/routes.dart';
import 'package:hsse/screen/components/violation_tile.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              CupertinoIcons.search,
              size: 28,
            ),
            onPressed: () {
              // showSearch(
              //   context: context,
              //   delegate: SearchDelegate(),
              // );
            },
          ),
          const SizedBox(
            width: 5,
          ),
          IconButton(
              icon: Icon(
                CupertinoIcons.person_solid,
                size: 28,
              ),
              onPressed: () {}),
          const SizedBox(
            width: 5,
          ),
        ],
        automaticallyImplyLeading: false,
        elevation: 0,
        title: buildHomeTitle(context),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.read<ViolationProvider>().addDummyData(),
        label: const Text("Tambah Laporan"),
        icon: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "DAFTAR PELANGGARAN :",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              buildGridView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGridView() {
    return Consumer<ViolationProvider>(builder: (_, data, __) {
      return StaggeredGridView.countBuilder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              context.read<ViolationProvider>().setDetail(index);
              Navigator.pushNamed(
                context,
                RouteGenerator.detail,
              );
            },
            child: ViolationTile(data: data.violations[index])),
        staggeredTileBuilder: (_) => StaggeredTile.fit(1),
        itemCount: data.violations.length,
      );
    });
  }

  RichText buildHomeTitle(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: "Hi MUCHLIS\n",
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
}

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hsse/providers/viol.dart';
import 'package:hsse/router/routes.dart';
import 'package:hsse/screen/components/flushbar.dart';
import 'package:hsse/screen/components/ui_helper.dart';
import 'package:hsse/screen/components/violation_tile.dart';
import 'package:provider/provider.dart';

class ViolSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(Object context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Center(
            child: Text(
              'Pencarian harus lebih dari 3 karakter.',
            ),
          )
        ],
      );
    }

    Future.delayed(Duration.zero, () {
      context.read<ViolProvider>().searchViol(query).onError((error, _) {
        if (error != null) {
          showToastError(context: context, message: error.toString());
        }
      });
    });

    return Consumer<ViolProvider>(
      builder: (_, data, __) {
        return (data.violListSearch.length == 0)
            ? Center(
                child: Text(
                  "$query tidak ditemukan...",
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: StaggeredGridView.countBuilder(
                    crossAxisCount: (screenIsMobile(context)) ? 2 : 3,
                    itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          data
                            ..removeDetail()
                            ..violID = data.violListSearch[index].id;
                          Navigator.pushNamed(context, RouteGenerator.detail);
                        },
                        child: ViolationTile(data: data.violListSearch[index])),
                    staggeredTileBuilder: (_) => StaggeredTile.fit(1),
                    itemCount: data.violListSearch.length),
              );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Center(
            child: Text(
              'Pencarian harus lebih dari 3 karakter.',
            ),
          )
        ],
      );
    }

    Future.delayed(Duration.zero, () {
      context.read<ViolProvider>().searchViol(query).onError((error, _) {
        if (error != null) {
          showToastError(context: context, message: error.toString());
        }
      });
    });

    return Consumer<ViolProvider>(
      builder: (_, data, __) {
        return (data.violListSearch.length == 0)
            ? Center(
                child: Text(
                  "$query tidak ditemukan...",
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: StaggeredGridView.countBuilder(
                    crossAxisCount: (screenIsMobile(context)) ? 2 : 3,
                    itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          data
                            ..removeDetail()
                            ..violID = data.violListSearch[index].id;
                          Navigator.pushNamed(context, RouteGenerator.detail);
                        },
                        child: ViolationTile(data: data.violListSearch[index])),
                    staggeredTileBuilder: (_) => StaggeredTile.fit(1),
                    itemCount: data.violListSearch.length),
              );
      },
    );
  }
}

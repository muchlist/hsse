import 'package:flutter/material.dart';
import 'package:hsse/providers/truck.dart';
import 'package:hsse/screen/components/flushbar.dart';
import 'package:hsse/screen/components/truck_list_tile.dart';
import 'package:provider/provider.dart';

class TruckSearchDelegate2 extends SearchDelegate<String?> {
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

    Future<void>.delayed(Duration.zero, () {
      context
          .read<TruckProvider>()
          .searchTruck(query)
          .onError((Object? error, _) {
        if (error != null) {
          showToastError(context: context, message: error.toString());
        }
      });
    });

    return Consumer<TruckProvider>(
      builder: (_, TruckProvider data, __) {
        return (data.truckSearchList.isEmpty)
            ? Center(
                child: Text(
                  "$query tidak ditemukan...",
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                    itemCount: data.truckSearchList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () =>
                              close(context, data.truckSearchList[index].id),
                          child:
                              TruckListTile(data: data.truckSearchList[index]));
                    }),
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

    Future<void>.delayed(Duration.zero, () {
      context
          .read<TruckProvider>()
          .searchTruck(query)
          .onError((Object? error, _) {
        if (error != null) {
          showToastError(context: context, message: error.toString());
        }
      });
    });

    return Consumer<TruckProvider>(
      builder: (_, TruckProvider data, __) {
        return (data.truckSearchList.isEmpty)
            ? Center(
                child: Text(
                  "$query tidak ditemukan...",
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                    itemCount: data.truckSearchList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () =>
                              close(context, data.truckSearchList[index].id),
                          child:
                              TruckListTile(data: data.truckSearchList[index]));
                    }),
              );
      },
    );
  }
}

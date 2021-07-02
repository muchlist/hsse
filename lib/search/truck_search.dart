import 'package:flutter/material.dart';
import 'package:hsse/providers/truck.dart';
import 'package:hsse/screen/components/flushbar.dart';
import 'package:hsse/screen/components/truck_suggest_tile.dart';
import 'package:provider/provider.dart';

class TruckSearchDelegate extends SearchDelegate<String?> {
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
      context.read<TruckProvider>().searchTruck(query).onError((error, _) {
        if (error != null) {
          showToastError(context: context, message: error.toString());
        }
      });
    });

    return Consumer<TruckProvider>(
      builder: (_, data, __) {
        return (data.truckSearchList.length == 0)
            ? Center(
                child: Text(
                  "$query tidak ditemukan...",
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                    itemCount: data.truckSearchList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () => close(
                              context, data.truckSearchList[index].noIdentity),
                          child: Card(
                            child: TruckSuggestTile(
                                data: data.truckSearchList[index]),
                          ));
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

    Future.delayed(Duration.zero, () {
      context.read<TruckProvider>().searchTruck(query).onError((error, _) {
        if (error != null) {
          showToastError(context: context, message: error.toString());
        }
      });
    });

    return Consumer<TruckProvider>(
      builder: (_, data, __) {
        return (data.truckSearchList.length == 0)
            ? Center(
                child: Text(
                  "$query tidak ditemukan...",
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                    itemCount: data.truckSearchList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () => close(
                              context, data.truckSearchList[index].noIdentity),
                          child: Card(
                            child: TruckSuggestTile(
                                data: data.truckSearchList[index]),
                          ));
                    }),
              );
      },
    );
  }
}

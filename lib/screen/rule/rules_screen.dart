import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hsse/config/config.dart';
import 'package:hsse/providers/rules.dart';
import 'package:hsse/router/routes.dart';
import 'package:hsse/screen/components/flushbar.dart';
import 'package:hsse/utils/utils.dart';
import 'package:provider/provider.dart';

GlobalKey<RefreshIndicatorState> refreshKeyRulesScreen =
    GlobalKey<RefreshIndicatorState>();

class RulesScreen extends StatelessWidget {
  const RulesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Aturan"),
      ),
      floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, RouteGenerator.addRules);
          },
          label: const Text("Tambah")),
      body: const RulesBody(),
    );
  }
}

class RulesBody extends StatefulWidget {
  const RulesBody({
    Key? key,
  }) : super(key: key);

  @override
  _RulesBodyState createState() => _RulesBodyState();
}

class _RulesBodyState extends State<RulesBody> {
  Future<void> _loadRules() {
    return Future<void>.delayed(Duration.zero, () {
      context.read<RulesProvider>().findRules().onError((Object? error, _) {
        showToastError(context: context, message: error.toString());
      });
    });
  }

  @override
  void initState() {
    _loadRules();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RulesProvider>(builder: (_, RulesProvider data, __) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: RefreshIndicator(
          key: refreshKeyRulesScreen,
          onRefresh: _loadRules,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              final String dayBlock =
                  data.rulesList[index].blockTime.toDurationDay();
              return GestureDetector(
                onTap: () {
                  data
                    ..removeDetail()
                    ..rulesID = data.rulesList[index].id;
                  Navigator.pushNamed(context, RouteGenerator.editRules);
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: TColor.secondaryBackground,
                        child: Text(data.rulesList[index].score.toString()),
                      ),
                      title:
                          Text("Pelanggaran ke ${data.rulesList[index].score}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(data.rulesList[index].description),
                          if (dayBlock != "0 hari")
                            Text("Blokir selama $dayBlock"),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: data.rulesList.length,
          ),
        ),
      );
    });
  }
}

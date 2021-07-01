import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hsse/providers/rules.dart';
import 'package:hsse/screen/components/flushbar.dart';
import 'package:hsse/utils/utils.dart';
import 'package:provider/provider.dart';

var refreshKeyRulesScreen = GlobalKey<RefreshIndicatorState>();

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
          icon: Icon(Icons.add),
          onPressed: () {
            // Navigator.pushNamed(context, RouteGenerator.computerAdd);
          },
          label: Text("Tambah")),
      body: RulesBody(),
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
    return Future.delayed(Duration.zero, () {
      context.read<RulesProvider>().findRules().onError((error, _) {
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
    return Consumer<RulesProvider>(builder: (_, data, __) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: RefreshIndicator(
          key: refreshKeyRulesScreen,
          onRefresh: _loadRules,
          child: ListView.builder(
            itemBuilder: (context, index) {
              final dayBlock = data.rulesList[index].blockTime.toDurationDay();
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ListTile(
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
              );
            },
            itemCount: data.rulesList.length,
          ),
        ),
      );
    });
  }
}

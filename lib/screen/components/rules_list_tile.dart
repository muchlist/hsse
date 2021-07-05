import 'package:flutter/material.dart';
import 'package:hsse/api/json_models/responses/rules_list_resp.dart';
import 'package:hsse/config/theme_color.dart';
import 'package:hsse/utils/utils.dart';

class RulesListTile extends StatelessWidget {
  const RulesListTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  final RulesMinData data;

  @override
  Widget build(BuildContext context) {
    final String dayBlock = data.blockTime.toDurationDay();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: TColor.secondaryBackground,
            child: Text(data.score.toString()),
          ),
          title: Text("Pelanggaran ke ${data.score}"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(data.description),
              if (dayBlock != "0 hari")
                Container(
                    decoration: BoxDecoration(
                        color: Colors.deepOrange.shade100,
                        borderRadius: BorderRadius.circular(2)),
                    child: Text(" Blokir selama $dayBlock ")),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hsse/api/json_models/responses/truck_list_resp.dart';

class TruckListTile extends StatelessWidget {
  const TruckListTile({Key? key, required this.data}) : super(key: key);
  final TruckMinData data;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text.rich(TextSpan(children: <InlineSpan>[
            WidgetSpan(
                child: Container(
              decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(5)),
              child: Text(" ${data.noIdentity} "),
            )),
            TextSpan(
              text: " - ${data.noPol}",
            ),
          ])),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(data.owner),
              Text("Total pelanggaran : ${data.score}")
            ],
          ),
          trailing: (data.blocked)
              ? const Icon(
                  Icons.block,
                  color: Colors.red,
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}

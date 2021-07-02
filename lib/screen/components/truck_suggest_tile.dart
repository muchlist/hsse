import 'package:flutter/material.dart';
import 'package:hsse/api/json_models/responses/truck_list_resp.dart';

class TruckSuggestTile extends StatelessWidget {
  final TruckMinData data;

  const TruckSuggestTile({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${data.noIdentity} - ${data.noPol}'),
      subtitle: Text("Pemilik : ${data.owner}"),
    );
  }
}

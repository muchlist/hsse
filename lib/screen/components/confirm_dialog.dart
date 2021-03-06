import 'package:flutter/material.dart';

Future<bool?> confirmDialog(BuildContext context, String title, String desc) {
  return showDialog<bool?>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(desc),
          actions: <Widget>[
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).accentColor),
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Tidak")),
            TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Ya"))
          ],
        );
      });
}

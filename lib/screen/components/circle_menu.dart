import 'package:flutter/material.dart';

class CircleMenu extends StatelessWidget {
  const CircleMenu({
    Key? key,
    required this.iconData,
    required this.text,
    required this.tapTap,
    required this.color,
  }) : super(key: key);

  final IconData iconData;
  final String text;
  final GestureTapCallback tapTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Container(
            width: 70,
            height: 70,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            child: Icon(
              iconData,
              size: 50,
              color: Colors.white,
            ),
          ),
          Text(
            text,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

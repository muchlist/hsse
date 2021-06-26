import 'package:flutter/material.dart';

class CircleMenu extends StatelessWidget {
  final IconData iconData;
  final String text;
  final GestureTapCallback tapTap;
  final Color color;

  const CircleMenu({
    Key? key,
    required this.iconData,
    required this.text,
    required this.tapTap,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            padding: EdgeInsets.all(8),
            child: Icon(
              iconData,
              size: 50,
              color: Colors.white,
            ),
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
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

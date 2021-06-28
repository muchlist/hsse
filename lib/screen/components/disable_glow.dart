import 'package:flutter/material.dart';

class DisableOverScrollGlow extends StatelessWidget {
  final Widget child;

  DisableOverScrollGlow({required this.child});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowGlow();
          return false;
        },
        child: child);
  }
}

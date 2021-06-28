import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyBox extends StatelessWidget {
  final GestureTapCallback loadTap;

  const EmptyBox({required this.loadTap});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
      onTap: loadTap,
      child: SizedBox(
          width: 200,
          height: 200,
          child: Lottie.asset('assets/lottie/629-empty-box.json')),
    ));
  }
}

class NoConnectionBox extends StatelessWidget {
  final GestureTapCallback loadTap;

  const NoConnectionBox({required this.loadTap});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
      onTap: loadTap,
      child: SizedBox(
          width: 300,
          height: 300,
          child: Lottie.asset('assets/lottie/41993-no-wi-fi.json')),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:hsse/config/config.dart';

class LoginButton extends StatelessWidget {
  final String title;
  final GestureTapCallback onPress;
  final bool disabled;

  LoginButton(
      {required this.title, required this.onPress, this.disabled = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      width: double.infinity,
      child: ElevatedButton(
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: !disabled ? onPress : null,
        style: ElevatedButton.styleFrom(
            primary: !disabled ? Theme.of(context).accentColor : Colors.grey,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            padding: const EdgeInsets.all(10.0)),
      ),
    );
  }
}

class HomeLikeButton extends StatelessWidget {
  final IconData iconData;
  final String text;
  final GestureTapCallback tapTap;
  final Color color;

  const HomeLikeButton(
      {required this.iconData,
      required this.text,
      required this.tapTap,
      this.color = TColor.primary});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(24)),
        child: Text.rich(TextSpan(children: [
          WidgetSpan(
              child: Icon(
            iconData,
            size: 21,
            color: Colors.white,
          )),
          TextSpan(
              text: " $text",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500)),
        ])),
      ),
    );
  }
}

class ConfirmButton extends StatelessWidget {
  final IconData iconData;
  final String text;
  final GestureTapCallback tapTap;
  final Color color;

  const ConfirmButton(
      {required this.iconData,
      required this.text,
      required this.tapTap,
      this.color = TColor.primary});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
        child: Text.rich(TextSpan(children: [
          WidgetSpan(
              child: Icon(
            iconData,
            size: 21,
            color: Colors.white,
          )),
          TextSpan(
              text: " $text",
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500)),
        ])),
      ),
    );
  }
}

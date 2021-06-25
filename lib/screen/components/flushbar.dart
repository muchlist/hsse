import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hsse/config/config.dart';

Flushbar showToastError(
    {required BuildContext context,
    required String message,
    bool onTop = true}) {
  return Flushbar(
    message: message,
    duration: Duration(seconds: 5),
    backgroundColor: Colors.red.shade300,
    flushbarPosition: onTop ? FlushbarPosition.TOP : FlushbarPosition.BOTTOM,
    flushbarStyle: FlushbarStyle.GROUNDED,
  )..show(context);
}

Flushbar showToastSuccess(
    {required BuildContext context,
    required String message,
    bool onTop = true}) {
  return Flushbar(
    message: message,
    duration: Duration(seconds: 5),
    backgroundColor: TColor.primary,
    flushbarPosition: onTop ? FlushbarPosition.TOP : FlushbarPosition.BOTTOM,
    flushbarStyle: FlushbarStyle.GROUNDED,
  )..show(context);
}

Flushbar showToastWarning(
    {required BuildContext context,
    required String message,
    bool onTop = true}) {
  return Flushbar(
    message: message,
    duration: Duration(seconds: 5),
    backgroundColor: Colors.deepOrange.shade400,
    flushbarPosition: onTop ? FlushbarPosition.TOP : FlushbarPosition.BOTTOM,
    flushbarStyle: FlushbarStyle.GROUNDED,
  )..show(context);
}

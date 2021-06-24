import 'package:intl/intl.dart';

extension DateMYString on DateTime {
  String toDisplay() {
    return DateFormat("d MMM HH:mm").format(toLocal());
  }
}

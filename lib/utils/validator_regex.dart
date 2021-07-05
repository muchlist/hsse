class ValueValidator {
  ValueValidator();

  final RegExp _isEmail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  bool isEmail(String input) => _isEmail.hasMatch(input);
}

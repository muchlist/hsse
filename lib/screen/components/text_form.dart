import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({
    Key? key,
    this.minLines = 1,
    this.maxLines = 1,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.validator,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;
  final int minLines;
  final int maxLines;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      minLines: minLines,
      maxLines: maxLines,
      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.white,
        enabledBorder: InputBorder.none,
        border: InputBorder.none,
      ),
      controller: controller,
      validator: validator,
      keyboardType: textInputType,
    );
  }
}

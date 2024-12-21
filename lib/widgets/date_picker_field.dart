import 'package:flutter/material.dart';
import '../screens/login/component/text_field_container.dart';

class DatePickerField extends StatelessWidget {
  final String? hintText, labelText;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  const DatePickerField(
      {super.key, this.hintText, this.labelText, this.onTap, this.controller});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextFieldContainer(
        child: TextField(
      controller: controller,
      onTap: onTap,
      // textAlign: TextAlign.left,
      autofocus: true,
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.labelMedium,
        border: InputBorder.none,
        // filled: true,
        // contentPadding: EdgeInsets.only(bottom: size.height * 0.016),
      ),
    ));
  }
}

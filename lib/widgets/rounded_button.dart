import 'package:flutter/material.dart';
import 'package:quiz_app/constant.dart';

class RoundedButton extends StatelessWidget {
  final String? text;
  final VoidCallback press;
  final Color? btnColor, textColor;

  const RoundedButton({
    super.key,
    this.text,
    required this.press,
    this.textColor,
    this.btnColor,
  });

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      height: size.height * 0.08,
      width: size.width * 0.88,
      child: ElevatedButton(
        onPressed: press,
        style: ElevatedButton.styleFrom(
          backgroundColor: btnColor,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text!,
          style: TextStyle(color: textColor, fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class RoundedOutlineButton extends StatelessWidget {
  final String? textBtn;
  final VoidCallback? press;
  final String? icon;
  final double? margin;

  const RoundedOutlineButton({
    super.key,
    this.textBtn,
    this.press,
    this.icon,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      width: size.width * 0.88,
      height: size.height * 0.1,
      child: OutlinedButton(
        onPressed: press,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.06,
              child: Image.asset(
                icon!,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: margin!),
              child: Text(
                textBtn!,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

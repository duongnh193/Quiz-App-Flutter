// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:quiz_app/constant.dart';

class FormatDialog extends StatelessWidget {
  String? text;
  String? subtext;
  TextStyle styleText;
  TextStyle styleSubText;

  FormatDialog({
    super.key,
    this.text,
    this.subtext,
    required this.styleText,
    required this.styleSubText,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: kSecondaryColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text!, style: styleText
                // TextStyle(
                //   fontSize: 20.0,
                //   fontWeight: FontWeight.bold,
                // ),
                ),
            const SizedBox(height: 10.0),
            Text(subtext!, style: styleSubText
                // TextStyle(fontSize: 16.0),
                ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: 80,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                child: const Text("Retry"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

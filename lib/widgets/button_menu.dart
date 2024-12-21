// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../constant.dart';

class ButtonMenu extends StatelessWidget {
  String titleText;
  String subTitle;
  Icon icon;
  VoidCallback taptap;
  // double width;
  ButtonMenu({
    super.key,
    required this.titleText,
    required this.subTitle,
    required this.icon,
    required this.taptap,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: taptap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        margin: EdgeInsets.only(
            right: size.width * 0.08,
            left: size.width * 0.08,
            bottom: size.height * 0.023),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: icon,
            ),
            const Expanded(
              flex: 1,
              child: SizedBox(width: 18),
            ),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titleText,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    subTitle,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
                flex: 1,
                child: SizedBox(
                  width: 2,
                )),
            Container(
              child: const Icon(
                Icons.arrow_circle_right_sharp,
                color: kPrimaryColor,
                size: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

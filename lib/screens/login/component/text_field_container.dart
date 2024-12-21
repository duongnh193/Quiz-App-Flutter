import 'package:flutter/material.dart';

import '../../../constant.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.88,
      height: size.height * 0.065,
      padding: const EdgeInsets.only(top: 2, right: 20, left: 20),
      decoration: BoxDecoration(
          color: kSecondaryColor, borderRadius: BorderRadius.circular(8)),
      child: child,
    );
  }
}

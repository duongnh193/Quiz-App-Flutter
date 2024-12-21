// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class BackAppBar extends StatelessWidget implements PreferredSizeWidget {
  VoidCallback? press;
  BackAppBar({
    super.key,
    this.press,
  });
  @override
  Size get preferredSize => const Size.fromHeight(60.0);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: press,
        icon: const Icon(Icons.arrow_back),
        color: Colors.black,
      ),
      elevation: 0,
    );
  }
}

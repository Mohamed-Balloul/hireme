import 'package:hireme/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      leading: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: IconButton(
          onPressed: () {},
          icon: const Icon(
            size: 40,
            Icons.arrow_circle_left_outlined,
            color: AppColor.primaryColor,
          ),
        ),
      ),
    );
  }
}

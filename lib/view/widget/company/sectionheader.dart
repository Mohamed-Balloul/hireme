import 'package:flutter/material.dart';
import 'package:hireme/core/constant/color.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final void Function()? onSeeAllTap;
  const SectionHeader({super.key, required this.title, this.onSeeAllTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black87),
          ),
          // InkWell(
          //   onTap: onSeeAllTap,
          //   child: const Text(
          //     "عرض الكل",
          //     style: TextStyle(
          //         color: AppColor.primaryColor,
          //         fontWeight: FontWeight.bold,
          //         fontSize: 14),
          //   ),
          // ),
        ],
      ),
    );
  }
}

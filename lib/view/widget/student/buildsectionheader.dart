import 'package:flutter/material.dart';
import 'package:hireme/core/constant/color.dart';

class BuildSectionHeader extends StatelessWidget {
  final String title;
  final void Function()? onSeeAllTap;
  const BuildSectionHeader(
      {super.key, required this.title, required this.onSeeAllTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // النص الرئيسي
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),

          // زر عرض الكل
          InkWell(
            onTap: onSeeAllTap,
            child: const Text(
              "عرض الكل",
              style: TextStyle(
                  color: AppColor.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

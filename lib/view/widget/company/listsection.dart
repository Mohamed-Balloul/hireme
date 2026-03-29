import 'package:flutter/material.dart';
import 'package:hireme/core/constant/color.dart';

class ListSection extends StatelessWidget {
  final String title;
  final List<String>? items;
  const ListSection({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    if (items == null || items!.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15), // مسافة قبل العنوان
        Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColor.primaryColor), // لون العنوان
        ),
        const SizedBox(height: 8),
        ...items!.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 6), // تباعد بين العناصر
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // النقطة الملونة بدلاً من النص
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 6), // محاذاة النقطة مع السطر
                    child: CircleAvatar(
                        radius: 3,
                        backgroundColor:
                            AppColor.primaryColor.withOpacity(0.6)),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                          fontSize: 13, color: Colors.grey[800], height: 1.4),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

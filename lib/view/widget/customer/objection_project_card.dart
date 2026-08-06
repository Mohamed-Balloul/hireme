//------

import 'package:flutter/material.dart';
import 'package:hireme/data/model/eligible_objection_model.dart';

import 'package:hireme/core/constant/color.dart';

class ObjectionProjectCard extends StatelessWidget {
  final EligibleObjectionModel project; // تعديل نوع الموديل هنا
  final bool isSelected;
  final VoidCallback onTap;

  const ObjectionProjectCard({
    super.key,
    required this.project,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColor.primaryColor : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Row(
          children: [
            // أيقونة اختيار دائرية (Radio Style)
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      isSelected ? AppColor.primaryColor : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Center(
                      child: CircleAvatar(
                        radius: 5,
                        backgroundColor: AppColor.primaryColor,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 16),

            // تفاصيل الخدمة
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.projectTitle ??
                        "عنوان الخدمة غير محدد", // استدعاء حقل الموديل الجديد
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    // دمج اسم الطالب مع الوقت الفعلي والمنسق بأمان
                    "${project.studentName ?? "المنفذ"} - ${project.timeAgo ?? "منذ شهر"}",
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // أيقونة مستند الخدمة
            Icon(
              Icons.assignment_turned_in_outlined,
              color: isSelected ? AppColor.primaryColor : Colors.grey.shade400,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}

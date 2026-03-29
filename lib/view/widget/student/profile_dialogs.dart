import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/core/constant/color.dart';

class ProfileDialogs {
  // 1. ديالوغ اختيار الأوامر (تعديل أو حذف)
  static void showOptionsDialog({
    required String title,
    required String addLabel,
    required String deleteLabel,
    required VoidCallback onAdd,
    required VoidCallback onDelete,
  }) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDialogButton(
              label: addLabel,
              icon: Icons.photo_library_outlined,
              color: Colors.black!,
              onTap: () {
                Get.back();
                onAdd();
              },
            ),
            const SizedBox(height: 12),
            _buildDialogButton(
              label: deleteLabel,
              icon: Icons.delete_outline_rounded,
              color: Colors.black!,
              onTap: () {
                Get.back();
                onDelete();
              },
            ),
          ],
        ),
      ),
    );
  }

  // 2. ديالوغ التأكيد (هل أنت متأكد؟)
  static void showConfirmDialog({
    required String title,
    required VoidCallback onConfirm,
  }) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Icon(Icons.warning_amber_rounded,
            color: Colors.orange, size: 40),
        content: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("إلغاء", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              onConfirm();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[600],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text("تأكيد الحذف",
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ويجت داخلي لبناء أزرار الخيارات
  static Widget _buildDialogButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: color.withOpacity(0.3), width: 1.5),
          borderRadius: BorderRadius.circular(12),
          color: color.withOpacity(0.05),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                  color: color, fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

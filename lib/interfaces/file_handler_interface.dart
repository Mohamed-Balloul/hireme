import 'package:flutter/material.dart';

// هذا هو العقد المجرد
abstract class FileHandlerInterface {
  // دالة لحذف الملف
  void removeCvFile();

  // دالة لجلب الأيقونة
  Widget getFileIcon(String? extension);
}

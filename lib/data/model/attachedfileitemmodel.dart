import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AttachedFileItemModel {
  PlatformFile file; // الملف المختار
  TextEditingController descriptionController; // وصف الملف

  AttachedFileItemModel({
    required this.file,
    required this.descriptionController,
  });
}

import 'package:flutter/material.dart';
import 'package:hireme/core/constant/color.dart';

class BuildTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final int maxLines = 4;

  final TextInputType keyboardType;
  const BuildTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.icon,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        minLines: 1,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, size: 20, color: Colors.grey),
          labelStyle: const TextStyle(fontSize: 13, color: Colors.grey),
          floatingLabelStyle: const TextStyle(color: AppColor.primaryColor),
          filled: true,
          fillColor: const Color(0xFFFDFDFD),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColor.primaryColor)),
        ),
      ),
    );
  }
}

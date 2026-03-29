// --- دالة بناء العنصر الإحصائي (العمود الواحد) ---
import 'package:flutter/material.dart';

class BuildStateItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final MaterialColor color;
  const BuildStateItem({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // يأخذ ثلث المساحة بالتساوي
      child: Column(
        children: [
          // القيمة والأيقونة في السطر الأول
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: color[700]),
              const SizedBox(width: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: color[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6), // مسافة صغيرة

          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[500],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

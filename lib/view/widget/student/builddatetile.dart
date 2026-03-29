import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BuildDateTile extends StatelessWidget {
  final String label;
  final DateTime? date;
  final VoidCallback onTap;
  const BuildDateTile({
    super.key,
    required this.label,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        decoration: BoxDecoration(
          color: const Color(0xFFFDFDFD),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_month, size: 18, color: Colors.grey),
            const SizedBox(width: 8),
            Text(
              date == null ? label : DateFormat('yyyy/MM').format(date!),
              style: TextStyle(
                  fontSize: 12,
                  color: date == null ? Colors.grey : Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}

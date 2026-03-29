import 'package:flutter/material.dart';

class InfoItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final MaterialColor color;
  const InfoItem(
      {super.key, required this.icon, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 11, color: color[500]),
        const SizedBox(width: 3),
        Text(
          text,
          style: TextStyle(
              fontSize: 10, color: color[500], fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

// --- الفاصل الطويل ---
import 'package:flutter/material.dart';

class BuildSeparator extends StatelessWidget {
  const BuildSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 1,
      color: Colors.grey[300],
    );
  }
}

// --- Widget بناء كارد الخبرة المهنية ---
import 'dart:io';

import 'package:flutter/material.dart';

class BuildExperienceCard extends StatelessWidget {
  final Map<String, dynamic> exp;

  const BuildExperienceCard({super.key, required this.exp});

  @override
  Widget build(BuildContext context) {
    bool isFreelancer = exp['isFreelancer'];
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200), // Border رمادي فاتح
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. الصورة أو الأيقونة
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: (exp['logo'].isNotEmpty)
                  ? (exp['logo'].toString().startsWith('http')
                      ? Image.network(exp['logo'], fit: BoxFit.contain)
                      : Image.file(
                          File(exp['logo']),
                          fit: BoxFit.cover,
                        ))
                  : Icon(
                      isFreelancer ? Icons.laptop_mac : Icons.business,
                      color: Colors.grey[600],
                      size: 28,
                    ),
            ),
          ),
          const SizedBox(width: 15),

          // 2. النصوص (الاسم، التاريخ، المسمى الوظيفي)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      exp['companyName'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(
                        children: [
                          Text(
                            "${exp['startDate']}  -  ",
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[500],
                            ),
                          ),
                          Text(
                            "${exp['endDate']}",
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  exp['jobTitle'],
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

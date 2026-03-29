import 'package:flutter/material.dart';
import 'package:hireme/core/constant/color.dart';

class ApplicantCard extends StatelessWidget {
  final String applicantName;
  final String jobTitle;
  final String applicantImage;
  final String applyDate;
  final String expectedSalary;
  final bool hasCV;
  final bool hasPortfolio;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final VoidCallback onCvTap;
  final VoidCallback onPortfolioTap;

  const ApplicantCard({
    super.key,
    required this.applicantName,
    required this.jobTitle,
    required this.applicantImage,
    required this.applyDate,
    required this.expectedSalary,
    required this.hasCV,
    required this.hasPortfolio,
    required this.onAccept,
    required this.onReject,
    required this.onCvTap,
    required this.onPortfolioTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200), // إطار ناعم جداً
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // ================= الجزء العلوي: المعلومات الأساسية =================
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. الصورة الشخصية
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(applicantImage),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(color: Colors.grey.shade100, width: 2),
                  ),
                ),

                const SizedBox(width: 14),

                // 2. الاسم والمسمى وتاريخ التقديم
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        applicantName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        jobTitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // التاريخ
                      Row(
                        children: [
                          Icon(Icons.access_time,
                              size: 12, color: Colors.grey[400]),
                          const SizedBox(width: 4),
                          Text(
                            applyDate,
                            style: TextStyle(
                                fontSize: 11, color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // 3. الراتب (في كبسولة مميزة في الزاوية)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        expectedSalary,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: AppColor.primaryColor,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "متوقع",
                        style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // خط فاصل ناعم
          Divider(height: 1, thickness: 1, color: Colors.grey[100]),

          // ================= الجزء الأوسط: المرفقات =================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                if (hasCV)
                  Expanded(
                    child: _buildAttachmentChip(
                      icon: Icons.picture_as_pdf_outlined,
                      label: "السيرة الذاتية",
                      color: Colors.red,
                      onTap: onCvTap,
                    ),
                  ),

                if (hasCV && hasPortfolio) const SizedBox(width: 10),

                if (hasPortfolio)
                  Expanded(
                    child: _buildAttachmentChip(
                      icon: Icons.link,
                      label: "معرض الأعمال",
                      color: Colors.blue,
                      onTap: onPortfolioTap,
                    ),
                  ),

                // في حال عدم وجود مرفقات
                if (!hasCV && !hasPortfolio)
                  const Text("لا توجد مرفقات",
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),

          // ================= الجزء السفلي: أزرار القرار =================
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                // زر رفض (Outlined - ثانوي)
                Expanded(
                  child: OutlinedButton(
                    onPressed: onReject,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: Colors.red.shade200),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      foregroundColor: Colors.red,
                    ),
                    child: const Text("رفض الطلب"),
                  ),
                ),

                const SizedBox(width: 12),

                // زر قبول (Filled - أساسي)
                Expanded(
                  child: ElevatedButton(
                    onPressed: onAccept,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text("قبول للمقابلة"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ويدجت مساعدة لتصميم أزرار المرفقات بشكل "ملف" أنيق
  Widget _buildAttachmentChip({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05), // خلفية باهتة جداً حسب لون الأيقونة
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

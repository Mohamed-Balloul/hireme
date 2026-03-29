import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/company/incomingrequests_controller.dart';
import 'package:hireme/controller/customer/incomingrequeststocustomer_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/view/widget/company/buildmodernchip.dart';

class ApplicantCardModern extends StatelessWidget {
  final String image;
  final String applicantName;
  final int expectedSalary;
  final String jobLabel;
  const ApplicantCardModern({
    super.key,
    required this.image,
    required this.applicantName,
    required this.expectedSalary,
    required this.jobLabel,
  });

  @override
  Widget build(BuildContext context) {
    IncomingRequestsToCustomerControllerImp controller =
        Get.put(IncomingRequestsToCustomerControllerImp());

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // ================= 1. الهيدر (المعلومات الشخصية) =================
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // الصورة
              InkWell(
                onTap: () {
                  controller.goToStudentProfile(applicantName);
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade100),
                  ),
                  child: CircleAvatar(
                    radius: 26,
                    backgroundImage: NetworkImage(image),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // الاسم والتفاصيل
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.goToStudentProfile(applicantName);
                      },
                      child: Text(
                        applicantName,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2D3748),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      jobLabel,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF718096),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.access_time,
                            size: 12, color: Colors.grey[400]),
                        const SizedBox(width: 4),
                        Text(
                          "منذ ساعتين",
                          style:
                              TextStyle(fontSize: 11, color: Colors.grey[400]),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              // ============ التعديل هنا: قسم الراتب الجديد ============
              Container(
                // إزاحة للأسفل قليلاً (top: 5)
                margin: const EdgeInsets.only(top: 8),
                // حشوة داخلية للإطار
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  // لون خلفية أخضر فاتح جداً وشفاف
                  color: AppColor.primaryColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12), // حواف دائرية ناعمة
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "\$$expectedSalary",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800, // خط عريض للرقم
                        color: AppColor.primaryColor, // اللون الأخضر الأساسي
                      ),
                    ),
                    Text(
                      "متوقع",
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[600], // لون رمادي ناعم
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              // ========================================================
            ],
          ),

          const SizedBox(height: 20),

          // خط فاصل رفيع جداً
          Divider(color: Colors.grey[100], height: 1),
          const SizedBox(height: 15),

          // ================= 2. المرفقات =================
          Row(
            children: [
              BuildModernChip(
                icon: Icons.description_outlined,
                label: "السيرة الذاتية",
                color: const Color(0xFFE53E3E),
                onTap: () {},
              ),
              const SizedBox(width: 10),
              BuildModernChip(
                icon: Icons.link,
                label: "معرض الأعمال",
                color: const Color(0xFF3182CE),
                onTap: () {},
              ),
            ],
          ),

          const SizedBox(height: 20),

          // ================= 3. أزرار القرار =================
          Row(
            children: [
              // زر الرفض
              Expanded(
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    // foregroundColor: Colors.grey[600],
                    // غيرنا اللون من رمادي باهت إلى أحمر ناعم جداً أو رمادي غامق
                    foregroundColor: const Color(0xFFE53E3E),
                    // أو استخدم Colors.grey[800] إذا كنت لا تريد اللون الأحمر

                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    backgroundColor: Colors.grey[50],
                  ),
                  child: const Text("رفض",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                ),
              ),

              const SizedBox(width: 12),

              // زر القبول (حافظت على اللون الغامق لأنه أفخم، ويمكنك تغييره للأخضر إذا أردت)
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A202C),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("قبول للمقابلة",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

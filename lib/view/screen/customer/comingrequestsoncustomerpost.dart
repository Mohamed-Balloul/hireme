import 'package:flutter/material.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/datasource/static/static.dart';

class ComingRequestsOnCustomerPost extends StatelessWidget {
  const ComingRequestsOnCustomerPost({super.key});

  @override
  Widget build(BuildContext context) {
    // CompanyPostsDetailsControllerImp controller =
    //     Get.put(CompanyPostsDetailsControllerImp());
    return SafeArea(
      child: Scaffold(
        // لون رمادي فاتح جداً يميل للأزرق قليلاً (أحدث صيحات التصميم)
        // backgroundColor: const Color(0xFFF6F8FA),
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text(
            "الطلبات الواردة",
            style: TextStyle(),
          ),
          foregroundColor: Colors.white,
          centerTitle: true,
          backgroundColor: AppColor.primaryColor,
        ),
        body: Container(
          child: ListView.builder(
            itemCount: comingRequestsOnCustomerPostList.length,
            itemBuilder: (context, i) {
              // final CompanyPostModel selectedPost = companyPostsList[i];
              return Padding(
                padding: const EdgeInsets.all(15),
                child: Card(
                  color: Colors.white,
                  surfaceTintColor:
                      Colors.white, // لمنع تغير اللون عند السكرول في Material 3
                  elevation: 5, // ارتفاع بسيط
                  shadowColor:
                      Colors.black.withOpacity(0.1), // ظل أسود شفاف جداً وناعم
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),

                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //
// 1. رأس البطاقة (يوضع كأول عنصر في الـ Column)
                        Padding(
                          padding: const EdgeInsets.all(
                              16.0), // حشوة مريحة من كل الجهات
                          child: Row(
                            children: [
                              // --- الصورة (Avatar) ---
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(
                                      0.1), // خلفية خضراء باهتة جداً
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.person,
                                    size: 35, color: Colors.green),
                              ),

                              const SizedBox(width: 15),

                              // --- الاسم والتفاصيل ---
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start, // محاذاة لليمين
                                  children: [
                                    const Text(
                                      "مضر مضر",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "مطور تطبيقات Flutter",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[600]),
                                    ),
                                    const SizedBox(height: 5),
                                    // التاريخ مع أيقونة صغيرة
                                    Row(
                                      children: [
                                        Icon(Icons.access_time,
                                            size: 12, color: Colors.grey[400]),
                                        const SizedBox(width: 4),
                                        Text(
                                          "20/11/2025",
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.grey[400]),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              // --- السعر (على اليسار) ---
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors
                                      .grey[50], // خلفية رمادية فاتحة جداً
                                  borderRadius: BorderRadius.circular(12),
                                  border:
                                      Border.all(color: Colors.grey.shade200),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "\$500",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color:
                                            Colors.green[700], // أخضر غامق واضح
                                      ),
                                    ),
                                    Text(
                                      "متوقع",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey[500]),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

// خط فاصل خفيف جداً بين الرأس والمرفقات
                        Divider(
                            height: 1, thickness: 3, color: Colors.grey[100]),

                        // 2. جسم البطاقة: المرفقات والروابط (Chips)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (comingRequestsOnCustomerPostList[i]
                                      .isCvRequired! ||
                                  comingRequestsOnCustomerPostList[i]
                                      .isGitHubOrPortfolioRequired!)
                                const Text("المرفقات والروابط:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  if (comingRequestsOnCustomerPostList[i]
                                      .isCvRequired!)
                                    // زر فتح الـ CV
                                    Expanded(
                                      child: _buildActionChip(
                                        icon: Icons.picture_as_pdf,
                                        label: "السيرة الذاتية",
                                        color: Colors.red.shade50,
                                        iconColor: Colors.red,
                                        onTap: () {},
                                      ),
                                    ),
                                  const SizedBox(width: 10),
                                  if (comingRequestsOnCustomerPostList[i]
                                      .isGitHubOrPortfolioRequired!)
                                    // زر فتح المعرض
                                    Expanded(
                                      child: _buildActionChip(
                                        icon: Icons.link, // أو Icons.language
                                        label: "معرض الأعمال",
                                        color: Colors.blue.shade50,
                                        iconColor: Colors.blue,
                                        onTap: () {},
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              // تفاصيل إضافية
                              // Container(
                              //   width: double.infinity,
                              //   padding: const EdgeInsets.all(10),
                              //   decoration: BoxDecoration(
                              //     color: Colors.grey[50],
                              //     borderRadius: BorderRadius.circular(8),
                              //     border:
                              //         Border.all(color: Colors.grey.shade200),
                              //   ),
                              //   child: const Text(
                              //     "ملاحظة من الطالب: لدي خبرة سابقة في التعامل مع Firebase وأستطيع البدء فوراً.",
                              //     style: TextStyle(
                              //         fontSize: 12, color: Colors.black54),
                              //   ),
                              // ),
                            ],
                          ),
                        ),

                        Row(
                          children: [
                            // --- زر القبول (Elevated) ---
                            // جعلناه ممتلئاً باللون الأخضر لأنه الإجراء المفضل
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  // كود القبول هنا
                                },
                                icon: const Icon(Icons.check,
                                    size: 20, color: Colors.white),
                                label: const Text("قبول",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green, // لون الخلفية
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12), // ارتفاع الزر
                                  elevation:
                                      0, // إلغاء الظل ليكون التصميم مسطحاً وعصرياً
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            // --- زر الرفض (Outlined) ---
                            // جعلناه بإطار فقط لكي لا يكون مزعجاً للعين ولا ينافس زر القبول
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  // كود الرفض هنا
                                },
                                icon: const Icon(Icons.close, size: 20),
                                label: const Text("رفض",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor:
                                      Colors.red, // لون النص والأيقونة
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12), // ارتفاع الزر
                                  side: BorderSide(
                                      color: Colors.red
                                          .shade200), // لون الإطار فاتح قليلاً
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // حواف دائرية ناعمة
                                  ),
                                ),
                              ),
                            ),

                            // مسافة فراغ بين الزرين
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// ويدجت مساعدة للأزرار الصغيرة (Chips)
Widget _buildActionChip(
    {required IconData icon,
    required String label,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(8),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: iconColor),
          const SizedBox(width: 5),
          Text(label,
              style: TextStyle(
                  fontSize: 12, color: iconColor, fontWeight: FontWeight.w600)),
        ],
      ),
    ),
  );
}

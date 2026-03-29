import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/student/myorders_controller.dart';
import 'package:hireme/view/widget/student/profile_dialogs.dart';

class BuildModernRequestCard extends StatelessWidget {
  final int id;
  final String title;
  final String publisher;
  final String imageUrl;
  final String status;
  final Color statusColor;
  final String timeAgo;
  final bool isCompany;
  final IconData statusIconData;
  const BuildModernRequestCard({
    super.key,
    required this.id,
    required this.title,
    required this.publisher,
    required this.imageUrl,
    required this.status,
    required this.statusColor,
    required this.timeAgo,
    required this.isCompany,
    required this.statusIconData,
  });

  @override
  Widget build(BuildContext context) {
    // MyOrdersControllerImp controller = Get.put(MyOrdersControllerImp());
    MyOrdersControllerImp controller = Get.find<MyOrdersControllerImp>();
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. الصورة
          InkWell(
            onTap: () {
              isCompany
                  ? controller.goToCompanyProfile(publisher)
                  : controller.goToCustomerProfile(publisher);
            },
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade100),
                color: Colors.grey[50],
                image: imageUrl.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(imageUrl), fit: BoxFit.cover)
                    : null,
              ),
              child: imageUrl.isEmpty
                  ? Icon(
                      isCompany ? Icons.business : Icons.person,
                      color: Colors.grey[400],
                      size: 24,
                    )
                  : null,
            ),
          ),

          const SizedBox(width: 12),

          // 2. المحتوى
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // الصف العلوي: العنوان + سلة المهملات
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black87,
                          height: 1.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    // زر الحذف (سلة ممتلئة رمادية)
                    InkWell(
                      onTap: () {
                        ProfileDialogs.showConfirmDialog(
                          title:
                              "هل أنت متأكد أنك تريد حذف هذا الطلب بشكل نهائي؟",
                          onConfirm: () =>
                              controller.deleteOrder(id, isCompany),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4, bottom: 4),
                        child: Icon(
                          Icons.delete, // سلة ممتلئة (Filled)
                          size: 16,
                          color: Colors.grey[400], // لون رمادي فاتح كما طلبت
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 2),

                InkWell(
                  onTap: () {
                    isCompany
                        ? controller.goToCompanyProfile(publisher)
                        : controller.goToCustomerProfile(publisher);
                  },
                  child: Text(
                    publisher,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // 3. السطر السفلي (وقت + حالة بأيقونة زاهية)
                Row(
                  children: [
                    // الوقت
                    Text(
                      timeAgo,
                      style: TextStyle(color: Colors.grey[500], fontSize: 11),
                    ),

                    // فاصل عمودي
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: 1,
                      height: 12,
                      color: Colors.grey[300],
                    ),

                    // أيقونة الحالة (دائرة زاهية وأيقونة بيضاء)
                    Container(
                      padding:
                          const EdgeInsets.all(3), // حشوة صغيرة حول الأيقونة
                      decoration: BoxDecoration(
                        color:
                            statusColor, // اللون الزاهي (أخضر أو برتقالي) بدون شفافية
                        shape: BoxShape.circle,
                      ),
                      child: Icon(statusIconData,
                          size: 10, color: Colors.white // الأيقونة بيضاء
                          ),
                    ),

                    const SizedBox(width: 6),

                    // نص الحالة (بدون خلفية)
                    Text(
                      status,
                      style: TextStyle(
                        color: statusColor, // نفس اللون الزاهي
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

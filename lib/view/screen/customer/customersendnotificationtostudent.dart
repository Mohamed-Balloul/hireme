import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/customer/customersendnotificationtostudent_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/data/model/mypostascustomer.dart';

class CustomerSendNotificationToStudent extends StatelessWidget {
  const CustomerSendNotificationToStudent({super.key});

  @override
  Widget build(BuildContext context) {
    CustomerSendNotificationToStudentControllerImp controller =
        Get.put(CustomerSendNotificationToStudentControllerImp());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // خلفية رمادية فاتحة جداً

      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            // 1. نص التعليمات العلوي
            Container(
              padding: const EdgeInsets.only(
                  top: 50, bottom: 10, left: 20, right: 20),
              width: double.infinity,
              child: const Text(
                "يمكنك إشعار أحد الطلاب بأنك ترغب في أن يطلع على واحد أو أكثر من إعلاناتك التي سبق أن نشرتها على التطبيق",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
            ),
            // const Divider(height: 1, thickness: 1),

            // 2. حالة "لا يوجد إعلانات" أو عرض القائمة
            Expanded(
              child: myPostsAsCustomer.isEmpty
                  ? const Center(
                      child: Text(
                        "حاليا لا يوجد لديك أية إعلانات توظيف ضمن التطبيق",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // عدد الإعلانات المختارة
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                          child: Obx(() => Text(
                                "${controller.selectedAdIds.length} إعلان محدد",
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.black54),
                              )),
                        ),

                        // قائمة الإعلانات
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            itemCount: myPostsAsCustomer.length,
                            itemBuilder: (context, index) {
                              final ad = myPostsAsCustomer[index];
                              return Obx(() => _buildAdCard(ad, controller));
                            },
                          ),
                        ),
                      ],
                    ),
            ),

            // 3. زر إرسال الإشعار السفلي
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Obx(() {
                bool isActive = controller.selectedAdIds.isNotEmpty;
                return SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed:
                        isActive ? () => controller.sendNotification() : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          AppColor.primaryColor, // اللون الأخضر في الصورة
                      disabledBackgroundColor:
                          // const Color(0xFF39d32d).withOpacity(0.5),
                          Color.fromARGB(248, 237, 237, 237),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      "إرسال إشعار",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: isActive
                            ? Colors.white
                            : const Color.fromARGB(255, 185, 185, 185),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // ويجت بناء كارت الإعلان
  Widget _buildAdCard(MyPostAsCustomer ad,
      CustomerSendNotificationToStudentControllerImp controller) {
    bool isSelected = controller.isSelected(ad.id!);

    return InkWell(
      onTap: () => controller.toggleSelection(ad.id!),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColor.primaryColor : Colors.transparent,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            // أ. الـ Checkbox (مخصص كما في الصورة)
            Container(
              width: 21,
              height: 21,
              decoration: BoxDecoration(
                color: isSelected ? AppColor.primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color:
                      isSelected ? AppColor.primaryColor : Colors.grey.shade400,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 18)
                  : null,
            ),
            const SizedBox(width: 18),
// ج. الصورة الصغيرة للإعلان
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                ad.image!,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 15),
            // ب. النصوص (العنوان + الميتاداتا)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ad.title!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade100),
                          color: Colors.grey[50],
                          image: DecorationImage(
                              image: NetworkImage(ad.logo!), fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        ad.company!,
                        style: TextStyle(
                            fontSize: 11, color: Colors.grey.shade400),
                      ),
                      const SizedBox(width: 8),
                      const Text("|",
                          style: TextStyle(
                              color: Color.fromARGB(255, 220, 220, 220))),
                      const SizedBox(width: 8),
                      Text(
                        ad.time!,
                        style: TextStyle(
                            fontSize: 11, color: Colors.grey.shade400),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

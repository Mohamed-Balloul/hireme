import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:hireme/controller/company/companyhome_controller.dart';
import 'package:hireme/controller/customer/customerhome_controller.dart';
import 'package:hireme/core/constant/color.dart';
// import 'package:hireme/data/model/companypostincompanyhomemodel.dart';
import 'package:hireme/data/model/customerpostincustomerhomemodel.dart';
import 'package:hireme/view/widget/company/listsection.dart';
import 'package:hireme/view/widget/student/profile_dialogs.dart';

class CustomerPostCard extends StatelessWidget {
  final int index;
  final CustomerPostInCustomerHomeModel customerPostInCustomerHomeModel;
  // المتغيرات التي ستجلبها من الباك إند مستقبلاً
  // final String companyName;
  // final String companyLogo;
  // final String jobTitle;
  // final String timePosted;
  // final String postContent;
  // final String? postImage; // الصورة اختيارية
  // final int applicantsCount; // عدد المتقدمين
  // final bool isActive; // هل الإعلان نشط أم مغلق
  // // المتغيرات الجديدة (قوائم)
  // final List<String>? mainResponsibilities;
  // final List<String>? requirements;
  // final List<String>? benefits;
  // final String? additionalDetails;

  const CustomerPostCard({
    super.key,
    // required this.companyName,
    // required this.companyLogo,
    // required this.jobTitle,
    // required this.timePosted,
    // required this.postContent,
    // this.postImage,
    // required this.applicantsCount,
    // this.isActive = true,
    // this.mainResponsibilities,
    // this.requirements,
    // this.benefits,
    // this.additionalDetails,
    required this.index,
    required this.customerPostInCustomerHomeModel,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerHomeControllerImp>(builder: (controller) {
      return Container(
        margin: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= 1. الهيدر (معلومات الناشر) =================
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  // اللوجو
                  CircleAvatar(
                    radius: 22,
                    backgroundImage:
                        NetworkImage(customerPostInCustomerHomeModel.logo!),
                    backgroundColor: Colors.grey[200],
                  ),
                  const SizedBox(width: 12),
                  // الاسم والوقت
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          customerPostInCustomerHomeModel
                              .serviceTitle!, // العنوان الوظيفي هو الأهم
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          "${customerPostInCustomerHomeModel.publisher} • ${customerPostInCustomerHomeModel.time}",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // زر خيارات (تعديل/حذف)
                  IconButton(
                    icon: const Icon(Icons.more_horiz, color: Colors.grey),
                    onPressed: () {
                      // فتح قائمة تعديل أو حذف البوست
                      Get.bottomSheet(
                        Container(
                          color: Colors.white,
                          child: Wrap(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.delete_outline),
                                title: const Text("حذف الإعلان"),
                                onTap: () {
                                  Get.back(); // إغلاق القائمة
                                  ProfileDialogs.showConfirmDialog(
                                    title:
                                        "هل أنت متأكد أنك تريد حذف هذا الإعلان بشكل نهائي؟",
                                    onConfirm: () =>
                                        controller.deleteMyPost(index),
                                  );
                                },
                              ),
                              // خيارات أخرى...
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),

            // ================= 2. محتوى البوست (القابل للتوسيع) =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // النص المختصر (المقدمة)
                  Text(
                    customerPostInCustomerHomeModel.description!,
                    style: const TextStyle(
                        fontSize: 14, color: Colors.black87, height: 1.6),
                    // إذا كان مفتوحاً لا نضع حداً للأسطر، وإلا نكتفي بسطرين
                    maxLines: controller.isExpanded![index] ? null : 3,
                    overflow: controller.isExpanded![index]
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                  ),

                  // --- التفاصيل المخفية (تظهر فقط عند الضغط) ---
                  if (controller.isExpanded![index]) ...[
                    const SizedBox(height: 10),
                    ListSection(
                        title: "الأدوات المطلوب استخدامها:",
                        items: customerPostInCustomerHomeModel.tools),
                    // ListSection(
                    //     title: "المتطلبات:",
                    //     items: companyPostInCompanyHomeModel.requirements),
                    // ListSection(
                    //     title: "الميزات:",
                    //     items: companyPostInCompanyHomeModel.benefits),
                    if (customerPostInCustomerHomeModel.additionalDetails !=
                        null) ...[
                      const SizedBox(height: 10),
                      Text(
                        "تفاصيل إضافية:",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Text(
                        customerPostInCustomerHomeModel.additionalDetails!,
                        style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                      ),
                    ],
                    const SizedBox(height: 10),
                  ],
                  // زر (عرض المزيد / عرض أقل) - التحسين هنا
                  InkWell(
                    onTap: () {
                      controller.action(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.end, // محاذاة لليسار
                        children: [
                          Text(
                            controller.isExpanded![index]
                                ? "عرض أقل"
                                : "عرض المزيد",
                            style: const TextStyle(
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(
                              width: 4), // مسافة صغيرة بين النص والأيقونة
                          Icon(
                            controller.isExpanded![index]
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            size: 18, // تكبير الأيقونة قليلاً
                            color: AppColor.primaryColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            if (customerPostInCustomerHomeModel.image != null)
              ClipRRect(
                // إضافة قص للحواف السفلية للصورة إذا لم يكن هناك فوتر، أو لإعطاء جمالية
                // borderRadius: BorderRadius.circular(0), // اختياري
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          NetworkImage(customerPostInCustomerHomeModel.image!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

            // ================= 4. إحصائيات وتفاعل (لوحة التحكم) =================
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade100)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // عدد المتقدمين (الجزء الأهم للشركة)
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.people_alt_outlined,
                            size: 16, color: AppColor.primaryColor),
                      ),
                      const SizedBox(width: 8),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              color: Colors.black87,
                              fontFamily: 'Cairo'), // تأكد من نوع الخط
                          children: [
                            TextSpan(
                                text:
                                    "${customerPostInCustomerHomeModel.applicants} ",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            const TextSpan(
                                text: "متقدم للوظيفة",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // زر استعراض الطلبات
                  InkWell(
                    onTap: () {
                      //
                      controller.goToIncomingRequests();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "عرض الطلبات",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  // دالة القوائم المحسنة (نقاط خضراء ناعمة)
  // Widget _buildListSection(String title, List<String>? items) {
  //   if (items == null || items.isEmpty) return const SizedBox.shrink();
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const SizedBox(height: 15), // مسافة قبل العنوان
  //       Text(
  //         title,
  //         style: const TextStyle(
  //             fontWeight: FontWeight.bold,
  //             fontSize: 14,
  //             color: AppColor.primaryColor), // لون العنوان
  //       ),
  //       const SizedBox(height: 8),
  //       ...items.map((item) => Padding(
  //             padding: const EdgeInsets.only(bottom: 6), // تباعد بين العناصر
  //             child: Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 // النقطة الملونة بدلاً من النص
  //                 Padding(
  //                   padding:
  //                       const EdgeInsets.only(top: 6), // محاذاة النقطة مع السطر
  //                   child: CircleAvatar(
  //                       radius: 3,
  //                       backgroundColor:
  //                           AppColor.primaryColor.withOpacity(0.6)),
  //                 ),
  //                 const SizedBox(width: 8),
  //                 Expanded(
  //                   child: Text(
  //                     item,
  //                     style: TextStyle(
  //                         fontSize: 13, color: Colors.grey[800], height: 1.4),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           )),
  //     ],
  //   );
  // }
}

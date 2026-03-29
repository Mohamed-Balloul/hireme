import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/student/savedposts_controller.dart';
import 'package:hireme/controller/student/showonefreelancerpost_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/model/freelancerpostmodel.dart';
import 'package:hireme/view/widget/company/listsection.dart';

class ShowOneFreelancerPost extends StatelessWidget {
  final FreelancerPostModel freelancerPostModel;
  const ShowOneFreelancerPost({super.key, required this.freelancerPostModel});

  @override
  Widget build(BuildContext context) {
    ShowOneFreelancerPostControllerImp controller =
        Get.put(ShowOneFreelancerPostControllerImp());
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            const Color(0xFFF9F9F9), // خلفية رمادية فاتحة جداً لإبراز البوستات
        appBar: AppBar(
          title: Text(
            "تفاصيل العمل",
            style: TextStyle(
                color: AppColor.primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black87),
        ),
        body: SingleChildScrollView(
            child: Container(
          margin:
              const EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
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
                    InkWell(
                      onTap: () {
                        //
                        // استدعاء دالة الانتقال من المتحكم
                        controller.goToCustomerProfile(
                            freelancerPostModel.publisher!);
                      },
                      child: CircleAvatar(
                        radius: 22,
                        backgroundImage:
                            NetworkImage(freelancerPostModel.logo!),
                        backgroundColor: Colors.grey[200],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // الاسم والوقت
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            freelancerPostModel
                                .serviceTitle!, // العنوان الوظيفي هو الأهم
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // استدعاء دالة الانتقال من المتحكم
                              controller.goToCustomerProfile(
                                  freelancerPostModel.publisher!);
                            },
                            child: Text(
                              // "$companyName • $timePosted",
                              "${freelancerPostModel.publisher!} • ${freelancerPostModel.time!}",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
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
                        // إظهار قائمة خيارات
                        Get.bottomSheet(
                          Container(
                            color: Colors.white,
                            child: Wrap(
                              children: [
                                ListTile(
                                  leading: Get.find<SavedPostsControllerImp>()
                                          .isSaved(freelancerPostModel)
                                      ? const Icon(
                                          Icons.bookmark_remove_outlined)
                                      : const Icon(Icons.bookmark_add_outlined),
                                  title: Get.find<SavedPostsControllerImp>()
                                          .isSaved(freelancerPostModel)
                                      ? const Text(
                                          "إزالة من الإعلانات المحفوظة")
                                      : const Text(
                                          "إضافة إلى الإعلانات المحفوظة"),
                                  onTap: () {
                                    Get.back(); // إغلاق القائمة
                                    Get.find<SavedPostsControllerImp>()
                                        .toggleSave(freelancerPostModel);
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
                      freelancerPostModel.description!,
                      style: const TextStyle(
                          fontSize: 14, color: Colors.black87, height: 1.6),
                      // إذا كان مفتوحاً لا نضع حداً للأسطر، وإلا نكتفي بسطرين
                      maxLines: null,
                      overflow: TextOverflow.visible,
                    ),

                    //
                    const SizedBox(height: 10),
                    ListSection(
                        title: "أدوات مطلوب استخدامها:",
                        items: freelancerPostModel.tools),
                    // ListSection(
                    //     title: "المتطلبات:",
                    //     items: companiesPostModel.requirements),
                    // ListSection(
                    //     title: "الميزات:", items: companiesPostModel.benefits),
                    if (freelancerPostModel.additionalDetails != null) ...[
                      const SizedBox(height: 10),
                      Text(
                        "تفاصيل إضافية:",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Text(
                        freelancerPostModel.additionalDetails!,
                        style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                      ),
                    ],
                    const SizedBox(height: 10),
                  ],
                ),
              ),

              if (freelancerPostModel.image != null)
                ClipRRect(
                  // إضافة قص للحواف السفلية للصورة إذا لم يكن هناك فوتر، أو لإعطاء جمالية
                  // borderRadius: BorderRadius.circular(0), // اختياري
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(freelancerPostModel.image!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

              // ================= 4. إحصائيات وتفاعل (لوحة التحكم) =================
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
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
                                  // text: "$applicantsCount ",
                                  text: "${freelancerPostModel.applicants} ",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              const TextSpan(
                                  text: "متقدم للعمل",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // زر ارسال الطلبات
                    InkWell(
                      onTap: () {
                        //
                        controller.goToSendRequestToCustomer();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "إرسال طلب",
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
        )),
      ),
    );
  }
}

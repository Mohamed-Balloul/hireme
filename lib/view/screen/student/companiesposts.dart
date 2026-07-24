import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/student/companiesposts_controller.dart';
import 'package:hireme/controller/student/studenthome_controller.dart';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/view/widget/student/studentpostcard.dart';

class CompaniesPosts extends StatelessWidget {
  const CompaniesPosts({super.key});

  @override
  Widget build(BuildContext context) {
    // CompaniesPostsControllerImp controller =
    Get.put(CompaniesPostsControllerImp());
    // Get.find<CompaniesPostsControllerImp>();
    // نحتاج للوصول للهوم كنترولر لمعرفة حالة التحميل
    StudentHomeControllerImp homeController =
        Get.find<StudentHomeControllerImp>();
    return SafeArea(
        child: Scaffold(
      backgroundColor:
          const Color(0xFFF9F9F9), // خلفية رمادية فاتحة جداً لإبراز البوستات
      appBar: AppBar(
        title: Text(
          "إعلانات العمل",
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
      body: GetBuilder<CompaniesPostsControllerImp>(builder: (controller) {
        // 1. حالة التحميل: إذا كانت الهوم لا تزال تحمل والقائمة فارغة
        if (homeController.statusRequest == StatusRequest.loading &&
            controller.allCompaniesPosts.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: AppColor.primaryColor),
                SizedBox(height: 15),
                Text("جاري تحميل إعلانات الشركات...",
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
          );
        }

        // 2. حالة القائمة فارغة (بعد انتهاء التحميل)
        if (controller.allCompaniesPosts.isEmpty) {
          return const Center(child: Text("لا توجد إعلانات متاحة حالياً"));
        }
        // 3. الحالة الطبيعية: عرض الإعلانات

        return Container(
          padding: EdgeInsets.only(top: 15),
          // color: Colors.grey[100],
          child: ListView.builder(
            // itemCount: allcompaniesPosts.length,
            itemCount: controller.allCompaniesPosts.length,
            itemBuilder: (context, i) {
              return StudentPostCard(
                companiesPostModel: controller.allCompaniesPosts[i],
                index: i,
              );
            },
          ),
        );
      }),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/student/freelancerposts_controller.dart';
import 'package:hireme/controller/student/studenthome_controller.dart';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/view/widget/student/studentfreelancerpostcard.dart';

class FreelancerPosts extends StatelessWidget {
  const FreelancerPosts({super.key});

  @override
  Widget build(BuildContext context) {
    // FreelancerPostsControllerImp controller =
    Get.put(FreelancerPostsControllerImp());
    StudentHomeControllerImp homeController =
        Get.find<StudentHomeControllerImp>();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "إعلانات العمل الحر",
          style: TextStyle(),
        ),
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
      ),
      body: GetBuilder<FreelancerPostsControllerImp>(builder: (controller) {
        // 1. حالة التحميل: إذا كانت الهوم لا تزال تحمل والقائمة فارغة
        if (homeController.statusRequest == StatusRequest.loading &&
            controller.allCustomersPosts.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: AppColor.primaryColor),
                SizedBox(height: 15),
                Text("جاري تحميل إعلانات العملاء...",
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
          );
        }

        // 2. حالة القائمة فارغة (بعد انتهاء التحميل)
        if (controller.allCustomersPosts.isEmpty) {
          return const Center(child: Text("لا توجد إعلانات متاحة حالياً"));
        }
        // 3. الحالة الطبيعية: عرض الإعلانات
        return Container(
          padding: EdgeInsets.only(top: 15),
          child: ListView.builder(
            itemCount: controller.allCustomersPosts.length,
            itemBuilder: (context, i) {
              return StudentFreelancerPostCard(
                freelancerPostModel: controller.allCustomersPosts[i],
                index: i,
              );
            },
          ),
        );
      }),
    ));
  }
}

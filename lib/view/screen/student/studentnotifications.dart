import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/student/studentnotifications_controller.dart';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/view/widget/student/buildfilterbar.dart';
import 'package:hireme/view/widget/student/buildnotificationsitem.dart';

class StudentNotifications extends StatelessWidget {
  const StudentNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(StudentNotificationsControllerImp());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "الإشعارات",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder<StudentNotificationsControllerImp>(
          builder: (controller) => Column(
            children: [
              // 1. شريط الفلاتر (Filter Bar)
              BuildFilterBar(
                controller: controller,
              ),

              // 2. قائمة الإشعارات
              Expanded(
                // child: controller.filteredNotifications.isEmpty
                child: controller.statusRequest == StatusRequest.loading
                    ? const Center(
                        child:
                            CircularProgressIndicator()) // إظهار مؤشر التحميل أولاً
                    : controller.filteredNotifications.isEmpty
                        ? const Center(child: Text("لا توجد إشعارات حالياً"))
                        : ListView.builder(
                            itemCount: controller.filteredNotifications.length,
                            itemBuilder: (context, index) {
                              return BuildNotificationsItem(
                                notification:
                                    controller.filteredNotifications[index],
                                controller: controller,
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/company/companynotifications_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/view/widget/company/buildfilterbar.dart';
import 'package:hireme/view/widget/company/buildnotificationsitem.dart';

class CompanyNotifications extends StatelessWidget {
  const CompanyNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    CompanyNotificationsControllerImp controller =
        Get.put(CompanyNotificationsControllerImp());
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "الإشعارات",
          style: TextStyle(),
        ),
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder<CompanyNotificationsControllerImp>(
          builder: (controller) => Column(
            children: [
              // 1. شريط الفلاتر (Filter Bar)
              BuildFilterBar(
                controller: controller,
              ),

              // 2. قائمة الإشعارات
              Expanded(
                child: controller.filteredNotifications.isEmpty
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
    ));
  }
}

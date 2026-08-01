import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/customer/incomingrequeststocustomer_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/view/widget/customer/applicantcardmoderncustomer.dart';
// import 'package:hireme/view/widget/customer/applicantcardmodern.dart';

class IncomingApplicationsToCustomerScreen extends StatelessWidget {
  const IncomingApplicationsToCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // IncomingRequestsToCustomerControllerImp controller =
    Get.put(IncomingRequestsToCustomerControllerImp());
    return GetBuilder<IncomingRequestsToCustomerControllerImp>(
        builder: (controller) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(
            255, 245, 245, 245), // عدلت اللون قليلاً ليكون أهدأ (أفتح درجة)
        appBar: AppBar(
          title: const Text(
            "الطلبات الواردة",
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
        body: RefreshIndicator(
          color:
              AppColor.primaryColor, // لتلوين مؤشر التحديث بلون تطبيقك الأساسي
          onRefresh: () async {
            // استدعاء دالة التحديث التي أنشأناها في الـ Controller
            await controller.refreshData();
          },
          child: ListView.separated(
            // هذه الخاصية ضرورية جداً ليتمكن المستخدم من السحب لأسفل حتى لو كانت الصفحة لا تحتوي على عناصر كثيرة
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            itemCount: controller.applications.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              return ApplicantCardModern(
                index: index,
                incomingRequestsToCustomerModel: controller.applications[index],
              );
            },
          ),
        ),
      );
    });
  }
}

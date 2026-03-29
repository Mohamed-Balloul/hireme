import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/company/incomingrequests_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/view/widget/company/applicantcardmodern.dart';

class IncomingApplicationsScreen extends StatelessWidget {
  const IncomingApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    IncomingRequestsControllerImp controller =
        Get.put(IncomingRequestsControllerImp());
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
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        itemCount: incomingRequestsOnCompanyPostList.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          return ApplicantCardModern(
            image: incomingRequestsOnCompanyPostList[index].image!,
            applicantName:
                incomingRequestsOnCompanyPostList[index].applicantName!,
            expectedSalary:
                incomingRequestsOnCompanyPostList[index].expectedSalary!,
            jobLabel: incomingRequestsOnCompanyPostList[index].joblabel!,
          );
        },
      ),
    );
  }
}

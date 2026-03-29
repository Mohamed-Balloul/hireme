import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/customer/incomingrequeststocustomer_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/view/widget/company/applicantcardmodern.dart';

class IncomingApplicationsToCustomerScreen extends StatelessWidget {
  const IncomingApplicationsToCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    IncomingRequestsToCustomerControllerImp controller =
        Get.put(IncomingRequestsToCustomerControllerImp());
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
        itemCount: incomingRequestsOnCustomerPostList.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          return ApplicantCardModern(
            image: incomingRequestsOnCustomerPostList[index].image!,
            applicantName:
                incomingRequestsOnCustomerPostList[index].applicantName!,
            expectedSalary:
                incomingRequestsOnCustomerPostList[index].expectedSalary!,
            jobLabel: incomingRequestsOnCustomerPostList[index].joblabel!,
          );
        },
      ),
    );
  }
}

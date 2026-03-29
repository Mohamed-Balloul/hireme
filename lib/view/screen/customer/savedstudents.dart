import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/customer/customersavedstudents_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/view/widget/customer/savedstudentcard.dart';

class SavedStudents extends StatelessWidget {
  const SavedStudents({super.key});

  @override
  Widget build(BuildContext context) {
    // نستخدم Get.find لأننا سنقوم بعمل put للمتحكم في بداية التطبيق ليكون عالمياً
    return GetBuilder<CustomerSavedStudentsControllerImp>(
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: const Color(0xFFF9F9F9),
            appBar: AppBar(
              title: const Text("الطلاب المحفوظين",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              centerTitle: true,
              backgroundColor: const Color(0xFFF9F9F9),
              foregroundColor: AppColor.primaryColor,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Get.back(),
              ),
            ),
            body: controller.savedItems.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 15),
                    itemCount: controller.savedItems.length,
                    itemBuilder: (context, index) {
                      final item = controller.savedItems[index];

                      return StudentCard(studentProfileModel: item, ind: index);

                      return const SizedBox();
                    },
                  ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bookmark_border, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 15),
          const Text("لم تقم بعد بحفظ اي طالب",
              style: TextStyle(color: Colors.black54, fontSize: 16)),
        ],
      ),
    );
  }
}

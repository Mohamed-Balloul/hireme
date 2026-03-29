import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/student/savedposts_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/model/companiespostmodel.dart';
import 'package:hireme/data/model/freelancerpostmodel.dart';
import 'package:hireme/view/widget/student/savedfreelancerpostcard.dart';
import 'package:hireme/view/widget/student/savedpostcard.dart';

class SavedPosts extends StatelessWidget {
  const SavedPosts({super.key});

  @override
  Widget build(BuildContext context) {
    // نستخدم Get.find لأننا سنقوم بعمل put للمتحكم في بداية التطبيق ليكون عالمياً
    return GetBuilder<SavedPostsControllerImp>(
      // init: SavedPostsControllerImp(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: const Color(0xFFF9F9F9),
            appBar: AppBar(
              title: const Text("الإعلانات المحفوظة",
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
                      if (item is CompaniesPostModel) {
                        return SavedPostCard(
                            companiesPostModel: item, index: index);
                      } else if (item is FreelancerPostModel) {
                        return SavedFreelancerPostCard(
                            freelancerPostModel: item, index: index);
                      }
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
          const Text("لم تقم بعد بحفظ اي إعلان",
              style: TextStyle(color: Colors.black54, fontSize: 16)),
        ],
      ),
    );
  }
}

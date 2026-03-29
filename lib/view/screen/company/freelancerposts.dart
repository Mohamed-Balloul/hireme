import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/student/freelancerposts_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/data/model/freelancerpostmodel.dart';
import 'package:hireme/view/widget/checkout/custombutton.dart';

class FreelancerPosts extends StatelessWidget {
  const FreelancerPosts({super.key});

  @override
  Widget build(BuildContext context) {
    FreelancerPostsControllerImp controller =
        Get.put(FreelancerPostsControllerImp());
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: freelancerPostsList.length,
          itemBuilder: (context, i) {
            final FreelancerPostModel selectedPost = freelancerPostsList[i];
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[100],
                border: Border.all(
                  width: 2,
                  color: AppColor.primaryColor,
                ),
              ),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: Row(
                      children: [
                        const Text("الناشر: "),
                        Text(freelancerPostsList[i].publisher!),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: Row(
                      children: [
                        const Text("اسم الخدمة: "),
                        Text(freelancerPostsList[i].serviceTitle!),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: CustomButton(
                      text: "رؤية كامل التفاصيل",
                      onPressed: () {
                        controller.goToPostDetails(selectedPost);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ));
  }
}

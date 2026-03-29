import 'package:hireme/controller/student/freelancerpostdetails_controller.dart';
import 'package:hireme/controller/student/freelancerposts_controller.dart';
import 'package:hireme/core/constant/color.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/data/model/freelancerpostmodel.dart';
import 'package:hireme/view/widget/checkout/custombutton.dart';

class FreelancerPostDetails extends StatelessWidget {
  final FreelancerPostModel freelancerPostModel;
  const FreelancerPostDetails({super.key, required this.freelancerPostModel});

  @override
  Widget build(BuildContext context) {
    FreelancerPostDetailsControllerImp controller =
        Get.put(FreelancerPostDetailsControllerImp());
    FreelancerPostsControllerImp postController =
        Get.put(FreelancerPostsControllerImp());
    return SafeArea(
      child: Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Row(
                    children: [
                      const Text("الناشر: "),
                      Text(freelancerPostModel.publisher!),
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
                      Text(freelancerPostModel.serviceTitle!),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                          "الأدوات والملفات المطلوب استخدامها لإنجاز الخدمة: "),
                      ...List.generate(freelancerPostModel.tools!.length, (i) {
                        return Text(
                            "${i + 1}) " + freelancerPostModel.tools![i]);
                      }),
                    ],
                  ),
                ),
                //
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Row(
                    children: [
                      const Text("موعد تسليم الخدمة: "),
                      Text(freelancerPostModel.date!),
                    ],
                  ),
                ),
                //
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Row(
                    children: [
                      const Text("وصف الخدمة : "),
                      Text(freelancerPostModel.description!),
                    ],
                  ),
                ),

                //
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Row(
                    children: [
                      const Text("الملفات المرفقة: "),
                      Text(freelancerPostModel.files!),
                    ],
                  ),
                ),
                //
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: Center(
                    child: CustomButton(
                      text: "إرسال طلب لأداء الخدمة",
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

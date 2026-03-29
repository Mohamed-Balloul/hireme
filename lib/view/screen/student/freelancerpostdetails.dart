import 'package:hireme/controller/student/freelancerpostdetails_controller.dart';
import 'package:hireme/controller/student/freelancerposts_controller.dart';
import 'package:hireme/core/constant/color.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/data/model/freelancerpostmodel.dart';
import 'package:hireme/view/widget/auth/custombuttonauth.dart';
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
        backgroundColor:
            // Color.fromARGB(255, 243, 255, 250), // خلفية فاتحة جداً لكسر الجمود
            Colors.grey[100], // خلفية فاتحة جداً لكسر الجمود

        appBar: AppBar(
          title: Text(
            "كامل تفاصيل الإعلان",
            style: TextStyle(),
          ),
          foregroundColor: Colors.white,
          centerTitle: true,
          backgroundColor: AppColor.primaryColor,
        ),
        body: Column(children: [
          Expanded(
              child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. الهيدر: الشعار والعنوان
                Center(
                  child: Column(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 10)
                          ],

                          // image: DecorationImage(
                          //     image: AssetImage(
                          //         "assets/google_logo.png")) // شعار الشركة
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.orange.shade50,
                          child: Icon(
                            Icons.person,
                            size: 33,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        freelancerPostModel.serviceTitle!,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "الناشر: ",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          Text(
                            // "Google • California, USA", // اسم الشركة والموقع
                            freelancerPostModel.publisher!,
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                //--
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                    top: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "الأدوات والملفات المطلوب استخدامها لإنجاز الخدمة: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ...List.generate(freelancerPostModel.tools!.length, (i) {
                        return Text(
                            "${i + 1}) " + freelancerPostModel.tools![i]);
                      }),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "وصف الخدمة:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(freelancerPostModel.description!)
                    ],
                  ),
                ),
                //
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "موعد تسليم الخدمة:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(freelancerPostModel.date!),
                    ],
                  ),
                ),
                //
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 25,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "الملفات المرفقة:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(freelancerPostModel.files!),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomButtonAuth(
                    text: "إرسال طلب لأداء الخدمة",
                    onPressed: () {
                      controller.goToSendRequestToCustomer();
                    },
                  ),
                ),
              ],
            ),
          ))
        ]),
      ),
    );
  }
}

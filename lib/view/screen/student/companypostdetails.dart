import 'package:hireme/core/constant/color.dart';
import 'package:hireme/controller/student/companiesposts_controller.dart';
import 'package:hireme/controller/student/companypostdetails_controller.dart';
import 'package:hireme/data/model/companypostmodel.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/view/widget/auth/custombuttonauth.dart';

class CompanyPostDetails extends StatelessWidget {
  final CompanyPostModel companyPostModel;
  const CompanyPostDetails({super.key, required this.companyPostModel});

  @override
  Widget build(BuildContext context) {
    CompanyPostDetailsControllerImp controller =
        Get.put(CompanyPostDetailsControllerImp());
    CompaniesPostsControllerImp postController =
        Get.put(CompaniesPostsControllerImp());
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
                          backgroundColor: Colors.blue.shade50,
                          child: Icon(
                            Icons.business,
                            size: 33,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        companyPostModel.jobTitle!,
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
                            companyPostModel.publisher!,
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
                        "المهام الرئيسية: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ...List.generate(
                          companyPostModel.mainResponsibilities!.length, (i) {
                        return Text("${i + 1}) " +
                            companyPostModel.mainResponsibilities![i]);
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
                        "المتطلبات: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ...List.generate(companyPostModel.requirements!.length,
                          (i) {
                        return Text(
                            "${i + 1}) " + companyPostModel.requirements![i]);
                      }),
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
                        "الميزات: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ...List.generate(companyPostModel.benefits!.length, (i) {
                        return Text(
                            "${i + 1}) " + companyPostModel.benefits![i]);
                      }),
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
                        "تفاصيل إضافية: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(companyPostModel.additionalDetails!),
                    ],
                  ),
                ),
                // // الموعد النهائي
                // Row(
                //   children: const [
                //     Icon(Icons.timer_outlined,
                //         color: Colors.redAccent, size: 20),
                //     SizedBox(width: 8),
                //     Text(
                //       "ينتهي التقديم في: 20/11/2025",
                //       style: TextStyle(
                //           color: Colors.redAccent, fontWeight: FontWeight.bold),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 20),
                //
                // 4. الزر السفلي المثبت
                // SizedBox(
                //   width: double.infinity,
                //   height: 55,
                //   child: ElevatedButton(
                //     onPressed: () {},
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor:
                //           AppColor.primaryColor, // لون التطبيق الأساسي
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(15)),
                //       elevation: 0,
                //     ),
                //     child: const Text(
                //       "إرسال طلب إجراء مقابلة عمل",
                //       style: TextStyle(
                //           fontSize: 18,
                //           fontWeight: FontWeight.bold,
                //           color: Colors.white),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomButtonAuth(
                    text: "إرسال طلب إجراء مقابلة عمل",
                    onPressed: () {
                      controller.goToSendRequestToCompany(companyPostModel);
                    },
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(
                //     top: 10,
                //   ),
                //   child: Center(
                //     child: CustomButton(
                //       text: "إرسال طلب إجراء مقابلة عمل",
                //       onPressed: () {
                //         controller.goToSendRequestToCompany(companyPostModel);
                //       },
                //     ),
                //   ),
                // ),
              ],
            ),
          ))
        ]),
      ),
    );
  }
}

//
 
// spare
              // Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(8),
              //     color: Colors.grey[100],
              //     border: Border.all(
              //       width: 2,
              //       color: AppColor.primaryColor,
              //     ),
              //   ),
              //   margin: const EdgeInsets.all(10),
              //   padding: const EdgeInsets.all(10),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //     //--
              //     // 1. الهيدر: الشعار والعنوان
              //     Center(
              //       child: Column(
              //         children: [
              //           Container(
              //             height: 80,
              //             width: 80,
              //             decoration: BoxDecoration(
              //               color: Colors.white,
              //               shape: BoxShape.circle,
              //               boxShadow: [
              //                 BoxShadow(color: Colors.black12, blurRadius: 10)
              //               ],
              //               // image: DecorationImage(
              //               //     image: AssetImage(
              //               //         "assets/google_logo.png")) // شعار الشركة
              //             ),
              //           ),
              //           const SizedBox(height: 15),
              //           const Text(
              //             "Flutter Developer",
              //             style: TextStyle(
              //                 fontSize: 22, fontWeight: FontWeight.bold),
              //           ),
              //           const SizedBox(height: 5),
              //           const Text(
              //             "Google • California, USA", // اسم الشركة والموقع
              //             style: TextStyle(fontSize: 14, color: Colors.grey),
              //           ),
              //         ],
              //       ),
              //     ),
              //     //--

              //     Padding(
              //       padding: const EdgeInsets.only(
              //         bottom: 10,
              //       ),
              //       child: Row(
              //         children: [
              //           const Text("الناشر: "),
              //           Text(companyPostModel.publisher!),
              //         ],
              //       ),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.only(
              //         bottom: 10,
              //       ),
              //       child: Row(
              //         children: [
              //           const Text("المسمى الوظيفي: "),
              //           Text(companyPostModel.jobTitle!),
              //         ],
              //       ),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.only(
              //         bottom: 10,
              //       ),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           const Text("المهام الرئيسية: "),
              //           ...List.generate(
              //               companyPostModel.mainResponsibilities!.length,
              //               (i) {
              //             return Text("${i + 1}) " +
              //                 companyPostModel.mainResponsibilities![i]);
              //           }),
              //         ],
              //       ),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.only(
              //         bottom: 10,
              //       ),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           const Text("المتطلبات: "),
              //           ...List.generate(
              //               companyPostModel.requirements!.length, (i) {
              //             return Text("${i + 1}) " +
              //                 companyPostModel.requirements![i]);
              //           }),
              //         ],
              //       ),
              //     ),
              //     //
              //     Padding(
              //       padding: const EdgeInsets.only(
              //         bottom: 10,
              //       ),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           const Text("الميزات: "),
              //           ...List.generate(companyPostModel.benefits!.length,
              //               (i) {
              //             return Text(
              //                 "${i + 1}) " + companyPostModel.benefits![i]);
              //           }),
              //         ],
              //       ),
              //     ),
              //     //
              //     Padding(
              //       padding: const EdgeInsets.only(
              //         bottom: 10,
              //       ),
              //       child: Row(
              //         children: [
              //           const Text("تفاصيل إضافية: "),
              //           Text(companyPostModel.additionalDetails!),
              //         ],
              //       ),
              //     ),
              //     //
              //     Padding(
              //       padding: const EdgeInsets.only(
              //         top: 10,
              //       ),
              //       child: Center(
              //         child: CustomButton(
              //           text: "إرسال طلب إجراء مقابلة عمل",
              //           onPressed: () {
              //             controller
              //                 .goToSendRequestToCompany(companyPostModel);
              //           },
              //         ),
              //       ),
              //     ),
              // ],
              // ),
              // )

                  
                
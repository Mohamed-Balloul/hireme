import 'package:hireme/controller/company/companypostdetails_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/data/model/companypostmodel.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/view/widget/checkout/custombutton.dart';

class CompanyPostsDetails extends StatelessWidget {
  // final CompanyPostModel companyPostModel;
  const CompanyPostsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    CompanyPostsDetailsControllerImp controller =
        Get.put(CompanyPostsDetailsControllerImp());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "hireMe",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          foregroundColor: Colors.white,
          centerTitle: true,
          backgroundColor: AppColor.primaryColor,
        ),
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
              side: BorderSide(
                width: 2,
                color: AppColor.primaryColor,
              )),
          // backgroundColor: AppColor.litegrey,
          backgroundColor: AppColor.primaryColor,
          onPressed: () {
            controller.goToAddCompanyPost();
          },
          child: Icon(
            Icons.add,
            // color: AppColor.primaryColor,
            color: Colors.white,
          ),
        ),
        body: Container(
          child: ListView.builder(
            itemCount: companyPostsList.length,
            itemBuilder: (context, i) {
              final CompanyPostModel selectedPost = companyPostsList[i];
              return Padding(
                padding: const EdgeInsets.all(15),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 15,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.badge_outlined,
                                    color: AppColor.primaryColor,
                                    // Icons.work_outline,
                                    size: 18,
                                  ),
                                  const Text(
                                    " المسمى الوظيفي :",
                                    style: TextStyle(
                                      color: AppColor.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Text(companyPostsList[i].jobTitle!),
                            ],
                          ),
                        ),
                        // Divider(),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 15,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.task_alt,
                                    color: AppColor.primaryColor,
                                    // Icons.assignment_outlined,
                                    size: 18,
                                  ),
                                  const Text(
                                    " المهام الرئيسية :",
                                    style: TextStyle(
                                      color: AppColor.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              ...List.generate(
                                  companyPostsList[i]
                                      .mainResponsibilities!
                                      .length, (j) {
                                return Text("${j + 1}) " +
                                    companyPostsList[i]
                                        .mainResponsibilities![j]);
                              }),
                            ],
                          ),
                        ),
                        // Divider(),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 15,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    color: AppColor.primaryColor,
                                    // Icons.fact_check_outlined,
                                    Icons.school_outlined,
                                    size: 18,
                                  ),
                                  const Text(
                                    " المتطلبات :",
                                    style: TextStyle(
                                      color: AppColor.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              ...List.generate(
                                  companyPostsList[i].requirements!.length,
                                  (j) {
                                return Text("${j + 1}) " +
                                    companyPostsList[i].requirements![j]);
                              }),
                            ],
                          ),
                        ),
                        // Divider(),
                        //
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 15,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    // Icons.volunteer_activism_outlined,
                                    color: AppColor.primaryColor,
                                    Icons.star_border,
                                    size: 18,
                                  ),
                                  const Text(
                                    " الميزات :",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              ...List.generate(
                                  companyPostsList[i].benefits!.length, (j) {
                                return Text("${j + 1}) " +
                                    companyPostsList[i].benefits![j]);
                              }),
                            ],
                          ),
                        ),
                        // Divider(),
                        //
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 15,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: AppColor.primaryColor,
                                    // Icons.edit_note,
                                    // Icons.delete_outline,
                                    size: 18,
                                  ),
                                  const Text(
                                    " تفاصيل إضافية :",
                                    style: TextStyle(
                                      color: AppColor.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Text(companyPostsList[i].additionalDetails!),
                            ],
                          ),
                        ),
                        // Divider(),
                        //
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 20,
                                left: 20,
                              ),
                              child: Center(
                                child: CustomButton(
                                  text: "تعديل ",
                                  onPressed: () {
                                    controller.goToEditPost();
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 20,
                              ),
                              child: Center(
                                child: CustomButton(
                                  text: "حذف",
                                  onPressed: () {},
                                ),
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 20),
                            //   child: Container(
                            //     decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(6),
                            //         border: Border.all(
                            //           width: 2,
                            //           color: AppColor.primaryColor,
                            //         )),
                            //     child: const Padding(
                            //       padding: EdgeInsets.all(3.5),
                            //       child: Icon(
                            //         Icons.edit,
                            //         color: AppColor.greenblack,
                            //         // color: AppColor.primaryColor,
                            //         size: 15,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

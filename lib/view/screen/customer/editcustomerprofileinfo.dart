import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/customer/editcustomerprofileinfo_controller.dart';
import 'package:hireme/core/class/handlingdataview.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/core/functions/validinput.dart';

import 'package:hireme/view/widget/student/buildsectioncard.dart';
import 'package:hireme/view/widget/student/buildtextfield.dart';

class EditCustomerProfileInfo extends StatelessWidget {
  const EditCustomerProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    //
    EditCustomerProfileControllerImp controller =
        Get.put(EditCustomerProfileControllerImp());

    return Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        appBar: AppBar(
          title: const Text("تعديل المعلومات الشخصية",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.5,
          foregroundColor: Colors.black,
          actions: [
            TextButton(
              onPressed: () => controller.saveAll(),
              child: const Text("حفظ",
                  style: TextStyle(
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold)),
            )
          ],
        ),
        body: GetBuilder<EditCustomerProfileControllerImp>(
          builder: (controller) => HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: Form(
              key: controller.formState,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // 1. القسم الأول: المعلومات العامة
                    BuildSectionCard(
                      title: "المعلومات العامة",
                      icon: Icons.person_outline,
                      children: [
                        BuildTextField(
                          valid: (val) {
                            return validInput(val!, 1, 30, "all");
                          },
                          label: "الاسم الكامل",
                          controller: controller.nameController,
                          icon: Icons.person,
                          keyboardType: TextInputType.text,
                        ),
                        BuildTextField(
                          valid: (val) {
                            return validInput(val!, 1, 100, "all");
                          },
                          label: "المسمى الوظيفي",
                          controller: controller.jobController,
                          icon: Icons.work_outline,
                          keyboardType: TextInputType.text,
                        ),
                        BuildTextField(
                          valid: (val) {
                            return validInput(val!, 1, 1000, "all");
                          },
                          label: "النبذة التعريفية",
                          controller: controller.bioController,
                          icon: Icons.description,
                          // maxLines: 3

                          keyboardType: TextInputType.text,
                        ),
                        // BuildTextField(
                        //     valid: (val) {
                        //       return validInput(val!, 6, 100, "email");
                        //     },
                        //     label: "البريد الإلكتروني",
                        //     controller: controller.emailController,
                        //     icon: Icons.email_outlined,
                        //     keyboardType: TextInputType.emailAddress),
                        BuildTextField(
                            valid: (val) {
                              return validInput(val!, 6, 100, "phone");
                            },
                            label: "رقم الهاتف",
                            controller: controller.phoneController,
                            icon: Icons.phone_android,
                            keyboardType: TextInputType.phone),
                        BuildTextField(
                          valid: (val) {
                            return validInput(val!, 2, 100, "all");
                          },
                          label: "مكان الإقامة",
                          controller: controller.locationController,
                          icon: Icons.location_on_outlined,
                          keyboardType: TextInputType.text,
                        ),
                      ],
                    ),

                    // 2. القسم الثاني: الإحصائيات والروابط
                    BuildSectionCard(
                      title: "المزيد عنك",
                      icon: Icons.bar_chart,
                      children: [
                        BuildTextField(
                            valid: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return null; // يسمح بحفظ البيانات إذا تُرك الحقل فارغاً
                              }
                              return validInput(val, 1, 100, "url");
                            },
                            label: "رابط GitHub",
                            controller: controller.githubController,
                            keyboardType: TextInputType.text,
                            icon: Icons.code),
                        BuildTextField(
                            valid: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return null; // يسمح بحفظ البيانات إذا تُرك الحقل فارغاً
                              }
                              return validInput(val, 1, 100, "url");
                            },
                            label: "رابط LinkedIn",
                            controller: controller.linkedinController,
                            keyboardType: TextInputType.text,
                            icon: Icons.link),
                      ],
                    ),

                    // 4. القسم الرابع: التعليم
                    BuildSectionCard(
                      title: "التعليم",
                      icon: Icons.school_outlined,
                      children: [
                        // GetBuilder<EditCustomerProfileControllerImp>(
                        //     builder: (_) {
                        //   return SwitchListTile(
                        //     title: const Text("هل تخرجت؟",
                        //         style: TextStyle(fontSize: 14)),
                        //     value: controller.isGraduated,
                        //     activeColor: AppColor.primaryColor,
                        //     onChanged: (val) {
                        //       controller.isGraduated = val;
                        //       controller.update();
                        //     },
                        //   );
                        // }),
                        BuildTextField(
                          valid: (val) {
                            return validInput(val!, 2, 30, "major");
                          },
                          label: "اسم الكلية - الجامعة",
                          controller: controller.collegeController,
                          icon: Icons.account_balance,
                          keyboardType: TextInputType.text,
                        ),
                        // BuildTextField(
                        //     valid: (val) {
                        //       return validInput(val!, 2, 30, "major");
                        //     },
                        //     label: "اسم الجامعة",
                        //     controller: controller.uniController,
                        //     icon: Icons.location_city,
                        //     keyboardType: TextInputType.text),
                      ],
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
